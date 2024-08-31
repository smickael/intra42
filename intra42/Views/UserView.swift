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
        } catch {
            print("ERROR UserView", error)
        }
    }
}

struct UserView: View {
    @State var model: UserModel
    let id: UserDetails.ID
    @State private var selectedCursusID: Int = 0
    
    var selectedCursusName: String {
        model.user?.cursusUsers.first(where: { $0.cursus.id == selectedCursusID })?.cursus.name ?? "Unknown"
    }
    
    var selectedCursusSkills: [Skill] {
        guard let user = model.user,
              let selectedCursusUser = user.cursusUsers.first(where: { $0.cursus.id == selectedCursusID }) else {
            return []
        }
        return selectedCursusUser.skills
    }
    
    var body: some View {
        VStack {
            if let user = model.user {
                VStack(alignment: .leading) {
                    ProfileUserHeader(usualFullName: user.usualFullName, login: user.login, imageURL: user.image?.link, location: user.location, campus: user.campus)
                    Picker("Cursus", selection: $selectedCursusID) {
                        ForEach(user.cursusUsers, id: \.cursus.id) { cursusUser in
                            Text(cursusUser.cursus.name)
                                .tag(cursusUser.cursus.id)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text(selectedCursusName)
                        .font(.headline)
                        .padding(.vertical, 4)
                        .fontDesign(.monospaced)
                        .frame(maxWidth: .infinity, alignment: .center)
                    HStack(alignment: .top) {
                        Spacer()
                        if let selectedCursusUser = user.cursusUsers.first(where: { $0.cursus.id == selectedCursusID }) {
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
                Tabs(options: ["Projects", "Skills"], optionsContents: [
                    AnyView(UserProjectsList(projects: model.user?.projectsUsers ?? [], selectedCursusID: selectedCursusID)),
                    AnyView(SkillsChart(skills: selectedCursusSkills))
                ])
                Spacer()
            } else {
                Spinner()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: onAppear)
    }
    
    private func onAppear() {
        Task {
            await model.load(id: self.id)
            if let user = model.user, let firstCursusID = user.cursusUsers.first?.cursus.id {
                selectedCursusID = firstCursusID
            }
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
