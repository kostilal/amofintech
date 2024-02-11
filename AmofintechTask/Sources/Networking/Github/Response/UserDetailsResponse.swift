//
//  UserDetailsResponse.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

struct UserDetailsResponse: Decodable {
    static func empty() -> Self {
        return UserDetailsResponse(user: nil)
    }
    
    var user: UserDetailsServerModel?
    
    init(user: UserDetailsServerModel?) {
        self.user = user
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        do {
            self.user = try container.decode(UserDetailsServerModel.self)
        } catch DecodingError.keyNotFound {
            print("UserDetailsResponse keyNotFound!")
        }
    }
}
