//
//  GithubService.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

enum GithubError: Error, Descriptable {
    case networkError(error: NetworkError)
    case serverError(statusCode: Int)
    case parsingError(error: ParsingError)
    
    var stringDescription: String {
        switch self {
        case .networkError(let networkError):
            return "Network error: \(networkError.stringDescription)"
        case .serverError(let statusCode):
            let errorString = "Server error \(statusCode)"
            switch statusCode {
            case 403:
                return "\(errorString). For unauthenticated requests, the rate limit allows for up to 60 requests per hour."
            default:
                return errorString
            }
        case .parsingError(let parsingError):
            return "Parsing error: \(parsingError.stringDescription)"
        }
    }
}

protocol GithubServiceProtocol {
    func requestUserList(searchRequest: SearchDetailsRequest?, completion: @escaping (Result<GithubUserListResponse, GithubError>) -> Void)
    func fetchUser(username: String, completion: @escaping (Result<UserDetailsResponse, GithubError>) -> Void)
    func fetchUserRepos(for userName: String, completion: @escaping (Result<UserReposResponse, GithubError>) -> Void)
}

final class GithubService: GithubServiceProtocol {
    private struct Constants {
        static let apiUrl = URL(string: "https://api.github.com")!
        
        static var usersAbsoluteURL: URL {
            return URL(string: "users", relativeTo: apiUrl)!
        }
        
        static var searchUsersAbsoluteURL: URL {
            return URL(string: "search/users", relativeTo: apiUrl)!
        }
        
        static var reposAbsoluteURL: URL {
            return URL(string: "repos", relativeTo: apiUrl)!
        }
    }
    
    private let networkService: NetworkServiceProtocol
    private let queue: DispatchQueue
    
    init(networkService: NetworkServiceProtocol, queue: DispatchQueue = .main) {
        self.networkService = networkService
        self.queue = queue
    }
    
    /// NOTE: To avoid error 403 (For unauthenticated requests, the rate limit allows for up to 60 requests per hour),
    /// 5 users will be loaded for each user details request
    ///
    func requestUserList(searchRequest: SearchDetailsRequest?, completion: @escaping (Result<GithubUserListResponse, GithubError>) -> Void) {
        let query = searchRequest.flatMap { "q=\($0.searchString)&per_page=5" } ?? ""
        let url = Constants.searchUsersAbsoluteURL.urlWith(query: query)!
        let request = URLRequest(url: url)

        networkService.perform(request: request) { [weak self] result in
            guard let self = self else { return }
            
            self.queue.async {
                completion(
                    result.flatMapBoth(
                        ifSuccess: self.verifyServerResponse,
                        ifFailure: self.networkErrorToResult
                    ).flatMapBoth(
                        ifSuccess: self.parseUserListResult(_:),
                        ifFailure: liftError
                    )
                )
            }
        }
    }
    
    func fetchUser(username: String, completion: @escaping (Result<UserDetailsResponse, GithubError>) -> Void) {
        let query = "/\(username)"
        let url = Constants.usersAbsoluteURL.appendingPathComponent(query)
        let request = URLRequest(url: url)

        networkService.perform(request: request) { [weak self] result in
            guard let self = self else { return }
            
            self.queue.async {
                completion(
                    result.flatMapBoth(
                        ifSuccess: self.verifyServerResponse,
                        ifFailure: self.networkErrorToResult
                    ).flatMapBoth(
                        ifSuccess: self.parseUserDetails(_:),
                        ifFailure: liftError
                    )
                )
            }
        }
    }
    
    func fetchUserRepos(for userName: String, completion: @escaping (Result<UserReposResponse, GithubError>) -> Void) {
        let query = "/\(userName)/repos"
        let url = Constants.usersAbsoluteURL.appendingPathComponent(query)
        let request = URLRequest(url: url)
        
        networkService.perform(request: request) { [weak self] result in
            guard let self = self else { return }
            
            self.queue.async {
                completion(
                    result.flatMapBoth(
                        ifSuccess: self.verifyServerResponse, 
                        ifFailure: self.networkErrorToResult
                    ).flatMapBoth(
                        ifSuccess: self.parseUserRepos(_:),
                        ifFailure: liftError
                    )
                )
            }
        }
    }
}

private extension GithubService {
    func verifyServerResponse(_ response: (data: Data?, urlResponse: HTTPURLResponse))
        -> Result<Data?, GithubError> {
        if HttpStatus(response.urlResponse).isOk {
            return .success(response.0)
        } else {
            return .failure(.serverError(statusCode: response.urlResponse.statusCode))
        }
    }

    func parseUserListResult(_ data: Data?) -> Result<GithubUserListResponse, GithubError> {
        guard let data = data else {
            return .success(.empty())
        }
        
        return GithubUserListResponseBuilder(data: data)
                .buildResult()
                .flatMapError { error in .failure(.parsingError(error: error)) }
    }
    
    func parseUserDetails(_ data: Data?) -> Result<UserDetailsResponse, GithubError> {
        guard let data = data else {
            return .success(.empty())
        }
        
        return UserDetailsResponseBuilder(data: data)
                .buildResult()
                .flatMapError { error in .failure(.parsingError(error: error)) }
    }
    
    func parseUserRepos(_ data: Data?) -> Result<UserReposResponse, GithubError> {
        guard let data = data else {
            return .success(.empty())
        }
        
        return UserReposResponseBuilder(data: data)
                .buildResult()
                .flatMapError { error in .failure(.parsingError(error: error)) }
    }

    func networkErrorToResult(_ error: NetworkError) -> Result<Data?, GithubError> {
        return .failure(.networkError(error: error))
    }
}
