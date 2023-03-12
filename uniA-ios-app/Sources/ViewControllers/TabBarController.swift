//
//  TabBarController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/12.
//

import UIKit

class TabBarController: UITabBarController {

    let timetableTab = TimetableViewController()
    let homeTab = HomeViewController()
    let infoPageTab = InfoPageViewController()
    let myPageTab = MyPageViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewControllers = [timetableTab, homeTab, infoPageTab, myPageTab]
        self.selectedIndex = 1

        // MARK: - timetableTab
        timetableTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarItem.timetable") ?? UIImage(), selectedImage: UIImage(named: "tabBarItem.timetable.fill") ?? UIImage())
        timetableTab.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0.0)
        timetableTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "", size: 12) ?? .systemFont(ofSize: 12)], for: .normal)

        // MARK: - homeTab
        homeTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarItem.home") ?? UIImage(), selectedImage: UIImage(named: "tabBarItem.home.fill") ?? UIImage())
        homeTab.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0.0)
        homeTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "", size: 12) ?? .systemFont(ofSize: 12)], for: .normal)

        // MARK: - infoPageTab
        infoPageTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarItem.infoPage") ?? UIImage(), selectedImage: UIImage(named: "tabBarItem.infoPage.fill") ?? UIImage())
        infoPageTab.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0.0)
        infoPageTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "", size: 12) ?? .systemFont(ofSize: 12)], for: .normal)

        // MARK: - myPageTab
        myPageTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarItem.myPage") ?? UIImage(), selectedImage: UIImage(named: "tabBarItem.myPage.fill") ?? UIImage())
        myPageTab.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0.0)
        myPageTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "", size: 12) ?? .systemFont(ofSize: 12)], for: .normal)
    }
}
