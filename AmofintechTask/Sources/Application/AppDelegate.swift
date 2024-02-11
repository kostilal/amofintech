//
//  AppDelegate.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        
        return true
    }
}

private extension AppDelegate {
    func setupWindow() {
        let nv = UINavigationController(rootViewController: UserSearchAssembler().createModule())
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nv
        window?.makeKeyAndVisible()
    }
}
