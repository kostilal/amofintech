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
    func close()
}

// MARK: - UserDetailsViewOutput
protocol UserDetailsViewOutput: AnyObject {
    /* View -> Presenter */
    func viewDidLoad()
}

// MARK: - UserDetailsViewInput
protocol UserDetailsViewInput: AnyObject {
    /* Presenter -> ViewController */
}
