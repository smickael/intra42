//
//  Offer.swift
//  intra42
//
//  Created by Mickaël on 02/07/2024.
//

import Foundation

// MARK: - Offer
struct Offer: Identifiable, Codable {
    typealias ID = Int
    let id: Int
    let title, littleDescription, bigDescription, salary: String
    let contractType: ContractType
    let email: String
    let fullAddress: String
    let validAt, invalidAt: String
    let minDuration: Int
    let maxDuration: Int?
    let document: OfferDocument
    let slug, createdAt: String
    let proID: Int?
    let companyID: Int
    let target: Target
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case littleDescription = "little_description"
        case bigDescription = "big_description"
        case salary
        case contractType = "contract_type"
        case email
        case fullAddress = "full_address"
        case validAt = "valid_at"
        case invalidAt = "invalid_at"
        case minDuration = "min_duration"
        case maxDuration = "max_duration"
        case document, slug
        case createdAt = "created_at"
        case proID = "pro_id"
        case companyID = "company_id"
        case target
    }
}

enum ContractType: String, Codable {
    case apprenticeShip = "apprentice_ship"
    case cdd = "cdd"
    case cddPartiel = "cdd_partiel"
    case cdi = "cdi"
    case freelance = "freelance"
    case stage = "stage"
    case stagePartiel = "stage_partiel"
}

// MARK: - OfferDocument
struct OfferDocument: Codable {
    let document: DocumentDocument
}

// MARK: - DocumentDocument
struct DocumentDocument: Codable {
    let url: String?
}

enum Target: String, Codable {
    case student = "student"
    case studentAndAlumni = "student_and_alumni"
}

typealias Offers = [Offer]
