//
//  Project.swift
//  intra42
//
//  Created by Mickaël on 02/04/2024.
//

import Foundation

// MARK: - ProjectDetails
struct ProjectDetails: Identifiable, Codable {
    typealias ID = Int
    let id: ID
    let name, slug: String
    let difficulty: Int?
    let parent: Parent
    let children: [Parent]
    let createdAt, updatedAt: String
    let exam: Bool
    let gitID: Int?
    let repository: String?
    let cursus: [ProjectCursus]
    let campus: [ProjectCampus]
    let projectSessions: [ProjectSession]

    enum CodingKeys: String, CodingKey {
        case id, name, slug, difficulty, parent, children
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case exam
        case gitID = "git_id"
        case repository, cursus, campus
        case projectSessions = "project_sessions"
    }
}

// MARK: - Campus
struct ProjectCampus: Codable {
    let id: Int
    let name, timeZone: String
    let language: Language
    let usersCount: Int
    let vogsphereID: Int?
    let country, address, zip, city: String
    let website: String
    let facebook, twitter: String
    let active, campusPublic: Bool
    let emailExtension: String
    let defaultHiddenPhone: Bool

    enum CodingKeys: String, CodingKey {
        case id, name
        case timeZone = "time_zone"
        case language
        case usersCount = "users_count"
        case vogsphereID = "vogsphere_id"
        case country, address, zip, city, website, facebook, twitter, active
        case campusPublic = "public"
        case emailExtension = "email_extension"
        case defaultHiddenPhone = "default_hidden_phone"
    }
}



// MARK: - Parent
struct Parent: Codable {
    let name: String
    let id: Int
    let slug: String
    let url: String
}

// MARK: - Cursus
struct ProjectCursus: Codable {
    let id: Int
    let name: CursusName
    let slug: Slug
    let kind: String

    enum CodingKeys: String, CodingKey {
        case id
        case name, slug, kind
    }
}


enum CursusName: String, Codable {
    case dataSciencePiscine = "Data science piscine"
    case h2S = "H2S"
    case the42Cursus = "42cursus"
    case the42Zip = "42.zip"
}

enum Slug: String, Codable {
    case dataSciencePiscine = "data-science-piscine"
    case h2S = "h2s"
    case the42Cursus = "42cursus"
    case the42Zip = "42-zip"
}

// MARK: - ProjectSession
struct ProjectSession: Codable {
    let id: Int
    let solo: Bool?
    let beginAt, endAt: String?
    let estimateTime: EstimateTime?
    let difficulty: Int?
    let objectives: [String]
    let description: String
    let durationDays: JSONNull?
    let terminatingAfter: Int?
    let projectID: Int
    let campusID, cursusID: Int?
    let createdAt, updatedAt: String
    let maxPeople: JSONNull?
    let isSubscriptable: Bool
    let scales: [Scale]
    let uploads: [JSONAny]
    let teamBehaviour: TeamBehaviour
    let commit: String?

    enum CodingKeys: String, CodingKey {
        case id, solo
        case beginAt = "begin_at"
        case endAt = "end_at"
        case estimateTime = "estimate_time"
        case difficulty, objectives, description
        case durationDays = "duration_days"
        case terminatingAfter = "terminating_after"
        case projectID = "project_id"
        case campusID = "campus_id"
        case cursusID = "cursus_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case maxPeople = "max_people"
        case isSubscriptable = "is_subscriptable"
        case scales, uploads
        case teamBehaviour = "team_behaviour"
        case commit
    }
}

enum EstimateTime: String, Codable {
    case the0Days = "0 days"
    case the16Hours = "16 hours"
    case the1Day = "1 day"
    case the28Days = "28 days"
    case the2Days = "2 days"
    case the30Days = "30 days"
}

// MARK: - Scale
struct Scale: Codable {
    let id, correctionNumber: Int
    let isPrimary: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case correctionNumber = "correction_number"
        case isPrimary = "is_primary"
    }
}

enum TeamBehaviour: String, Codable {
    case byRule = "by_rule"
    case user = "user"
}

typealias Projects = [ProjectDetails]

