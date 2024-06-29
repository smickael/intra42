//
//  CountryFlag.swift
//  intra42
//
//  Created by Mickaël on 29/06/2024.
//

import SwiftUI

import SwiftUI

struct CountryFlag: View {
    let countryName: String
    let city: String
    
    @State private var isShowingPopover = false
    
    var body: some View {
        Button(emojiFlag(for: countryName) ?? "🏳️") {
            self.isShowingPopover = true
        }
        .popover(
            isPresented: $isShowingPopover, arrowEdge: .bottom
        ) {
            Text("\(countryName), \(city)")
                .padding(.vertical, -10)
                .padding(.horizontal, 20)
                .presentationDetents([.medium, .large])
                .presentationCompactAdaptation(.none)
        }
    }
    
    private func emojiFlag(for countryName: String) -> String? {
        guard let countryCode = countriesISO[countryName] else { return nil }
        return flag(from: countryCode)
    }
}

#Preview {
    VStack {
        CountryFlag(countryName: "United States", city: "Fremont")
        CountryFlag(countryName: "France", city: "Paris")
        CountryFlag(countryName: "Germany", city: "Berlin")
    }
}
