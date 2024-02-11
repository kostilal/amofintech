//
//  BaseController.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import UIKit

class BaseViewController: UIViewController {
    enum LoadType {
        case programmatically
        case xib
        case xibName(String)
    }
    
    init(loadType: LoadType = .xib) {
        var nibName: String
        
        switch loadType {
        case .programmatically:
            super.init(nibName: nil, bundle: nil)
            return
        case .xib:
            nibName = type(of: self).className
        case let .xibName(name):
            nibName = name
        }
        
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
