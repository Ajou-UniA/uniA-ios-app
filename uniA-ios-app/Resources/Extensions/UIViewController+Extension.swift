//
//  UIViewController+Extension.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/06.
//

import Foundation
import UIKit

extension UIViewController {

    // 네비게이션 바 커스텀
    func setUpNavBar() {
        let backButton = UIBarButtonItem()
        backButton.tintColor = .black
        backButton.width = 30
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        addHeight()
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "", size: 16)!]
    }

    func addHeight() {
        let width = UIView(frame: self.navigationController!.navigationBar.frame)
        width.backgroundColor = UIColor.blue
        width.layer.masksToBounds = false
        width.layer.shadowOpacity = 0.4 // your opacity
        width.layer.shadowOffset = CGSize(width: 0, height: 2) // your offset
        width.layer.shadowRadius =  4 //your radius
        self.view.addSubview(width)
    }

    // collectionView의 Cell에서 다른 viewController로 이동할 때 주로 사용
    func pushView(viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.15
        transition.type = .fade
        view.window?.layer.add(transition, forKey: kCATransition)
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true, completion: nil)
    }

    func dismissView() {
        let transition = CATransition()
        transition.duration = 0.15
        transition.type = .fade
        transition.subtype = .none
        view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: true)
    }
}
