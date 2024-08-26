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
    let authenticated = false
    
    var body: some Scene {
        WindowGroup {
            if authenticated {
                TabView {
                    UsersView(model: .init())
                        .tabItem {
                            Label("Search Profiles", systemImage: "person.2.fill")
                        }
                    ProjectsView(model: .init())
                        .tabItem {
                            Label("Projects", systemImage: "tray.full.fill")
                        }
                    OffersView(model: .init())
                        .tabItem {
                            Label("Companies", systemImage:
                                    "case.fill")
                        }
                }
            } else {
                LoginView()
            }
        }
    }
}
