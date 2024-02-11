//
//  UserDetailsAssembler.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation
import UIKit

struct UserDetailsAssembler {
    func createModule(navigationController: UINavigationController) -> UserDetailsViewController {
        let vc: UserDetailsViewController = .init(loadType: .xib)
        
        let router = UserDetailsRouter()
        router.viewController = vc
        
        let presenter: UserDetailsPresenter = .init(view: vc, router: router)
        vc.output = presenter

        return vc
    }
}
