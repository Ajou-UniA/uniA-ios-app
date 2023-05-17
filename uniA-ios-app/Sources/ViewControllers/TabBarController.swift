//
//  TabBarController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/12.
//

import UIKit
import Alamofire

class TabBarController: UITabBarController, CreateTaskDelegate {

    let height: CGFloat = 85

    let taskTab = TaskViewController()
    let homeTab = HomeViewController()
    let myPageTab = MyPageViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        let taskTab = TaskViewController()
        let homeTab = HomeViewController()
        let myPageTab = MyPageViewController()
        viewControllers = [taskTab, homeTab, myPageTab]
        setViewControllers(viewControllers, animated: false)

        // TaskViewController를 찾아서 createTaskDelegate 설정
        if let taskViewController = viewControllers?.first(where: { $0 is TaskViewController }) as? TaskViewController {
            taskViewController.createTaskDelegate = self
        }

        NotificationCenter.default.addObserver(self, selector: #selector(handleTaskUpdate), name: Notification.Name("TaskUpdateNotification"), object: nil)

        UITabBar.clear()
        self.changeRadius()

        self.selectedIndex = 1
        self.tabBar.isTranslucent = true

        // MARK: - taskTab
        taskTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarItem.task") ?? UIImage(), selectedImage: UIImage(named: "tabBarItem.task.fill") ?? UIImage())
        taskTab.tabBarItem.imageInsets = UIEdgeInsets(top: 20.5, left: 0, bottom: -20.5, right: 0)

        // MARK: - homeTab
        homeTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarItem.home") ?? UIImage(), selectedImage: UIImage(named: "tabBarItem.home.fill") ?? UIImage())
        homeTab.tabBarItem.imageInsets = UIEdgeInsets(top: 20.5, left: 0, bottom: -20.5, right: 0)

        // MARK: - myPageTab
        myPageTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tabBarItem.myPage") ?? UIImage(), selectedImage: UIImage(named: "tabBarItem.myPage.fill") ?? UIImage())
        myPageTab.tabBarItem.imageInsets = UIEdgeInsets(top: 20.5, left: 0, bottom: -20.5, right: 0)
    }

    // navigation Backbutton 지우기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = height
        tabFrame.origin.y = self.view.frame.size.height - height
        self.tabBar.frame = tabFrame
        self.tabBar.clipsToBounds = true
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
        self.tabBar.itemPositioning = .centered
    }

    func changeRadius() {
        self.tabBar.layer.cornerRadius = 30
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    // CreateTaskDelegate 메서드 구현
    func didCreateTask() {
        if let taskViewController = viewControllers?.first(where: { $0 is TaskViewController }) as? TaskViewController {
            taskViewController.getTask.getMyTask(memberId: 202021758) { tasks in
                taskViewController.tasks = tasks
                DispatchQueue.main.async {
                    taskViewController.taskTableView.reloadData()
                }
            }
        }
    }

    @objc func handleTaskUpdate() {
        if let taskViewController = viewControllers?.first(where: { $0 is TaskViewController }) as? TaskViewController {
            taskViewController.getTask.getMyTask(memberId: 202021758) { tasks in
                taskViewController.tasks = tasks
                DispatchQueue.main.async {
                    taskViewController.taskTableView.reloadData()
                }
            }
        }
    }
}

// 탭바 스크롤 시 일부 사라지는 문제 해결
extension UITabBar {
    static func clear() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
