//
//  Configurable.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

protocol Configurable {
    associatedtype T
    
    func configure(with viewModel: T)
}
