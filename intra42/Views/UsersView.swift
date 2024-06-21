//
//  UsersView.swift
//  intra42
//
//  Created by Mickaël on 15/02/2024.
//

import SwiftUI

@Observable class UsersModel {
    var users = [User]()
    
    func load() async {
        do {
            users = try await APIClient.users()
        } catch {
            print(error)
        }
    }
}

struct UsersView: View {
    @State var model: UsersModel
    
    var body: some View {
        NavigationSplitView {
            List(model.users) { user in
                NavigationLink {
                    UserView(model: .init(), id: user.id)
                } label: {
                    UserRow(id: user.id, usualFullName: user.usualFullName, login: user.login, imageURL: user.image?.link)
                }
            }
            .navigationTitle("Users")
        } detail: {
            Text("Select a user")
        }
        .onAppear(perform: onAppear)
    }
    
    // MARK: - Actions
    private func onAppear() {
        Task {
            await model.load()
        }
    }
}

#Preview {
    UsersView(model: .init())
}
