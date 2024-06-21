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
    
    private var auth: Auth? = nil
    private let baseURL = URL(string: "https://api.intra.42.fr")!
    private typealias Token = String
    
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
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let payload = try JSONDecoder().decode(AuthTokenResponse.self, from: data)
        
        self.auth = .init(token: payload.access_token, expiration: .init(timeIntervalSinceNow: TimeInterval(payload.expires_in)))
        return payload.access_token
        
    }
    
    func users() async throws -> [User] {
        let usersURL = URL(string: "/v2/users", relativeTo: baseURL)!
        
        
        var userRequest = URLRequest(url: usersURL)
        userRequest.setValue("Bearer \(try await getToken())", forHTTPHeaderField: "Authorization")
        
        let (userData, _) = try await URLSession.shared.data(for: userRequest)
        
        let users = try JSONDecoder().decode([User].self, from: userData)
        
        return users
    }
    
    func user(id: UserDetails.ID) async throws -> UserDetails {
        let userURL = URL(string: "/v2/users/\(id)", relativeTo: baseURL)!

        var userRequest = URLRequest(url: userURL)
        userRequest.setValue("Bearer \(try await getToken())", forHTTPHeaderField: "Authorization")
        
        let (userData, _) = try await URLSession.shared.data(for: userRequest)
        
        let user = try JSONDecoder().decode(UserDetails.self, from: userData)
        
        return user
    }
    
//    func searchUser(username) async throws -> UserDetails {
//        let baseURL = URL(string: "https://api.intra.42.fr")!
//        
//        let userURL = URL(string: "/v2/users/\(id)", relativeTo: baseURL)!
//        
//        let tokenURL = URL(string: "/oauth/token?grant_type=client_credentials&client_id=u-s4t2ud-8f0aa2a7726a169bbd4b24d2c0761d0419f8b364b0599730712422e2c4aaf9b4&client_secret=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", relativeTo: baseURL)!
//        
//        
//        var request = URLRequest(url: tokenURL)
//    }
    
    func projects() async throws -> [ProjectDetails] {
        
        let projectsURL = URL(string: "/v2/projects", relativeTo: baseURL)!
        
        var projectRequest = URLRequest(url: projectsURL)
        projectRequest.setValue("Bearer \(try await getToken())", forHTTPHeaderField: "Authorization")
        
        let (projectData, _) = try await URLSession.shared.data(for: projectRequest)
        
        let projects = try JSONDecoder().decode([ProjectDetails].self, from: projectData)
        
        return projects
    }
}
