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
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UserSearchAssembler().createModule(navigationController: UINavigationController())
        window?.makeKeyAndVisible()
    }
}
