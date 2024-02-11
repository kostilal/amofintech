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
    
    var models: [UserServerModel] = []
    
    private enum CodingKeys: String, CodingKey {
        case items
    }
    
    init(models: [UserServerModel]) {
        self.models = models
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.models = try container.decode([UserServerModel].self, forKey: .items)
        } catch DecodingError.keyNotFound {
            print("GithubUserListResponse keyNotFound!")
        }
    }
}

