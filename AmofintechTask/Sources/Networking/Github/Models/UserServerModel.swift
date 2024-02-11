//
//  GithubUserServerModel.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

struct UserServerModel: Codable {
    var userID: Int64
    var accountName: String
    var userName: String
    var avatarURL: String
    var email: String
    var bio: String
    var location: String
    var createdAt: String
    var followersCount: Int64
    var followingCount: Int64
    var reposCount: Int64
    
    private enum CodingKeys: String, CodingKey {
        case userID = "id"
        case accountName = "login"
        case userName = "name"
        case avatarURL = "avatar_url"
        case email = "email"
        case bio
        case location = "location"
        case createdAt = "created_at"
        case followersCount = "followers"
        case followingCount = "following"
        case reposCount = "public_repos"
    }

    init(userID: Int64,
         accountName: String,
         userName: String,
         avatarURL: String,
         email: String,
         bio: String,
         location: String,
         createdAt: String,
         followersCount: Int64,
         followingCount: Int64,
         reposCount: Int64) {
        self.userID = userID
        self.accountName = accountName
        self.userName = userName
        self.avatarURL = avatarURL
        self.email = email
        self.bio = bio
        self.location = location
        self.createdAt = createdAt
        self.followersCount = followersCount
        self.followingCount = followingCount
        self.reposCount = reposCount
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.userID = try container.decode(Int64.self, forKey: .userID)
        self.accountName = container.failsafeDecodeIfPresent(stringForKey: .accountName) ?? ""
        self.userName = container.failsafeDecodeIfPresent(stringForKey: .userName) ?? ""
        self.avatarURL = container.failsafeDecodeIfPresent(String.self, forKey: .avatarURL) ?? ""
        self.email = container.failsafeDecodeIfPresent(String.self, forKey: .email) ?? ""
        self.bio = container.failsafeDecodeIfPresent(String.self, forKey: .bio) ?? ""
        self.location = container.failsafeDecodeIfPresent(String.self, forKey: .location) ?? ""
        self.createdAt = container.failsafeDecodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.followersCount = try container.decodeIfPresent(Int64.self, forKey: .followersCount) ?? 0
        self.followingCount = try container.decodeIfPresent(Int64.self, forKey: .followingCount) ?? 0
        self.reposCount = try container.decodeIfPresent(Int64.self, forKey: .reposCount) ?? 0
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userID, forKey: .userID)
        try container.encode(userName, forKey: .userName)
    }
}

/*
extension UserServerModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(userID)
        hasher.combine(accountName)
        hasher.combine(userName)
        hasher.combine(avatarURL)
        hasher.combine(email)
        hasher.combine(bio)
        hasher.combine(location)
        hasher.combine(createdAt)
        hasher.combine(followersCount)
        hasher.combine(followingCount)
        hasher.combine(reposCount)
    }
}

extension UserServerModel: Comparable {
    public static func == (lhs: UserServerModel, rhs: UserServerModel) -> Bool {
        return lhs.userID == rhs.userID &&
            lhs.accountName == rhs.accountName &&
            lhs.userName == rhs.userName &&
            lhs.avatarURL == rhs.avatarURL &&
            lhs.email == rhs.email &&
            lhs.bio == rhs.bio &&
            lhs.location == rhs.location &&
            lhs.createdAt == rhs.createdAt &&
            lhs.followersCount == rhs.followersCount &&
            lhs.followingCount == rhs.followingCount &&
            lhs.reposCount == rhs.reposCount
    }

    public static func < (lhs: UserServerModel, rhs: UserServerModel) -> Bool {
        return lhs.userID < rhs.userID ||
            (lhs.userID == rhs.userID && lhs.accountName < rhs.accountName) ||
            (lhs.userID == rhs.userID && lhs.accountName == rhs.accountName && lhs.userName < rhs.userName) ||
            (lhs.userID == rhs.userID && lhs.accountName == rhs.accountName && lhs.userName == rhs.userName && lhs.avatarURL < rhs.avatarURL) ||
            (lhs.userID == rhs.userID && lhs.accountName == rhs.accountName && lhs.userName == rhs.userName
                && lhs.avatarURL == rhs.avatarURL && lhs.email < rhs.email) ||
            (lhs.userID == rhs.userID && lhs.accountName == rhs.accountName && lhs.userName == rhs.userName
                && lhs.avatarURL == rhs.avatarURL && lhs.email == rhs.email && lhs.bio < rhs.bio) ||
            (lhs.userID == rhs.userID && lhs.accountName == rhs.accountName && lhs.userName == rhs.userName
                && lhs.avatarURL == rhs.avatarURL && lhs.email == rhs.email && lhs.bio == rhs.bio && lhs.location < rhs.location) ||
            (lhs.userID == rhs.userID && lhs.accountName == rhs.accountName && lhs.userName == rhs.userName
                && lhs.avatarURL == rhs.avatarURL && lhs.email == rhs.email && lhs.bio == rhs.bio && lhs.location == rhs.location && lhs.createdAt < rhs.createdAt) ||
            (lhs.userID == rhs.userID && lhs.accountName == rhs.accountName && lhs.userName == rhs.userName
                && lhs.avatarURL == rhs.avatarURL && lhs.email == rhs.email && lhs.bio == rhs.bio && lhs.location == rhs.location
                && lhs.createdAt == rhs.createdAt && lhs.followingCount < rhs.followingCount) ||
            (lhs.userID == rhs.userID && lhs.accountName == rhs.accountName && lhs.userName == rhs.userName
                && lhs.avatarURL == rhs.avatarURL && lhs.email == rhs.email && lhs.bio == rhs.bio && lhs.location == rhs.location
                && lhs.createdAt == rhs.createdAt && lhs.followingCount == rhs.followingCount && lhs.followersCount < rhs.followersCount) ||
            (lhs.userID == rhs.userID && lhs.accountName == rhs.accountName && lhs.userName == rhs.userName
                && lhs.avatarURL == rhs.avatarURL && lhs.email == rhs.email && lhs.bio == rhs.bio && lhs.location == rhs.location
                && lhs.createdAt == rhs.createdAt && lhs.followingCount == rhs.followingCount && lhs.followersCount == rhs.followersCount
                && lhs.reposCount < rhs.reposCount)
    }
}
*/
