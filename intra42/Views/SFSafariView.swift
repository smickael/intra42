//
//  SafariView.swift
//  intra42
//
//  Created by Mickaël on 26/08/2024.
//

import SwiftUI
import SafariServices

// SwiftUI View for SFSafariViewController to show a Safari browser in the app
struct SFSafariView: UIViewControllerRepresentable {
    
    let url: URL
    fileprivate let delegate = SFDelegate()
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        let viewController: SFSafariViewController = SFSafariViewController(url: url)
        viewController.delegate = delegate
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariView>) {
    }
}

// A custom delegate class to handle SFSafariViewController delegate methods
fileprivate class SFDelegate: NSObject, SFSafariViewControllerDelegate {
    // Called when the Safari view redirects to a different URL
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo url: URL) {
        print(url)
        // Check if the redirected URL is "example.com" and contains a "code" param.
        guard url.host() == "example.com",
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let param = components.queryItems?.first(where: { item in
                  item.name == "code"
              })
        else {
            return
        }
        
        print(param)
        
        // If the "code" parameter has a value and is not empty, authenticate using the code
        if let code = param.value, !code.isEmpty {
            Task {
                do {
                    try await APIClient.authenticate(.authorizationCode(code))
                    print("Authenticated successfully")
                }
                catch {
                    print("Failed to authenticate \(error)")
                }
            }
        }
    }
}
