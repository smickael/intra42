//
//  User.swift
//  intra42
//
//  Created by Mickaël on 16/02/2024.
//

import Foundation

// MARK: - User
struct User: Codable, Identifiable {
    typealias ID = Int
    let id: ID
    let email, login, firstName, lastName: String
    let usualFullName: String
    //    let usualFirstName: String?
    //    let url: String
    //    let phone, displayname, kind: String
    let image: UserImage?
    //    let staff: Bool
    //    let correctionPoint: Int
    //    let poolMonth, poolYear: String
        let location: String?
        let wallet: Int
    //    let anonymizeDate, dataErasureDate, createdAt, updatedAt: String
    //    let alumni, active: Bool
    let campus: [Campus]?
    let projectsUsers: [ProjectsUser]?
    
    enum CodingKeys: String, CodingKey {
        case id, email, login, image
        case firstName = "first_name"
        case lastName = "last_name"
        case usualFullName = "usual_full_name"
        case projectsUsers = "projects_users"
        //        case usualFirstName = "usual_first_name"
        //        case url, phone, displayname, kind, image
        //        case staff = "staff?"
        //        case correctionPoint = "correction_point"
        //        case poolMonth = "pool_month"
        //        case poolYear = "pool_year"
                case location, wallet
        //        case anonymizeDate = "anonymize_date"
        //        case dataErasureDate = "data_erasure_date"
        //        case createdAt = "created_at"
        //        case updatedAt = "updated_at"
        //        case alumni = "alumni?"
        //        case active = "active?"
        case campus
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Achievement
struct Achievement: Codable {
    let id: Int
    let name, description: String
    let tier: Tier
    let kind: Kind
    let visible: Bool
    let image: String
    let nbrOfSuccess: Int?
    let usersURL: String

    enum CodingKeys: String, CodingKey {
        case id, name, description, tier, kind, visible, image
        case nbrOfSuccess = "nbr_of_success"
        case usersURL = "users_url"
    }
}

enum Kind: String, Codable {
    case pedagogy = "pedagogy"
    case project = "project"
    case scolarity = "scolarity"
    case social = "social"
}

enum Tier: String, Codable {
    case easy = "easy"
    case medium = "medium"
    case none = "none"
}

// MARK: - Campus
struct Campus: Codable {
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

// MARK: - Language
struct Language: Codable {
    let id: Int
    let name: String
    let identifier: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, identifier
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - CampusUser
struct CampusUser: Codable {
    let id, userID, campusID: Int
    let isPrimary: Bool
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case campusID = "campus_id"
        case isPrimary = "is_primary"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct UserDetails: Codable, Identifiable, Hashable {
    typealias ID = Int
    let id: ID
    let email, login, firstName, lastName: String
    let usualFullName: String
    let usualFirstName: String?
    let url: String
    let phone, displayname, kind: String
    let image: UserImage?
    let staff: Bool
    let correctionPoint: Int
    let poolMonth, poolYear, location: String?
    let wallet: Int
    let anonymizeDate, dataErasureDate, createdAt, updatedAt: String?
    let alumni, active: Bool
    let cursusUsers: [CursusUser]
    let projectsUsers: [ProjectsUser]
    let campus: [Campus]
    
    enum CodingKeys: String, CodingKey {
        case id, email, login
        case firstName = "first_name"
        case lastName = "last_name"
        case usualFullName = "usual_full_name"
        case usualFirstName = "usual_first_name"
        case url, phone, displayname, kind, image
        case staff = "staff?"
        case correctionPoint = "correction_point"
        case poolMonth = "pool_month"
        case poolYear = "pool_year"
        case location, wallet
        case anonymizeDate = "anonymize_date"
        case dataErasureDate = "data_erasure_date"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case alumni = "alumni?"
        case active = "active?"
        case cursusUsers = "cursus_users"
        case projectsUsers = "projects_users"
        case campus
    }
    
    static func == (lhs: UserDetails, rhs: UserDetails) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct UserImage: Codable, Hashable {
    let link: URL?
}

// MARK: - CursusUser
struct CursusUser: Codable {
    let grade: String?
    let level: Float
    let skills: [Skill]
    let blackholedAt: String?
    let id: Int
    let beginAt: String
    let endAt: String?
    let cursusID: Int
    let hasCoalition: Bool
    let createdAt, updatedAt: String
    let user: UserClass
    let cursus: Cursus

    enum CodingKeys: String, CodingKey {
        case grade, level, skills
        case blackholedAt = "blackholed_at"
        case id
        case beginAt = "begin_at"
        case endAt = "end_at"
        case cursusID = "cursus_id"
        case hasCoalition = "has_coalition"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user, cursus
    }
}

// MARK: - UserClass
struct UserClass: Codable {
    let id: Int
    let email, login, firstName, lastName: String
    let usualFullName: String
    let usualFirstName: String?
    let url: String
    let phone, displayname, kind: String
    let image: UserImage?
    let staff: Bool
    let correctionPoint: Int
    let poolMonth, poolYear, location: String?
    let wallet: Int
    let anonymizeDate, dataErasureDate, createdAt, updatedAt: String?
    let alumni, active: Bool

    enum CodingKeys: String, CodingKey {
        case id, email, login
        case firstName = "first_name"
        case lastName = "last_name"
        case usualFullName = "usual_full_name"
        case usualFirstName = "usual_first_name"
        case url, phone, displayname, kind, image
        case staff = "staff?"
        case correctionPoint = "correction_point"
        case poolMonth = "pool_month"
        case poolYear = "pool_year"
        case location, wallet
        case anonymizeDate = "anonymize_date"
        case dataErasureDate = "data_erasure_date"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case alumni = "alumni?"
        case active = "active?"
    }
    
}

struct Cursus: Codable {
    let id: Int
    let createdAt, name, slug, kind: String

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case name, slug, kind
    }
}

// MARK: - Skill
struct Skill: Identifiable, Codable {
    let id: Int
    let name: String
    let level: Double
}

// MARK: - Group
//struct Group: Codable {
//    let id: Int
//    let name: String
//}

// MARK: - LanguagesUser
struct LanguagesUser: Codable {
    let id, languageID, userID, position: Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case languageID = "language_id"
        case userID = "user_id"
        case position
        case createdAt = "created_at"
    }
}

// MARK: - ProjectsUser
struct ProjectsUser: Identifiable, Codable, Equatable, Hashable {
    typealias ID = Int
    let id: ID
    let occurrence: Int
    let finalMark: Int?
    let status: Status
    let validated: Bool?
    let currentTeamID: Int?
    let project: Project
    let cursusIDS: [Int]
    let markedAt: String?
    let marked: Bool
    let retriableAt: String?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, occurrence
        case finalMark = "final_mark"
        case status
        case validated = "validated?"
        case currentTeamID = "current_team_id"
        case project
        case cursusIDS = "cursus_ids"
        case markedAt = "marked_at"
        case marked
        case retriableAt = "retriable_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    static func == (lhs: ProjectsUser, rhs: ProjectsUser) -> Bool {
        return lhs.id == rhs.id &&
            lhs.occurrence == rhs.occurrence &&
            lhs.finalMark == rhs.finalMark &&
            lhs.status == rhs.status &&
            lhs.validated == rhs.validated &&
            lhs.currentTeamID == rhs.currentTeamID &&
            lhs.project == rhs.project &&
            lhs.cursusIDS == rhs.cursusIDS &&
            lhs.markedAt == rhs.markedAt &&
            lhs.marked == rhs.marked &&
            lhs.retriableAt == rhs.retriableAt &&
            lhs.createdAt == rhs.createdAt &&
            lhs.updatedAt == rhs.updatedAt
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(occurrence)
        hasher.combine(finalMark)
        hasher.combine(status)
        hasher.combine(validated)
        hasher.combine(currentTeamID)
        hasher.combine(project)
        hasher.combine(cursusIDS)
        hasher.combine(markedAt)
        hasher.combine(marked)
        hasher.combine(retriableAt)
        hasher.combine(createdAt)
        hasher.combine(updatedAt)
    }
}


// MARK: - Project
struct Project: Codable, Equatable, Hashable {
    let id: Int
    let name, slug: String
    let parentID: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case parentID = "parent_id"
    }

    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.slug == rhs.slug &&
            lhs.parentID == rhs.parentID
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(slug)
        hasher.combine(parentID)
    }
}


enum Status: String, Codable {
    case success = "success"
    case finished = "finished"
    case inProgress = "in_progress"
    case searchingGroup = "searching_a_group"
    case parent = "parent"
    case waitingCorrection = "waiting_for_correction"
    case validating = "validating"
    case fail = "fail"
    case creatingGroup = "creating_group"
    case waitingGrading = "waiting_for_grading"
    case waitingStart = "waiting_to_start"
}

// MARK: - TitlesUser
struct TitlesUser: Codable {
    let id, userID, titleID: Int
    let selected: Bool
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case titleID = "title_id"
        case selected
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
