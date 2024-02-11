//
//  Reusable.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation

public protocol Reusable: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension Reusable {
    static public var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
