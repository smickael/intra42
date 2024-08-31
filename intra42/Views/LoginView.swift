//
//  LoginView.swift
//  intra42
//
//  Created by Mickaël on 26/08/2024.
//

import SwiftUI

struct LoginView: View {
    @State var showURL = false
    @EnvironmentObject var api: API
    
    var body: some View {
        VStack {
            Text("Login to")
                .font(.system(size: 20))
            Text("INTRA 42")
                .font(.system(size: 30))
                .fontDesign(.monospaced)
                .fontWeight(.bold)
            Button("Sign In", systemImage: "arrow.up") {
                print("Sign In button pressed")
                showURL = true
            }
            .labelStyle(.titleAndIcon)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .tint(.black)
        }
        .sheet(isPresented: $showURL) {
            SFSafariView(url: api.authorizeURL())
        }
    }
}

#Preview {
    LoginView()
}



