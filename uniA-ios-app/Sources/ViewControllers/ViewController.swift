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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        loginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        homeBtn.addTarget(self, action: #selector(homeBtnTapped), for: .touchUpInside)

        setUpNavBar()
        setUpView()
        setUpConstraints()
    }

    func setUpView() {
        [loginBtn, homeBtn].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
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
    }

    @objc
    func loginBtnTapped() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: false)
    }

    @objc
    func homeBtnTapped() {
        self.navigationController?.pushViewController(TabBarController(), animated: true)
    }
}
