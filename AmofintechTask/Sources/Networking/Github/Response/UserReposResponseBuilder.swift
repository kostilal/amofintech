//
//  UserReposResponseBuilder.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

final class UserReposResponseBuilder {
    
    private let data: Data
    
    private let decoder = JSONDecoder()
    
    init(data: Data) {
        self.data = data
    }
    
    func buildResult() -> Result<UserReposResponse, ParsingError> {
        do {
            guard let response = try? decoder.decode(UserReposResponse.self, from: data) else {
                throw ParsingError.wrongType(key: "Root key")
            }
            
            return .success(response)
            
        } catch let error as ParsingError {
            return .failure(error)
        } catch {
            return .failure(.jsonParsingError(error: error))
        }
    }
}