//
//  Campus.swift
//  intra42
//
//  Created by Mickaël on 29/06/2024.
//

import Foundation

let countriesISO: [String: String] = [
    "Angola": "AO",
    "Armenia": "AM",
    "Australia": "AU",
    "Austria": "AT",
    "Belgium": "BE",
    "Brazil": "BR",
    "Canada": "CA",
    "Czech Republic": "CZ",
    "Finland": "FI",
    "France": "FR",
    "Germany": "DE",
    "Italy": "IT",
    "Japan": "JP",
    "Jordan": "JO",
    "Korea, Republic of": "KR",
    "Lebanon": "LB",
    "Luxembourg": "LU",
    "Madagascar": "MG",
    "Malaysia": "MY",
    "Morocco": "MA",
    "Netherlands": "NL",
    "Palestine, State of": "PS",
    "Poland": "PL",
    "Portugal": "PT",
    "Singapore": "SG",
    "Spain": "ES",
    "Switzerland": "CH",
    "Thailand": "TH",
    "Turkey": "TR",
    "United Arab Emirates": "AE",
    "United Kingdom": "GB"
]

func flag(from countryCode: String) -> String {
    let base: UInt32 = 127397
    var scalarView = String.UnicodeScalarView()
    for code in countryCode.uppercased().unicodeScalars {
        scalarView.append(UnicodeScalar(base + code.value)!)
    }
    return String(scalarView)
}
