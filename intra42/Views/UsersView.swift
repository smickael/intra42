//
//  UsersView.swift
//  intra42
//
//  Created by Mickaël on 15/02/2024.
//

import SwiftUI

// Enum of the different states of fetching datas
enum ContentData<T> {
    case success(_ data: T)
    case loading
    case error(_ error: Error)
}

// Model class for managing the state and datas of UsersView
@Observable class UsersModel {
    var data: ContentData<[User]> = .loading
    var searchText: String = ""
    
    func load() async {
        data = .loading
        let trimmedSearchText = searchText.trimmingCharacters(in: .whitespaces).lowercased(with: .autoupdatingCurrent)
        
        if trimmedSearchText.isEmpty {
            // If the search text is empty, return an empty list
            data = .success([])
            return
        }
        
        do {
            let users = try await APIClient.users(search: trimmedSearchText)
            data = .success(users)
        } catch {
            data = .error(error)
        }
    }
}

// View that displays the list of users and handles user search
struct UsersView: View {
    @State var model: UsersModel
    
    var body: some View {
        NavigationSplitView {
            Group {
                switch model.data {
                    case .loading:
                        Spinner()
                    case .success(let users):
                        if users.isEmpty &&
                            !model.searchText.isEmpty {
                            Group {
                                Text("User not found")
                                    .font(.headline)
                                Text("Maybe you thought about your imaginary friend.. 🤔")
                                    .font(.subheadline)
                                    .monospaced()
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                        } else if users.isEmpty && model.searchText.isEmpty {
                            logoView()
                        } else {
                            List(users) { user in
                                NavigationLink {
                                    UserView(model: .init(), id: user.id)
                                } label: {
                                    UserRow(id: user.id, usualFullName: user.usualFullName, login: user.login, imageURL: user.image?.link)
                                }
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
    
    // MARK: - Logo View for Empty List
    @ViewBuilder
    private func logoView() -> some View {
        Image("42_logo")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
            .padding()
    }
}

#Preview {
    UsersView(model: .init())
}
