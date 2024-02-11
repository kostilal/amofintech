//
//  UserDetailsRouter.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

final class UserDetailsRouter {
    weak var viewController: UserDetailsViewController!
}

extension UserDetailsRouter: UserDetailsRouterInput {
    func routeToRepoDetails(repoName: String, url: URL) {
        let vc = WebViewController(title: repoName, url: url)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
