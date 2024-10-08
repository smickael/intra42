//
//  API.swift
//  intra42
//
//  Created by Mickaël on 26/03/2024.
//

import Foundation
import Security

// MARK: - API Class
class API: ObservableObject {
    
    // MARK: - Init
    // Initialize the API with credentials to get a token
    init() {
        self.auth = nil
        self.client_id = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as! String
        self.client_secret = Bundle.main.object(forInfoDictionaryKey: "CLIENT_SECRET") as! String
        self.redirect_uri = "https://example.com"
        
        Task {
            try await self.getToken()
        }
    }
    
    // MARK: - Global variables
    // Client informations and redirect URL for OAuth
    private let client_id: String
    private let client_secret: String
    private let redirect_uri: String
    
    // MARK: - Structures
    struct Auth {
        let token: String
        let expiration: Date
    }
    
    struct ResponseError : Decodable, Error {
        let status: Int
        let error: String
    }
    
    enum AuthenticationError: Error {
        case tokenExpired
        case dataStorage
        case keychain
        case noRefreshToken
        case deleteRefreshToken
    }
    
    struct AuthCodeTokenResponse: Decodable {
        let access_token: String
        let expires_in: Int
        let token_type: String
        let refresh_token: String
        let scope: String
        let created_at: Date
        let secret_valid_until: Date
    }
    
    struct AuthData: Codable {
        let refresh_token: String
        let scope: String
        let created_at: Date
        let secret_valid_until: Date
    }
    
    @Published var auth: Auth? = nil
    
    private let baseURL = URL(string: "https://api.intra.42.fr")!
    typealias Token = String
    
    // Session with ephemeral storage parameter for better security
    let session = URLSession(configuration: .ephemeral)
    
    enum GrantType {
        case authorizationCode(_ code: String)
        case refreshToken(_ token: String)
    }
    
    // MARK: - Authenticate
    // Function to handle authentication regarding the GrantType (authorizationCode or refreshToken)
    @discardableResult
    func authenticate(_ grantType: GrantType) async throws -> Token {
        var components = URLComponents(string: "/oauth/token")!
        
        // Common query items for both authorization code and refresh token requests
        components.queryItems = [
            .init(name: "client_id", value: client_id),
            .init(name: "client_secret", value: client_secret),
            .init(name: "redirect_uri", value: redirect_uri),
            
        ]
        
        // Add specific query items based on the grant type
        switch grantType {
            case .authorizationCode(let code):
                components.queryItems?.append(contentsOf: [.init(name: "grant_type", value: "authorization_code"), .init(name: "code", value: code)])
            case .refreshToken(let token):
                components.queryItems?.append(contentsOf: [.init(name: "grant_type", value: "refresh_token"), .init(name: "refresh_token", value: token)])
        }
        
        let tokenURL = components.url(relativeTo: baseURL)!
        
        var request = URLRequest(url: tokenURL)
        request.httpMethod = "POST"
        
        let (data, _) = try await session.data(for: request)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let payload = try decoder.decode(AuthCodeTokenResponse.self, from: data)
        
        // Store the refresh token securely
        try storeAuthData(response: payload)
        
        // Update the auth property with the new token
        DispatchQueue.main.async {
            self.auth = Auth(token: payload.access_token, expiration: .init(timeIntervalSinceNow: TimeInterval(payload.expires_in)))
        }
        return payload.access_token
    }
    
    // MARK: - Security
    // Function for constructing the OAuth authorization URL
    func authorizeURL() -> URL {
        var components = URLComponents(string: "/oauth/authorize")!
        
        components.queryItems = [
            .init(name: "client_id", value: client_id),
            .init(name: "response_type", value: "code"),
            .init(name: "redirect_uri", value: redirect_uri),
            
        ]
        
        return components.url(relativeTo: baseURL)!
    }
    
    // MARK: - Store to Keychain
    // Function to store auth data in the Keychain
    func storeAuthData(response: AuthCodeTokenResponse) throws {
        let authData = AuthData(refresh_token: response.refresh_token, scope: response.scope, created_at: response.created_at, secret_valid_until: response.secret_valid_until)
        let data = try JSONEncoder().encode(authData)
        
        // Remove old refresh token from Keychain if exists
        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "refresh_token",
        ]
        
        let deleteQueryStatus = SecItemDelete(deleteQuery as CFDictionary)
        guard deleteQueryStatus == errSecSuccess || deleteQueryStatus == errSecItemNotFound else {
            print(deleteQueryStatus)
            throw AuthenticationError.deleteRefreshToken
        }
        
        // Add the new refresh token to Keychain
        let addquery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "refresh_token",
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        let status = SecItemAdd(addquery as CFDictionary, nil)
        guard status == errSecSuccess else {
            print(status)
            throw AuthenticationError.keychain
        }
    }
    
    // MARK: - Get Token
    // Function to get the access token, using refresh token if needed
    private func getToken() async throws -> Token {
        // If the current token is still valid, use this token
        if let auth, auth.expiration.timeIntervalSinceNow > 0 /* put 7100s if you want to see access_token expiring in one minutes thirty seconds */ {
            print("token reuse")
            return auth.token
        }
        
        // Else get refresh token from Keychain
        let getquery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "refresh_token",
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(getquery as CFDictionary, &item)
        guard status == errSecSuccess,
              let data = item as? Data
        else {
            DispatchQueue.main.async {
                self.auth = nil
            }
            throw AuthenticationError.noRefreshToken
        }
        
        print("Refresh Token found")
        
        // Try to use the refresh token to get a new access token
        do {
            let authData = try JSONDecoder().decode(AuthData.self, from: data)
            guard authData.secret_valid_until > Date.now else { throw AuthenticationError.tokenExpired }
            
            let token = try await authenticate(.refreshToken(authData.refresh_token))
            
            print("New Access Token created")
            
            return token
        } catch {
            DispatchQueue.main.async {
                self.auth = nil
            }
            throw error
        }
    }
    
    // MARK: - Fetch users
    // Function to fetch users from the API
    func users(search: String?) async throws -> [User] {
        var components = URLComponents(string: "v2/users")!
        
        components.queryItems = .init()
        components.queryItems?.append(.init(name: "sort", value: "login"))
        
        if let search {
            let min = search
            let max = search + "zzz"
            
            components.queryItems?.append(.init(name: "range[login]", value: "\(min),\(max)"))
        }
        
        let url = components.url(relativeTo: baseURL)!
        var userRequest = URLRequest(url: url)
        userRequest.setValue("Bearer \(try await getToken())", forHTTPHeaderField: "Authorization")
        
        let (userData, response) = try await session.data(for: userRequest)
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw try JSONDecoder().decode(API.ResponseError.self, from: userData)
        }
        
        let users = try JSONDecoder().decode([User].self, from: userData)
        
        return users
    }
    
    // MARK: - Fetch user data
    // Function to fetch a single user's datas from the API
    func user(id: UserDetails.ID) async throws -> UserDetails {
        let userURL = URL(string: "/v2/users/\(id)", relativeTo: baseURL)!
        
        var userRequest = URLRequest(url: userURL)
        userRequest.setValue("Bearer \(try await getToken())", forHTTPHeaderField: "Authorization")
        
        let (userData, _) = try await session.data(for: userRequest)
        
        let user = try JSONDecoder().decode(UserDetails.self, from: userData)
        
        return user
    }
    
    // MARK: - Fetch projects
    // Function to fetch projects from the API
    func projects() async throws -> [ProjectDetails] {
        
        let projectsURL = URL(string: "/v2/projects?page%5Bsize%5D=200", relativeTo: baseURL)!
        
        var projectRequest = URLRequest(url: projectsURL)
        projectRequest.setValue("Bearer \(try await getToken())", forHTTPHeaderField: "Authorization")
        
        let (projectData, _) = try await session.data(for: projectRequest)
        
        let projects = try JSONDecoder().decode([ProjectDetails].self, from: projectData)
        
        return projects
    }
    
    // MARK: - Fetch offers
    // Function to fetch companies offers from the API
    func offers() async throws -> [Offer] {
        
        let offersURL = URL(string: "/v2/offers", relativeTo: baseURL)!
        
        var offersRequest = URLRequest(url: offersURL)
        offersRequest.setValue("Bearer \(try await getToken())", forHTTPHeaderField: "Authorization")
        
        let (offersData, _) = try await session.data(for: offersRequest)
        
        let offers = try JSONDecoder().decode([Offer].self, from: offersData)
        
        return offers
    }
    
    // MARK: - Fetch offer datas
    // Function to fetch a single offer's datas from the API
    func offer(id: Offer.ID) async throws -> Offer {
        let offerURL = URL(string: "/v2/offers/\(id)", relativeTo: baseURL)!
        
        var offerRequest = URLRequest(url: offerURL)
        offerRequest.setValue("Bearer \(try await getToken())", forHTTPHeaderField: "Authorization")
        
        let (offerData, _) = try await session.data(for: offerRequest)
        
        let offer = try JSONDecoder().decode(Offer.self, from: offerData)
        
        return offer
    }
}
