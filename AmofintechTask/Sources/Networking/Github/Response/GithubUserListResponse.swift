//
//  GithubUserListResponse.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

struct GithubUserListResponse: Decodable {
    static func empty() -> Self {
        return GithubUserListResponse(models: [])
    }
    
    var models: [SearchUserServerModel] = []
    
    private enum CodingKeys: String, CodingKey {
        case items
    }
    
    init(models: [SearchUserServerModel]) {
        self.models = models
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.models = try container.decode([SearchUserServerModel].self, forKey: .items)
        } catch DecodingError.keyNotFound {
            print("GithubUserListResponse keyNotFound!")
        }
    }
}

