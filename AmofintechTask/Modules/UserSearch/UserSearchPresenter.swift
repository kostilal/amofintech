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
    private var models: [UserDetailsServerModel] = []
    
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
    func viewDidChangeSearchText(_ text: String) {
        guard text.count > 0 else {
            view.updateDataSource(with: [])
            return
        }
        
        searchUser(text)
    }
    
    func selectUser(index: Int) {
        if models.indices.contains(index) {
            router.routeToUserDetails(models[index])
        }
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
    
    func fetchUsersDetails(for users: [SearchUserServerModel]) {
        let names = users.map { $0.accountName }
        let group = DispatchGroup()
        models.removeAll()
       
        names.forEach { name in
            group.enter()
            githubService.fetchUser(username: name) {[weak self] result in
                switch result {
                case .success(let response):
                    if let userDetails = response.user {
                        self?.models.append(userDetails)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.view.updateDataSource(with: self.models)
        }
    }
}
