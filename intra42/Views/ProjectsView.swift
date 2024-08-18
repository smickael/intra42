//
//  ProjectsView.swift
//  intra42
//
//  Created by Mickaël on 02/04/2024.
//

import SwiftUI

enum ContentProject<T> {
    case success(_ data: T)
    case loading
    case error(_ error: Error)
}

@Observable class ProjectsModel {
    var data: ContentProject<[ProjectDetails]> = .loading
    
    func load() async {
        do {
            let projects = try await APIClient.projects()
            data = .success(projects)
        } catch {
            print(error)
            data = .error(error)
        }
    }
}

struct ProjectsView: View {
    @State var model: ProjectsModel
    
    var body: some View {
        NavigationView {
            Group {
                switch model.data {
                case .loading:
                    Spinner()
                case .success(let projects):
                    List(projects) { project in
                        HStack {
                            Text(project.name)
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
