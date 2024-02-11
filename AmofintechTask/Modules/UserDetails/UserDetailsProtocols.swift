//
//  UserDetailsProtocols.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

// MARK: - UserDetailsRouterInput
protocol UserDetailsRouterInput: AnyObject {
    /* Presenter -> Router */
    func routeToRepoDetails(repoName: String, url: URL)
}

// MARK: - UserDetailsViewOutput
protocol UserDetailsViewOutput: AnyObject {
    /* View -> Presenter */
    func viewDidLoad()
    func selectRepo(index: Int)
    func viewDidChangeSearchText(_ text: String)
}

// MARK: - UserDetailsViewInput
protocol UserDetailsViewInput: AnyObject {
    /* Presenter -> ViewController */
    func setUserModel(userModel: UserDetailsServerModel)
    func updateDataSource(with repos: [GithubRepo])
}
