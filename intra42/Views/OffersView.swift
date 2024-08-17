//
//  OffersView.swift
//  intra42
//
//  Created by Mickaël on 02/07/2024.
//

import Foundation
import SwiftUI


@Observable class OffersModel {
    var data: ContentData<[Offer]> = .loading
    
    func load() async {
        do {
            let offers = try await APIClient.offers()
            data = .success(offers)
        } catch {
            print(error)
            data = .error(error)
        }
    }
}

struct OffersView: View {
    @State var model: OffersModel
    
    var body: some View {
        NavigationSplitView {
            Group {
                switch model.data {
                case .loading:
                    Text("Loading...")
                case .success(let offers):
                    List(offers) { offer in
                        NavigationLink {
                            OfferView(model: .init(), id: offer.id)
                        } label: {
                            OfferRow(id: offer.id, title: offer.title, littleDescription: offer.littleDescription, contractType: offer.contractType, validAt: offer.validAt)
                        }
                    }
                case .error( _):
                    Text("Error")
                }
            }.navigationTitle("Companies")
        } detail: {
            Text("Select a user")
        }
        .onAppear(perform: onAppear)
    }
    
    // MARK: - Actions
    private func onAppear() {
        Task {
            await model.load()
        }
    }
}

#Preview {
    OffersView(model: .init())
}
