//
//  UserSearchRouter.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

final class UserSearchRouter {
    weak var viewController: UserSearchViewController!
}

extension UserSearchRouter: UserSearchRouterInput {
    func routeToUserDetails(_ user: UserDetailsServerModel) {
        let vc = UserDetailsAssembler().createModule(payload: user)
        
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
