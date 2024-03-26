//
//  UsersView.swift
//  intra42
//
//  Created by Mickaël on 15/02/2024.
//

import SwiftUI

struct UserRow: View {
    let id: Int
    let email, login: String
    
    var body: some View {
        VStack {
            Text(email)
            Text(login)
        }
    }
}

struct UsersView: View {
    @State var users: [User] = []
    
    var body: some View {
        VStack {
            ForEach(users) { user in
                UserRow(id: user.id, email: user.email, login: user.login)
            }
            
        }
        .padding()
        .onAppear {
            users = [
                .init(id: 12, email: "test@test.fr", login: "mflorent", firstName: "Marcus", lastName: "Florentin"),
                .init(id: 13, email: "test@test.fr", login: "kacoulib", firstName: "Karim", lastName: "Coulibaly"),
            ]
        }
    }
}

#Preview {
    UsersView()
}

#Preview {
    UserRow(id: 123, email: "test@test.fr", login: "smickael")
}
