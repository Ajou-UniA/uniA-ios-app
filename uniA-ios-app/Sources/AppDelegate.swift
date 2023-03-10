//
//  AppDelegate.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {}
}
