//
//  SceneDelegate.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/10.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        self.window?.rootViewController = UINavigationController(rootViewController: VerificationViewController())
                window?.makeKeyAndVisible()

        //        // MARK: 자동로그인을 위한 코드
        //        var loginSuccess: Bool = UserDefaults.standard.bool(forKey: "loginSuccess") ?? false
        //
        //        print("자동로그인 \(loginSuccess)")
        //
        //        if loginSuccess == true {
        //            print("자동로그인 성공")
        //            self.window?.rootViewController = UINavigationController(rootViewController: TabBarController())
        //        } else if loginSuccess == false {
        //            self.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        //        }
        //        window?.makeKeyAndVisible()
        //    }
        
        func sceneDidDisconnect(_: UIScene) {}
        
        func sceneDidBecomeActive(_: UIScene) {}
        
        func sceneWillResignActive(_: UIScene) {}
        
        func sceneWillEnterForeground(_: UIScene) {}
        
        func sceneDidEnterBackground(_: UIScene) {}
    }
}
