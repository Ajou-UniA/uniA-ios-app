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
    lazy var topView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    lazy var titleLabel = UILabel().then {
        $0.text = "Info Page"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
    }
    
    lazy var aboutBtn = UIButton().then {
        $0.layer.cornerRadius = 20.0
        $0.backgroundColor = .white
        $0.setTitle("       About Ajou", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 9)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(aboutBtnTapped), for: .touchUpInside)

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
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true;

        setUpView()
        setUpConstraints()
    }
    
    //MARK: - Helper

    func setUpView() {
        self.view.addSubview(topView)
        self.view.addSubview(titleLabel)
        [aboutBtn,academicBtn,immigrationBtn,campusBtn,lifeBtn,touristsBtn].forEach {
            topView.addSubview($0)
        }
    }

    func setUpConstraints() {
        topView.snp.makeConstraints{
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(68)
        }
        titleLabel.snp.makeConstraints{
            $0.bottom.equalTo(topView.snp.top).offset(-15)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(17)
            $0.width.equalTo(Constant.width * 125)
            $0.height.equalTo(Constant.height * 35)
        }
        aboutBtn.snp.makeConstraints {
            $0.top.equalTo(topView.snp.top).offset(17)
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
 
    @objc func aboutBtnTapped() {
        //SignUpBtn 누르면 남아있는 textfield 값 지워주기
        let aboutAjouViewController = AboutAjouViewController()
        navigationController?.pushViewController(aboutAjouViewController, animated: true)
    }
}

