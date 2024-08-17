//
//  OfferRow.swift
//  intra42
//
//  Created by Mickaël on 02/07/2024.
//

import SwiftUI

struct OfferRow: View {
    let id: Int
    let title, littleDescription: String
    let contractType: ContractType
    let validAt: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWidth(.expanded)
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
            Text(littleDescription)
                .padding(.vertical, 8)
            Text(formatDate(from: validAt))
                .fontDesign(.monospaced)
                .font(.caption)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
    }
    
    func formatDate(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MM/dd/yyyy"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return "Invalid date"
        }
    }
}

#Preview {
    OfferRow(id: 1, title: "[Alternance] Developer Fullstack", littleDescription: "Développez vos compétences au sein d'une startup à impact ! ", contractType: .apprenticeShip, validAt: "2024-07-02T08:00:00.000Z")
}
