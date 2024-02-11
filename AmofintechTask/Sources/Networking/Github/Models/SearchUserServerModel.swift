//
//  GithubUserServerModel.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

struct SearchUserServerModel: Codable {
    var userID: Int64
    var accountName: String
    
    private enum CodingKeys: String, CodingKey {
        case userID = "id"
        case accountName = "login"
    }

    init(userID: Int64,
         accountName: String) {
        self.userID = userID
        self.accountName = accountName
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.userID = try container.decode(Int64.self, forKey: .userID)
        self.accountName = container.failsafeDecodeIfPresent(stringForKey: .accountName) ?? ""
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userID, forKey: .userID)
        try container.encode(accountName, forKey: .accountName)
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
