//
//  Campus.swift
//  intra42
//
//  Created by Mickaël on 29/06/2024.
//

import Foundation

//// MARK: - Campus
//struct Campus: Codable {
//    let id: Int
//    let name, timeZone: String
//    let language: Language
//    let usersCount: Int
//    let vogsphereID: Int?
//    let country, address, zip, city: String
//    let website: String
//    let facebook, twitter: String
//    let active, campusPublic: Bool
//    let emailExtension: String?
//    let defaultHiddenPhone: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case timeZone = "time_zone"
//        case language
//        case usersCount = "users_count"
//        case vogsphereID = "vogsphere_id"
//        case country, address, zip, city, website, facebook, twitter, active
//        case campusPublic = "public"
//        case emailExtension = "email_extension"
//        case defaultHiddenPhone = "default_hidden_phone"
//    }
//}
//
//typealias Campuses = [Campus]


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
