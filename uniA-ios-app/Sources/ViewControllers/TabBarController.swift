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
        timetableTab.tabBarItem.imageInsets = .init(top: 19.83, left: 0, bottom: -19.83, right: 0)

        // MARK: - homeTab
        homeTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarItem.home") ?? UIImage(), selectedImage: UIImage(named: "tabBarItem.home.fill") ?? UIImage())
        homeTab.tabBarItem.imageInsets = .init(top: 19.83, left: 0, bottom: -19.83, right: 0)

        // MARK: - infoPageTab
        infoPageTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarItem.infoPage") ?? UIImage(), selectedImage: UIImage(named: "tabBarItem.infoPage.fill") ?? UIImage())
        infoPageTab.tabBarItem.imageInsets = .init(top: 19.83, left: 0, bottom: -19.83, right: 0)

        // MARK: - myPageTab
        myPageTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarItem.myPage") ?? UIImage(), selectedImage: UIImage(named: "tabBarItem.myPage.fill") ?? UIImage())
        myPageTab.tabBarItem.imageInsets = .init(top: 19.83, left: 0, bottom: -19.83, right: 0)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 85
        tabBar.frame.origin.y = view.frame.height - 85
    }
}
