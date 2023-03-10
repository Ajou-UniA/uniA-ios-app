//
//  ViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/10.
//

import SnapKit
import Then
import UIKit

class ViewController: UIViewController {
    lazy var loginBtn = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 10
    }

    lazy var homeBtn = UIButton().then {
        $0.setTitle("홈", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 10
    }

    lazy var scheduleBtn = UIButton().then {
        $0.setTitle("시간표", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 10
    }

    lazy var infoPageBtn = UIButton().then {
        $0.setTitle("정보", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 10
    }

    lazy var myPageBtn = UIButton().then {
        $0.setTitle("마이페이지", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        loginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        homeBtn.addTarget(self, action: #selector(homeBtnTapped), for: .touchUpInside)
        scheduleBtn.addTarget(self, action: #selector(scheduleBtnTapped), for: .touchUpInside)
        infoPageBtn.addTarget(self, action: #selector(infoPageBtnTapped), for: .touchUpInside)
        myPageBtn.addTarget(self, action: #selector(myPageBtnTapped), for: .touchUpInside)

        setUpView()
        setUpConstraint()
    }

    func setUpView() {
        [loginBtn, homeBtn, scheduleBtn, infoPageBtn, myPageBtn].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraint() {
        loginBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 200)
            $0.height.equalTo(Constant.height * 50)
        }
        homeBtn.snp.makeConstraints {
            $0.top.equalTo(loginBtn.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 200)
            $0.height.equalTo(Constant.height * 50)
        }
        scheduleBtn.snp.makeConstraints {
            $0.top.equalTo(homeBtn.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 200)
            $0.height.equalTo(Constant.height * 50)
        }
        infoPageBtn.snp.makeConstraints {
            $0.top.equalTo(scheduleBtn.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 200)
            $0.height.equalTo(Constant.height * 50)
        }
        myPageBtn.snp.makeConstraints {
            $0.top.equalTo(infoPageBtn.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 200)
            $0.height.equalTo(Constant.height * 50)
        }
    }

    @objc
    func loginBtnTapped() {
        let loginViewController = LoginViewController()
        pushView(viewController: loginViewController)
    }

    @objc
    func homeBtnTapped() {
        let homeViewController = HomeViewController()
        pushView(viewController: homeViewController)
    }

    @objc
    func scheduleBtnTapped() {
        let scheduleViewController = ScheduleViewController()
        pushView(viewController: scheduleViewController)
    }

    @objc
    func infoPageBtnTapped() {
        let infoPageViewController = InfoPageViewController()
        pushView(viewController: infoPageViewController)
    }

    @objc
    func myPageBtnTapped() {
        let myPageViewController = MyPageViewController()
        pushView(viewController: myPageViewController)
    }
}
