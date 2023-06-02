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
        let logoutFlag = UserDefaults.standard.bool(forKey: "logoutSuccess")
        let signInAccess = SignInApiModel()
        let memberIdAccess = CallMemberApiModel()
        let loginEmail = UserDefaults.standard.string(forKey: "loginemail")
        let loginPassword = UserDefaults.standard.string(forKey: "password")
        if autoLoginFlag == true { // 자동 로그인 완료

            guard let loginId = loginEmail,
             let password = loginPassword else {return}

            let bodyData: Parameters = [
                "loginId": loginId,
                "password": password
            ]
            signInAccess.requestSignInDataModel(bodyData: bodyData) { data in
            }
            //
            self.window?.rootViewController = UINavigationController(rootViewController: TabBarController())
            
        } else { //
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
            }

        }

       

                
        func sceneDidDisconnect(_: UIScene) {}
        
        func sceneDidBecomeActive(_: UIScene) {}
        
        func sceneWillResignActive(_: UIScene) {}
        
        func sceneWillEnterForeground(_: UIScene) {}
        
        func sceneDidEnterBackground(_: UIScene) {}
    }
}
