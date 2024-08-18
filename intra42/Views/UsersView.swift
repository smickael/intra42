//
//  UsersView.swift
//  intra42
//
//  Created by Mickaël on 15/02/2024.
//

import SwiftUI

enum ContentData<T> {
    case success(_ data: T)
    case loading
    case error(_ error: Error)
}

@Observable class UsersModel {
    var data: ContentData<[User]> = .loading
    var searchText: String = ""
    
    func load() async {
        do {
            let users = try await APIClient.users(search: searchText.trimmingCharacters(in: .whitespaces).isEmpty ? nil : searchText.trimmingCharacters(in: .whitespaces).lowercased(with: .autoupdatingCurrent))
            data = .success(users)
        } catch {
            print(error)
            data = .error(error)
        }
    }
}

struct UsersView: View {
    @State var model: UsersModel
    
    var body: some View {
        NavigationSplitView {
            Group {
                switch model.data {
                case .loading:
                    Spinner()
                case .success(let users):
                    List(users) { user in
                        NavigationLink {
                            UserView(model: .init(), id: user.id)
                        } label: {
                            UserRow(id: user.id, usualFullName: user.usualFullName, login: user.login, imageURL: user.image?.link)
                        }
                    }
                case .error( _):
                    Group {
                        Text("You're too fast for me!")
                            .font(.headline)
                        Text("By default, this app has limited\n to 2 requests/second")
                            .font(.subheadline)
                            .monospaced()
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                }
            }.navigationTitle("Users")
        } detail: {
            Text("Select a user")
        }
        .searchable(text: $model.searchText)
        .onAppear(perform: onAppear)
        .onChange(of: model.searchText) {
            search(text: model.searchText)
        }
    }
    
    // MARK: - Actions
    private func onAppear() {
        Task {
            await model.load()
        }
    }
    
    private func search(text: String) {
        print("Searching...")
        Task {
            await model.load()
        }
    }
}

#Preview {
    UsersView(model: .init())
}
