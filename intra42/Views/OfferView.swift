//
//  OfferView.swift
//  intra42
//
//  Created by Mickaël on 03/07/2024.
//

import SwiftUI

@Observable class OfferModel {
    var offer: Offer? = nil
    
    func load(id: Offer.ID) async {
        do {
            offer = try await APIClient.offer(id: id)
        } catch {
            print(error)
        }
    }
}

struct OfferView: View {
    @State var model: OfferModel
    let id: Offer.ID
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            if let offer = model.offer {
                VStack(alignment: .leading) {
                    Text(offer.title)
                        .fontWidth(.expanded)
                        .foregroundStyle(.primary)
                        .fontWeight(.semibold)
                        .font(.title)
                    Text("**Salary**: \(offer.salary)")
                        .padding(.vertical, 8)
                    Text(offer.littleDescription)
                        .padding(.vertical, 8)
                    Text(.init(offer.bigDescription))
                        .padding(.vertical, 8)
                    Link(destination: URL(string: "mailto:\(offer.email)")!) {
                        Text("Contact \(offer.email)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(colorScheme == .dark ? Color.white : Color.black)
                            .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                            .fontWeight(.semibold)
                            .clipShape(Capsule())
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: onAppear)
        .padding(16)
    }
    
    private func onAppear() {
        Task {
            await model.load(id: self.id)
        }
    }
}

#Preview {
    OfferView(model: .init(), id: 22781)
}
