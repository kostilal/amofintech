//
//  NibLoadableView.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation
import UIKit

protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
