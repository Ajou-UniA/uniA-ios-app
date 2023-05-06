//
//  TabBarController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/12.
//

import UIKit

class TabBarController: UITabBarController {

    let taskTab = TaskViewController()
    let homeTab = HomeViewController()
    let myPageTab = MyPageViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.clear()
        self.changeRadius()
        viewControllers = [taskTab, homeTab, myPageTab]
        self.selectedIndex = 1
        self.tabBar.isTranslucent = true

        tabBar.frame.size.height = 85
        tabBar.frame.origin.y = view.frame.height - (Constant.height * 85)

        // MARK: - taskTab
        taskTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarItem.task") ?? UIImage(), selectedImage: UIImage(named: "tabBarItem.task.fill") ?? UIImage())
        taskTab.tabBarItem.imageInsets = UIEdgeInsets(top: 20.5, left: 0, bottom: -20.5, right: 0)

        // MARK: - homeTab
        homeTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarItem.home") ?? UIImage(), selectedImage: UIImage(named: "tabBarItem.home.fill") ?? UIImage())
        homeTab.tabBarItem.imageInsets = UIEdgeInsets(top: 20.5, left: 0, bottom: -20.5, right: 0)
//        homeTab.tabBarItem.imageInsets = .init(top: 19.83, left: 0, bottom: -19.83, right: 0)

        // MARK: - myPageTab
        myPageTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarItem.myPage") ?? UIImage(), selectedImage: UIImage(named: "tabBarItem.myPage.fill") ?? UIImage())
        myPageTab.tabBarItem.imageInsets = UIEdgeInsets(top: 20.5, left: 0, bottom: -20.5, right: 0)
//        myPageTab.tabBarItem.imageInsets = .init(top: 19.83, left: 0, bottom: -19.83, right: 0)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.clipsToBounds = true
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
    }

    func changeRadius() {
        self.tabBar.layer.cornerRadius = 30
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

// 탭바 스크롤 시 일부 사라지는 문제 해결
extension UITabBar {
    static func clear() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}

// 탭바 스크롤 시 일부 사라지는 문제 해결
//        UITabBar.clear()
//        self.tabBar.layer.borderColor = UIColor.clear.cgColor
//        self.tabBar.clipsToBounds = false

//let tabBarView = UIView()
//tabBarView.snp.makeConstraints {
//    $0.top.bottom.leading.trailing.equalToSuperview()
//    $0.height.equalTo(Constant.height * 85)
//}
//tabBarView.frame = self.tabBar.bounds.offsetBy(dx: -5, dy: -10)
//self.tabBar.addSubview(tabBarView)
//self.tabBar.sendSubviewToBack(tabBarView)

//    func changeHeight() {
//        if UIDevice().userInterfaceIdiom == .phone {
//            var tabFrame = tabBar.frame
//            tabFrame.size.height = 85
//            tabFrame.origin.y = view.frame.size.height - 85
//            tabBar.frame = tabFrame
//        }
//    }

//fileprivate lazy var defaultTabBarHeight = {tabBar.frame.size.height}()
//let newTabBarHeight = defaultTabBarHeight + (85 - defaultTabBarHeight)
//var newFrame = tabBar.frame
//newFrame.size.height = newTabBarHeight
//newFrame.origin.y = view.frame.size.height - newTabBarHeight
//tabBar.frame = newFrame

//        tabBar.frame.size.height = Constant.width*85
//        tabBar.frame.origin.y = view.frame.height-(Constant.width*85)

//        if #available(iOS 15.0, *) {
//            let appearance = UITabBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = selectedViewController?.view.backgroundColor
//            tabBar.standardAppearance = appearance
//            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
//        }

//func changeHeight() {
//    if UIDevice().userInterfaceIdiom == .phone {
//        var tabFrame = tabBar.frame
//        tabFrame.size.height = 85
//        tabFrame.origin.y = view.frame.size.height - 85
//        tabBar.frame = tabFrame
//    }
//}
