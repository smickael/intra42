//
//  UserProjectsList.swift
//  intra42
//
//  Created by Mickaël on 04/04/2024.
//

import SwiftUI

struct UserProjectsList: View {
    var projects: [ProjectsUser]
    
    var body: some View {
        List {
            Section {
                ForEach(projects) { project in
                    ProjectRow(project: project)
                }
            }
        }.listStyle(SidebarListStyle())
    }
}

#Preview {
    
    UserProjectsList(projects: [
        ProjectsUser(
            id: 2146197,
            occurrence: 0,
            finalMark: 104,
            status: .finished,
            validated: true,
            currentTeamID: 3529123,
            project: Project(
                id: 1479,
                name: "ft_ls",
                slug: "42cursus-ft_ls",
                parentID: nil
            ),
            cursusIDS: [21],
            markedAt: "2018-09-16T18:47:19.000Z",
            marked: true,
            retriableAt: "2021-04-03T03:02:29.817Z",
            createdAt: "2021-04-03T03:02:29.817Z",
            updatedAt: "2021-04-03T03:02:29.817Z"
        ),
        ProjectsUser(
            id: 2146197,
            occurrence: 0,
            finalMark: 104,
            status: .finished,
            validated: true,
            currentTeamID: 3529123,
            project: Project(
                id: 1479,
                name: "ft_ls",
                slug: "42cursus-ft_ls",
                parentID: nil
            ),
            cursusIDS: [21],
            markedAt: "2018-09-16T18:47:19.000Z",
            marked: true,
            retriableAt: "2021-04-03T03:02:29.817Z",
            createdAt: "2021-04-03T03:02:29.817Z",
            updatedAt: "2021-04-03T03:02:29.817Z"
        )
    ])
}
