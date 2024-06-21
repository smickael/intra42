//
//  intra42App.swift
//  intra42
//
//  Created by Mickaël on 15/02/2024.
//

import SwiftUI
let APIClient = API()

@main
struct intra42App: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                UsersView(model: .init())
                    .tabItem {
                        Label("Received", systemImage: "person.2.fill")
                    }
                ProjectsView(model: .init())
                    .tabItem {
                        Label("Projects", systemImage: "tray.full.fill")
                    }
            }
        }
    }
}
