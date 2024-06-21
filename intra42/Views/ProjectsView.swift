//
//  ProjectsView.swift
//  intra42
//
//  Created by Mickaël on 02/04/2024.
//

import SwiftUI

@Observable class ProjectsModel {
    var projects = [ProjectDetails]()
    
    func load() async {
        do {
            projects = try await APIClient.projects()
            print(projects)
        } catch {
            print(error)
        }
    }
}

struct ProjectsView: View {
    @State var model: ProjectsModel
    
    var body: some View {
        NavigationView {
            List(model.projects) { project in
                HStack {
                    Text(project.name)
                }
            }
            .navigationTitle("Projects")
            .onAppear(perform: onAppear)
        }
    }
    // MARK: - Actions
    private func onAppear() {
        Task {
            await model.load()
        }
    }
}

#Preview {
    ProjectsView(model: .init())
}
