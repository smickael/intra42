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
    let id: Int
        let name, slug: String
        let difficulty: Int?
        let parent: Child?
        let children: [Child]
        let attachments: [JSONAny]
        let createdAt, updatedAt: String
        let exam: Bool
        let gitID: Int?
        let repository: String?
        let cursus: [Cursus]
        let campus: [Campus]
        let videos: [JSONAny]
        let projectSessions: [ProjectSession]

        enum CodingKeys: String, CodingKey {
            case id, name, slug, difficulty, parent, children, attachments
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case exam
            case gitID = "git_id"
            case repository, cursus, campus, videos
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
    let emailExtension: String?
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

// MARK: - Child
struct Child: Codable {
    let name: String
    let id: Int
    let slug: String
    let url: String
}

// MARK: - Cursus
struct ProjectCursus: Codable {
    let id: Int
    let name, slug, kind: String

    enum CodingKeys: String, CodingKey {
        case id
        case name, slug, kind
    }
}

// MARK: - ProjectSession
struct ProjectSession: Codable {
    let id: Int
    let solo: Bool?
    let beginAt, endAt: String?
    let estimateTime: String?
    let difficulty: Int?
    let objectives: [String]?
    let description: String?
    let durationDays: Int?
    let terminatingAfter: Int?
    let projectID: Int
    let campusID, cursusID: Int?
    let createdAt, updatedAt: String
    let maxPeople: Int?
    let isSubscriptable: Bool
    let scales: [Scale]
    let uploads: [JSONAny]
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
        case commit
    }
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

typealias Projects = [ProjectDetails]

