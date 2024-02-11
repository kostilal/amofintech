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
    var createdAt: String
    var location: String?
    var followersCount: Int64
    var followingCount: Int64
    var publicReposCount: Int64
    var avatarURL: String?
    
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
        self.createdAt = container.failsafeDecodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.location = container.failsafeDecodeIfPresent(stringForKey: .location)
        self.followersCount = try container.decodeIfPresent(Int64.self, forKey: .followersCount) ?? 0
        self.followingCount = try container.decodeIfPresent(Int64.self, forKey: .followingCount) ?? 0
        self.publicReposCount = try container.decodeIfPresent(Int64.self, forKey: .publicReposCount) ?? 0
        self.avatarURL = container.failsafeDecodeIfPresent(String.self, forKey: .avatarURL)
    }
    
    private func decodeCreatedAtDate(dateString: String?) -> Date {
        guard let dateString = dateString else {
            return Date()
        }
        
        return Date(dateString: dateString)
    }
    
    private func decodeURL(urlString: String?) -> URL? {
        guard let urlString = urlString else {
            return nil
        }
        
        return URL(string: urlString)
    }
}
