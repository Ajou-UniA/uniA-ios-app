//
//  InfoPageViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/10.
//

import SnapKit
import Then
import UIKit

class InfoPageViewController: UIViewController {
    //MARK: - Properties
    
    lazy var aboutBtn = UIButton().then {
        $0.layer.cornerRadius = 20.0
        $0.backgroundColor = .white
        $0.setTitle("       About Ajou", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 9)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        $0.contentHorizontalAlignment = .left
    }
    lazy var academicBtn = UIButton().then {
        $0.layer.cornerRadius = 20.0
        $0.backgroundColor = .white
        $0.setTitle("       Academic Affairs", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 9)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        $0.contentHorizontalAlignment = .left
    }
    lazy var immigrationBtn = UIButton().then {
        $0.layer.cornerRadius = 20.0
        $0.backgroundColor = .white
        $0.setTitle("       Immigration Guide", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 9)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        $0.contentHorizontalAlignment = .left
    }
    lazy var campusBtn = UIButton().then {
        $0.layer.cornerRadius = 20.0
        $0.backgroundColor = .white
        $0.setTitle("       Campus Life", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 9)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        $0.contentHorizontalAlignment = .left
    }
    lazy var lifeBtn = UIButton().then {
        $0.layer.cornerRadius = 20.0
        $0.backgroundColor = .white
        $0.setTitle("       Life in Korea", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 9)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        $0.contentHorizontalAlignment = .left
    }
    lazy var touristsBtn = UIButton().then {
        $0.layer.cornerRadius = 20.0
        $0.backgroundColor = .white
        $0.setTitle("       Tourists Attractions", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 9)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        $0.contentHorizontalAlignment = .left
    }
    
    //MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6

        aboutBtn.addTarget(self, action: #selector(aboutBtnTapped), for: .touchUpInside)
        setUpView()
        setUpConstraints()
        naviSetUp()
    }
    
    //MARK: - Helper

    func setUpView() {
        [aboutBtn,academicBtn,immigrationBtn,campusBtn,lifeBtn,touristsBtn].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        aboutBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(17)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 72)
                  
        }
        academicBtn.snp.makeConstraints {
            $0.top.equalTo(aboutBtn.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 72)
        }
        immigrationBtn.snp.makeConstraints {
            $0.top.equalTo(academicBtn.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 72)
        }
        campusBtn.snp.makeConstraints {
            $0.top.equalTo(immigrationBtn.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 72)
        }
        lifeBtn.snp.makeConstraints {
            $0.top.equalTo(campusBtn.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 72)
        }
        touristsBtn.snp.makeConstraints {
            $0.top.equalTo(lifeBtn.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 72)
        }
    }
    func naviSetUp() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.title = "Info Page"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)

    }
    @objc func aboutBtnTapped() {
        //SignUpBtn 누르면 남아있는 textfield 값 지워주기
        let aboutAjouViewController = AboutAjouViewController()
        navigationController?.pushViewController(aboutAjouViewController, animated: true)
    }
}

