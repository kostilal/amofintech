//
//  UserSearchPresenter.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

final class UserSearchPresenter {
    // MARK: - Properties
    unowned private let view: UserSearchViewInput
    private let router: UserSearchRouterInput
    private let githubService: GithubServiceProtocol
    
    // MARK: - Init
    init(view: UserSearchViewInput, 
         router: UserSearchRouterInput) {
        self.view = view
        self.router = router
        self.githubService = GithubService(networkService: NetworkService())
    }
}

// MARK: - UserSearchViewOutput
extension UserSearchPresenter: UserSearchViewOutput {
    func viewDidLoad() {
    }
    
    func viewDidChangeSearchText(_ text: String) {
        guard text.count > 0 else { return }
        
        searchUser(text)
    }
}

private extension UserSearchPresenter {
    func searchUser(_ searchText: String) {
        let searchRequest = SearchDetailsRequest(searchString: searchText)
        
        githubService.requestUserList(searchRequest: searchRequest) {[weak self] result in
            switch result {
            case .success(let response):
                self?.fetchUsersDetails(for: response.models)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchUsersDetails(for users: [UserServerModel]) {
        let names = users.map { $0.accountName }
       
        names.forEach { name in
            githubService.fetchUser(username: name) {[weak self] result in
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
