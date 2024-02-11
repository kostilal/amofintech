//
//  UserSearchAssembler.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation
import UIKit

struct UserSearchAssembler {
    func createModule() -> UserSearchViewController {
        let vc: UserSearchViewController = .init(loadType: .xib)
        
        let router = UserSearchRouter()
        router.viewController = vc
        
        let presenter: UserSearchPresenter = .init(view: vc, router: router)
        vc.output = presenter

        return vc
    }
}
