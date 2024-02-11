//
//  UserReposResponse.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

struct UserReposResponse: Decodable {
    static func empty() -> Self {
        return UserReposResponse(repos: [])
    }
    
    var repos: [GithubRepo] = []
    
    init(repos: [GithubRepo]) {
        self.repos = repos
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        do {
            let items = try container.decode([GithubRepo].self)
            self.repos = items 
        } catch DecodingError.keyNotFound {
            print("UserReposResponse keyNotFound!")
        }
    }
}
