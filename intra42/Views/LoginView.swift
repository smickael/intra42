//
//  LoginView.swift
//  intra42
//
//  Created by Mickaël on 26/08/2024.
//

import SwiftUI

struct LoginView: View {
    @State var showURL = false
    
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
            SFSafariView(url: .init(string: "https://api.intra.42.fr/oauth/authorize?client_id=u-s4t2ud-8f0aa2a7726a169bbd4b24d2c0761d0419f8b364b0599730712422e2c4aaf9b4&redirect_uri=https%3A%2F%2Fexample.com&response_type=code")!)
        }
    }
}

#Preview {
    LoginView()
}
