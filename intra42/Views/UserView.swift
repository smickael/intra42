//
//  UserView.swift
//  intra42
//
//  Created by Mickaël on 26/03/2024.
//

import SwiftUI

@Observable class UserModel {
    var user: UserDetails? = nil
    
    func load(id: UserDetails.ID) async {
        do {
            user = try await APIClient.user(id: id)
            print(user)
        } catch {
            print(error)
        }
    }
}

struct UserView: View {
    @State var model: UserModel
    let id: UserDetails.ID
    @State private var selectedCursusIndex = 0
    
    
    
    var body: some View {
        VStack {
            if let user = model.user {
                VStack(alignment: .leading) {
                    ProfileUserHeader(usualFullName: user.usualFullName, login: user.login, imageURL: user.image?.link)
                    Picker("Cursus", selection: $selectedCursusIndex) {
                        ForEach(0..<user.cursusUsers.count, id: \.self) { index in
                            Text(user.cursusUsers[index].cursus.name)
                                .tag(index)
                        }
                    }
                    .pickerStyle(.segmented)
                    HStack(alignment: .top) {
                        Spacer()
                        if let selectedCursusUser = user.cursusUsers[safe: selectedCursusIndex] {
                            VStack {
                                Text("Level")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                                    .textCase(.uppercase)
                                    .padding(.bottom, 12)
                                Text("\(Int(selectedCursusUser.level)) - \(Int((selectedCursusUser.level.truncatingRemainder(dividingBy: 1)) * 100))%")
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                            }
                        }
                        Spacer()
                        VStack {
                            Text("Wallet")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                                .textCase(.uppercase)
                                .padding(.bottom, 12)
                            Text("\(user.wallet)")
                                .font(.system(size: 16, weight: .bold, design: .monospaced))
                        }
                        Spacer()
                        VStack {
                            Text("Evaluation")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                                .textCase(.uppercase)
                            Text("points")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                                .textCase(.uppercase)
                                .padding(.bottom, 1)
                            Text("\(user.correctionPoint)")
                                .font(.system(size: 16, weight: .bold, design: .monospaced))
                        }
                        Spacer()
                    }
                    .padding(.top, 16)
                }.padding()
                Tabs(options: ["Projects"], optionsContents: [AnyView(UserProjectsList(projects: model.user?.projectsUsers ?? []))])
                Spacer()
            }
            else {
                Text("Loading")
            }
        }
        .onAppear(perform: onAppear)
    }
    private func onAppear() {
        Task {
            await model.load(id: self.id)
        }
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    UserView(model: .init(), id: 182477)
}
