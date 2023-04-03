//
//  User.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import Foundation
import CloudKit


struct User: Identifiable {
    var id: String // record name
    var profileImage: CKAsset?
    var userID: CKRecord.Reference
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var role: Role
    var height: String
    var weight: String
    var age: Int
    var highestLevelPlayed: LevelPlayed
    var skillLevel: SkillLevel
    var school: String
    var position: Position
    var playsLike: String
    
    var recordID: CKRecord.ID {
        CKRecord.ID(recordName: id)
    }
    
    var name: String {
        "\(firstName) \(lastName)"
    }
    
    init(firstName: String = "", lastName: String = "", email: String = "", phoneNumber: String = "", role: Role = .player, height: String = "6’0\"", weight: String = "140..150", age: Int = 20, highestLevelPlayed: LevelPlayed = .college, skillLevel: SkillLevel = .competitive, school: String = "", position: Position = .guard, playsLike: String = "") {
        
        self.id = UUID().uuidString
        self.userID = CKRecord.Reference(record: CKRecord(recordType: "User"), action: .none)
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.role = role
        self.height = height
        self.weight = weight
        self.age = age
        self.highestLevelPlayed = highestLevelPlayed
        self.skillLevel = skillLevel
        self.school = school
        self.position = position
        self.playsLike = playsLike
    }
    
    init(record: CKRecord) throws {
        guard let userID = record[.userID] as? CKRecord.Reference else {
            throw RecordError.missingKey(.userID)
        }
        
        if let profileImage = record[.profileImage] as? CKAsset {
            self.profileImage = profileImage
        }
        
        guard let firstName = record[.firstName] as? String else {
            throw RecordError.missingKey(.firstName)
        }
        
        guard let lastName = record[.lastName] as? String else {
            throw RecordError.missingKey(.lastName)
        }
        
        guard let email = record[.email] as? String else {
            throw RecordError.missingKey(.email)
        }
        
        guard let phoneNumber = record[.phoneNumber] as? String else {
            throw RecordError.missingKey(.phoneNumber)
        }
        
        guard let roleStr = record[.role] as? String,
              let role = User.Role(rawValue: roleStr)
        else {
            throw RecordError.missingKey(.role)
        }
        
        guard let height = record[.height] as? String else {
            throw RecordError.missingKey(.height)
        }
        
        guard let weight = record[.weight] as? String else {
            throw RecordError.missingKey(.weight)
        }
        
        guard let age = record[.age] as? Int else {
            throw RecordError.missingKey(.age)
        }
        
        guard let highestLevelPlayedStr = record[.highestLevelPlayed] as? String,
              let highestLevelPlayed = User.LevelPlayed(rawValue: highestLevelPlayedStr)
        else {
            throw RecordError.missingKey(.highestLevelPlayed)
        }
        
        guard let skillLevelStr = record[.skillLevel] as? String,
              let skillLevel = User.SkillLevel(rawValue: skillLevelStr)
        else {
            throw RecordError.missingKey(.skillLevel)
        }
        
        guard let school = record[.school] as? String else {
            throw RecordError.missingKey(.school)
        }
        
        guard let positionStr = record[.position] as? String,
              let position = User.Position(rawValue: positionStr)
        else {
            throw RecordError.missingKey(.position)
        }
        
        guard let playsLike = record[.playsLike] as? String else {
            throw RecordError.missingKey(.playsLike)
        }
        
        if let profileImage = record[.profileImage] as? CKAsset {
            self.profileImage = profileImage
        }
        
        self.id = record.recordID.recordName
        self.userID = userID
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.role = role
        self.height = height
        self.weight = weight
        self.age = age
        self.highestLevelPlayed = highestLevelPlayed
        self.skillLevel = skillLevel
        self.school = school
        self.position = position
        self.playsLike = playsLike
    }
    
    // Convert User object to Record
    func createUserRecord() async throws -> CKRecord {
        let userID = try await CKContainer.default().userRecordID()
        let record = CKRecord(recordType: "User", recordID: self.recordID)
        
        record[.userID] = CKRecord.Reference(recordID: userID, action: .none) // reference to user's original record
        record[.firstName] = self.firstName
        record[.lastName] = self.lastName
        record[.email] = self.email
        record[.phoneNumber] = self.phoneNumber
        record[.role] = self.role.rawValue
        record[.height] = self.height
        record[.weight] = self.weight
        record[.age] = self.age
        record[.highestLevelPlayed] = self.highestLevelPlayed.rawValue
        record[.skillLevel] = self.skillLevel.rawValue
        record[.school] = self.school
        record[.position] = self.position.rawValue
        record[.playsLike] = self.playsLike
        
        if let profileImageURL = self.profileImage?.fileURL {
            record[.profileImage] = CKAsset(fileURL: profileImageURL)
        }
        
        return record
    }
}

extension User {
    struct RecordError: LocalizedError {
        var localizedDescription: String
        
        static func missingKey(_ key: RecordKey) -> RecordError {
            RecordError(localizedDescription: "Missing required key \(key.rawValue)")
        }
    }
    
    enum RecordKey: String {
        case userID, profileImage, firstName, lastName, email, phoneNumber, role, height, weight, age, highestLevelPlayed, skillLevel, school, position, playsLike
    }
    
    enum Role: String, CaseIterable, Identifiable {
        case player, coach, trainer
        var id: Self { self }
    }
    
    enum LevelPlayed: String, CaseIterable, Identifiable {
        case high_school, college, professional
        var id: Self { self }
    }
    
    enum SkillLevel: String, CaseIterable, Identifiable {
        case recreation, competitive, elite
        var id: Self { self }
    }
    
    enum Position: String, CaseIterable, Identifiable {
        case `guard`, wing, forward
        var id: Self { self }
    }
}

extension User {
    static let sampleUsers: [User] = [
        User(firstName: "LeBron", lastName: "James", email: "james123@gmail.com", role: .player, height: "6'9\"", weight: "140..150", age: 38, highestLevelPlayed: .professional, skillLevel: .elite, school: "St. Vincent-St. Mary High School", position: .forward, playsLike: "Kobe Bryant")
    ]
}

extension CKRecord {
    subscript(key: User.RecordKey) -> Any? {
        get { return self[key.rawValue] }
        set { self[key.rawValue] = newValue as? CKRecordValue}
    }
}
