//
//  UserDetailsServerModel.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

struct UserDetailsServerModel: Decodable {
    var userID: Int64
    var accountName: String
    var userName: String
    var email: String?
    var bio: String?
    var location: String?
    var followersCount: Int64
    var followingCount: Int64
    var publicReposCount: Int64
    var avatarURL: String?
    var createdAt: String
    
    private enum CodingKeys: String, CodingKey {
        case userName = "name"
        case accountName = "login"
        case email
        case location
        case bio
        case createdAt = "created_at"
        case followersCount = "followers"
        case followingCount = "following"
        case publicReposCount = "public_repos"
        case avatarURL = "avatar_url"
        case userID = "id"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.userID = try container.decode(Int64.self, forKey: .userID)
        self.userName = container.failsafeDecodeIfPresent(stringForKey: .userName) ?? ""
        self.accountName = container.failsafeDecodeIfPresent(stringForKey: .accountName) ?? ""
        self.email = container.failsafeDecodeIfPresent(stringForKey: .email)
        self.bio = container.failsafeDecodeIfPresent(stringForKey: .bio)
        self.location = container.failsafeDecodeIfPresent(stringForKey: .location)
        self.followersCount = try container.decodeIfPresent(Int64.self, forKey: .followersCount) ?? 0
        self.followingCount = try container.decodeIfPresent(Int64.self, forKey: .followingCount) ?? 0
        self.publicReposCount = try container.decodeIfPresent(Int64.self, forKey: .publicReposCount) ?? 0
        self.avatarURL = container.failsafeDecodeIfPresent(String.self, forKey: .avatarURL)
        self.createdAt = container.failsafeDecodeIfPresent(String.self, forKey: .createdAt) ?? ""
    }
}

extension UserDetailsServerModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(userID)
        hasher.combine(accountName)
        hasher.combine(userName)
        hasher.combine(avatarURL)
        hasher.combine(email)
        hasher.combine(bio)
        hasher.combine(location)
        hasher.combine(followersCount)
        hasher.combine(followingCount)
    }
}

extension UserDetailsServerModel: Comparable {
    public static func == (lhs: UserDetailsServerModel, rhs: UserDetailsServerModel) -> Bool {
        return lhs.userID == rhs.userID &&
            lhs.accountName == rhs.accountName &&
            lhs.userName == rhs.userName &&
            lhs.followersCount == rhs.followersCount &&
            lhs.followingCount == rhs.followingCount &&
            lhs.publicReposCount == rhs.publicReposCount &&
            lhs.createdAt == rhs.createdAt &&
            lhs.email == rhs.email &&
            lhs.bio == rhs.bio &&
            lhs.location == rhs.location &&
            lhs.avatarURL == rhs.avatarURL
    }

    public static func < (lhs: UserDetailsServerModel, rhs: UserDetailsServerModel) -> Bool {
        return lhs.userID < rhs.userID ||
        (lhs.userID == rhs.userID && lhs.accountName < rhs.accountName) ||
        (lhs.userID == rhs.userID && lhs.accountName == rhs.accountName && lhs.userName < rhs.userName) ||
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
            && lhs.createdAt == rhs.createdAt && lhs.followingCount == rhs.followingCount && lhs.followersCount == rhs.followersCount)
    }
}
