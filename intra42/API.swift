//
//  API.swift
//  intra42
//
//  Created by Mickaël on 26/03/2024.
//

import Foundation

class API {
    private struct Auth {
        let token: String
        let expiration: Date
    }
    
    struct ResponseError : Decodable, Error {
        let status: Int
        let error: String
    }
    
    private var auth: Auth? = nil
    private let baseURL = URL(string: "https://api.intra.42.fr")!
    private typealias Token = String
    
    
    let session = URLSession(configuration: .ephemeral)
    private func getToken() async throws -> Token {
        if let auth, auth.expiration.timeIntervalSinceNow > 0 {
            print("token reuse")
            return auth.token
        }
        
        print("new token")
        
        struct AuthTokenResponse : Decodable {
            let access_token : String
            let expires_in: Int
        }
        
        let tokenURL = URL(string: "/oauth/token?grant_type=client_credentials&client_id=u-s4t2ud-8f0aa2a7726a169bbd4b24d2c0761d0419f8b364b0599730712422e2c4aaf9b4&client_secret=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", relativeTo: baseURL)!
        
        
        var request = URLRequest(url: tokenURL)
        
        request.httpMethod = "POST"
        request.httpBody = "{}".data(using: .utf8)
        
        let (data, _) = try await session.data(for: request)
        
        let payload = try JSONDecoder().decode(AuthTokenResponse.self, from: data)
        
        self.auth = .init(token: payload.access_token, expiration: .init(timeIntervalSinceNow: TimeInterval(payload.expires_in)))
        return payload.access_token
        
    }
    
    func users(search: String?) async throws -> [User] {
        var components = URLComponents(string: "v2/users")!
        
        components.queryItems = .init()
        
        if let search {
            let min = search.dropLast(1)
            let max = search + "z"

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
    
    func user(id: UserDetails.ID) async throws -> UserDetails {
        let userURL = URL(string: "/v2/users/\(id)", relativeTo: baseURL)!
        
        var userRequest = URLRequest(url: userURL)
        userRequest.setValue("Bearer \(try await getToken())", forHTTPHeaderField: "Authorization")
        
        let (userData, _) = try await session.data(for: userRequest)
        
        let user = try JSONDecoder().decode(UserDetails.self, from: userData)
        
        return user
    }
    
    func searchUser(username: String) async throws -> UserDetails {
        let baseURL = URL(string: "https://api.intra.42.fr")!
        
        let userURL = URL(string: "/v2/users/?range%5Blogin%5D=smi,smiz", relativeTo: baseURL)!
        
        var userSearchRequest = URLRequest(url: userURL)
        userSearchRequest.setValue("Bearer \(try await getToken())", forHTTPHeaderField: "Authorization")
        
        let (userSearchData, _) = try await session.data(for: userSearchRequest)
        let userSearch = try JSONDecoder().decode(UserDetails.self, from: userSearchData)
        
        return userSearch
    }
    
    func projects() async throws -> [ProjectDetails] {
        
        let projectsURL = URL(string: "/v2/projects?page%5Bsize%5D=200", relativeTo: baseURL)!
        
        var projectRequest = URLRequest(url: projectsURL)
        projectRequest.setValue("Bearer \(try await getToken())", forHTTPHeaderField: "Authorization")
        
        let (projectData, _) = try await session.data(for: projectRequest)
        
        let projects = try JSONDecoder().decode([ProjectDetails].self, from: projectData)
        
        return projects
    }
    
    func offers() async throws -> [Offer] {
        
        let offersURL = URL(string: "/v2/offers", relativeTo: baseURL)!
        
        var offersRequest = URLRequest(url: offersURL)
        offersRequest.setValue("Bearer \(try await getToken())", forHTTPHeaderField: "Authorization")
        
        let (offersData, _) = try await session.data(for: offersRequest)
        
        let offers = try JSONDecoder().decode([Offer].self, from: offersData)
        
        return offers
    }
    
    func offer(id: Offer.ID) async throws -> Offer {
        let offerURL = URL(string: "/v2/offers/\(id)", relativeTo: baseURL)!
        
        var offerRequest = URLRequest(url: offerURL)
        offerRequest.setValue("Bearer \(try await getToken())", forHTTPHeaderField: "Authorization")
        
        let (offerData, _) = try await session.data(for: offerRequest)
        
        let offer = try JSONDecoder().decode(Offer.self, from: offerData)
        
        return offer
    }
}
