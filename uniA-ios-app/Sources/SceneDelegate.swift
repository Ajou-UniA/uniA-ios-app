//
//  SceneDelegate.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/10.
//

import UIKit
import Alamofire

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        let autoLoginFlag = UserDefaults.standard.bool(forKey: "isAutoLoginEnabled")
        let signInAccess = SignInApiModel()
        let loginEmail = UserDefaults.standard.string(forKey: "loginemail")
        let loginPassword = UserDefaults.standard.string(forKey: "password")
        if autoLoginFlag == true { // 자동 로그인 완료
            guard let loginId = loginEmail,
                  let password = loginPassword else {return}
            let bodyData: Parameters = [
                "loginId": loginId,
                "password": password
            ]
            let tabBarController = TabBarController()
            signInAccess.requestSignInDataModel(bodyData: bodyData) { data in
                print(data)
                tabBarController.selectedIndex = 2
                if let homeViewController = tabBarController.viewControllers?.first(where: { $0 is HomeViewController }) as? HomeViewController {
                           homeViewController.fetchData()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3) { [self] in
                        window?.rootViewController = tabBarController
                    }
                }
            }
        } else { //
            let loginViewController = LoginViewController()
                   let navigationController = UINavigationController(rootViewController: loginViewController)
                   window?.rootViewController = navigationController
        }
        func sceneDidDisconnect(_: UIScene) {}
        
        func sceneDidBecomeActive(_: UIScene) {}
        
        func sceneWillResignActive(_: UIScene) {}
        
        func sceneWillEnterForeground(_: UIScene) {}
        
        func sceneDidEnterBackground(_: UIScene) {}
    }
}
