//
//  SafariView.swift
//  intra42
//
//  Created by Mickaël on 26/08/2024.
//

import SwiftUI
import SafariServices

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

fileprivate class SFDelegate: NSObject, SFSafariViewControllerDelegate {
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        print(URL)
    }
}
