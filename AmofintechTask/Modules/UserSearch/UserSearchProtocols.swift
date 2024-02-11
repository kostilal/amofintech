//
//  UserSearchProtocols.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

// MARK: - UserSearchRouterInput
protocol UserSearchRouterInput: AnyObject {
    /* Presenter -> Router */
    func routeToUserDetails(_ user: UserDetailsServerModel)
}

// MARK: - UserSearchViewOutput
protocol UserSearchViewOutput: AnyObject {
    /* View -> Presenter */
    func viewDidChangeSearchText(_ text: String)
    func selectUser(index: Int)
}

// MARK: - UserSearchViewInput
protocol UserSearchViewInput: AnyObject {
    /* Presenter -> ViewController */
    func updateDataSource(with users: [UserDetailsServerModel])
}
