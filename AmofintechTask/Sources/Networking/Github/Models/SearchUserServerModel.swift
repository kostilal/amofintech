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
