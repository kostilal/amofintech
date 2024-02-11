//
//  GithubRepo.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

struct GithubRepo: Decodable {
    var repositoryName: String
    var repoURL: String
    var starsCount: Int64
    var forksCount: Int64
    var ownerRepo: OwnerRepo
    
    private enum CodingKeys: String, CodingKey {
        case repositoryName = "name"
        case repoURL = "html_url"
        case forksCount = "forks_count"
        case starsCount = "stargazers_count"
        case owner = "owner"
    }
    
    init(repositoryName: String,
         repoURL: String,
         starsCount: Int64,
         forksCount: Int64,
         ownerRepo: OwnerRepo) {
        self.repositoryName = repositoryName
        self.repoURL = repoURL
        self.starsCount = starsCount
        self.forksCount = forksCount
        self.ownerRepo = ownerRepo
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.repositoryName = container.failsafeDecodeIfPresent(stringForKey: .repositoryName) ?? ""
        self.repoURL = container.failsafeDecodeIfPresent(stringForKey: .repoURL) ?? ""
        self.starsCount = try container.decodeIfPresent(Int64.self, forKey: .starsCount) ?? 0
        self.forksCount = try container.decodeIfPresent(Int64.self, forKey: .forksCount) ?? 0
        self.ownerRepo = try container.decode(OwnerRepo.self, forKey: .owner)
    }
}


extension GithubRepo: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(repositoryName)
        hasher.combine(repoURL)
        hasher.combine(starsCount)
        hasher.combine(forksCount)
    }
    
    static func == (lhs: GithubRepo, rhs: GithubRepo) -> Bool {
        return lhs.repositoryName == rhs.repositoryName &&
            lhs.repoURL == rhs.repoURL &&
            lhs.starsCount == rhs.starsCount &&
            lhs.forksCount == rhs.forksCount
    }
}

struct OwnerRepo: Decodable {
    var userID: Int64
    var userName: String
    
    private enum CodingKeys: String, CodingKey {
        case userID = "id"
        case userName = "login"
    }

    init(userID: Int64,
         userName: String) {
        self.userID = userID
        self.userName = userName
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.userID = try container.decodeIfPresent(Int64.self, forKey: .userID) ?? 0
        self.userName = container.failsafeDecodeIfPresent(stringForKey: .userName) ?? ""
    }
}
