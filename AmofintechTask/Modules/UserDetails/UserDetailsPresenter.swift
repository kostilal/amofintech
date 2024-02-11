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
//    private var viewModel: WishlistsViewModel

    // MARK: - Init
    init(view: UserDetailsViewInput, router: UserDetailsRouterInput) {
        self.view = view
        self.router = router
        
//        self.view.set(viewModel: viewModel)
    }
}

// MARK: - UserDetailsViewOutput
extension UserDetailsPresenter: UserDetailsViewOutput {
    func viewDidLoad() {
    }
}
