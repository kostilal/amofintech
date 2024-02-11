//
//  UserDetailsPresenter.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

final class UserDetailsPresenter {
    // MARK: - Properties
    unowned private let view: UserDetailsViewInput
    private let router: UserDetailsRouterInput
    private let userModel: UserDetailsServerModel
    private let githubService: GithubServiceProtocol
    private var userRepos: [GithubRepo] = []
    private var filteredRepos: [GithubRepo] = []

    // MARK: - Init
    init(view: UserDetailsViewInput, router: UserDetailsRouterInput, userModel: UserDetailsServerModel) {
        self.view = view
        self.router = router
        self.userModel = userModel
        self.githubService = GithubService(networkService: NetworkService())
    }
}

// MARK: - UserDetailsViewOutput
extension UserDetailsPresenter: UserDetailsViewOutput {
    func viewDidLoad() {
        view.setUserModel(userModel: userModel)
        fetchUserRepos()
    }
    
    func selectRepo(index: Int) {
        if filteredRepos.indices.contains(index) {
            let repo = filteredRepos[index]
            
            router.routeToRepoDetails(repoName: repo.repositoryName, url: URL(string: repo.repoURL)!)
        }
    }
    
    func viewDidChangeSearchText(_ text: String) {
        guard text.count > 0 else {
            view.updateDataSource(with: userRepos)
            return
        }
        
        filteredRepos = userRepos.filter({$0
            .repositoryName
            .lowercased()
            .contains(text.lowercased())
        })
        self.view.updateDataSource(with: filteredRepos)
    }
}

private extension UserDetailsPresenter {
    func fetchUserRepos() {
        githubService.fetchUserRepos(for: userModel.accountName) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.userRepos = response.repos
                self.filteredRepos = response.repos
                self.view.updateDataSource(with: self.filteredRepos)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
