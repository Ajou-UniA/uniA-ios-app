//
//  MyPageViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/10.
//

import SnapKit
import Then
import UIKit

class MyPageViewController: UIViewController {
    // MARK: - Properties
    lazy var midView = UIView().then {
        $0.backgroundColor = .white
    }
    lazy var titleLabel = UILabel().then {
        $0.text = "My Page"
        $0.textAlignment = .left
        $0.font = UIFont(name: "Urbanist-Bold", size: 30)
    }
    lazy var subtitleLabel = UILabel().then {
        $0.text = "Account"
        $0.textAlignment = .left
        $0.font = UIFont(name: "Urbanist-Bold", size: 20)
    }
    lazy var nameLabel = UILabel().then {
        $0.text = "UniA Paranni"
        $0.textAlignment = .left
        $0.font = UIFont(name: "Urbanist-Bold", size: 18)
    }
    lazy var majorLabel = UILabel().then {
        $0.text = "Software and Computer Engineering"
        $0.textAlignment = .left
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 15)
        $0.numberOfLines = 0
    }
    lazy var numberLabel = UILabel().then {
        $0.text = "202021766"
        $0.textAlignment = .left
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }
    lazy var resetBtn = UIButton().then {
        $0.setTitle("Reset Password", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(resetBtnTapped), for: .touchUpInside)

    }
    lazy var deleteBtn = UIButton().then {
        $0.setTitle("Delete Account", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(deleteBtnTapped), for: .touchUpInside)
    }
    
    lazy var editBtn = UIButton().then {
        $0.setTitle("Edit my Profile", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(editBtnTapped), for: .touchUpInside)
    }
    
    lazy var logoutBtn = UIButton().then {
        $0.setTitle("Log Out", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(logoutBtnTapped), for: .touchUpInside)
    }
    
    lazy var profileView = UIImageView().then {
        $0.image = UIImage(named: "profileLogo")
    }
    
    let borderView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }
    
    lazy var circleView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 42.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemGray5.cgColor
    }
    
    // MARK: - Lifecycles
    let memberInfoAccess = FindMemberApiModel()
    let memberId = UserDefaults.standard.integer(forKey: "memberId")

    override func viewWillAppear(_ animated: Bool) {
        memberInfoAccess.findByMemberId(memberId: memberId){ data in
            self.nameLabel.text = "\(data.lastName!)\(data.firstName!)"
            self.majorLabel.text = data.memberMajor
            self.numberLabel.text = String(data.memberId!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setUpView()
        setUpConstraints()
    }
    // MARK: - Helper

    func setUpView() {
        [titleLabel, midView, subtitleLabel, resetBtn, deleteBtn, editBtn, logoutBtn, borderView].forEach {
            view.addSubview($0)
        }
        [circleView, majorLabel, numberLabel, nameLabel, profileView].forEach {
            midView.addSubview($0)
        }
    }

    func setUpConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
        }

        midView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.height.equalTo(Constant.width * 143)
        }
        borderView.snp.makeConstraints {
            $0.top.equalTo(numberLabel.snp.bottom).offset(38)
            $0.height.equalTo(Constant.height * 0.5)
            $0.leading.trailing.equalToSuperview()
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(21)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
        }
        resetBtn.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.width.equalTo(Constant.width * 120)
            $0.height.equalTo(Constant.height * 25)
        }
        deleteBtn.snp.makeConstraints {
            $0.top.equalTo(resetBtn.snp.bottom).offset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.width.equalTo(Constant.width * 110)
            $0.height.equalTo(Constant.height * 25)
        }
        editBtn.snp.makeConstraints {
            $0.top.equalTo(deleteBtn.snp.bottom).offset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.width.equalTo(Constant.width * 110)
            $0.height.equalTo(Constant.height * 25)
        }
        logoutBtn.snp.makeConstraints {
            $0.top.equalTo(editBtn.snp.bottom).offset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.width.equalTo(Constant.width * 95)
            $0.height.equalTo(Constant.height * 25)
        }
        circleView.snp.makeConstraints {
            $0.top.equalTo(midView.snp.top).offset(31)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(17)
            $0.width.equalTo(Constant.width * 84)
            $0.height.equalTo(Constant.height * 84)
        }
        
        profileView.snp.makeConstraints {
            $0.top.equalTo(midView.snp.top).offset(49)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(36)
            $0.width.equalTo(Constant.width * 45)
            $0.height.equalTo(Constant.height * 49)
            
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(midView.snp.top).offset(37)
            $0.leading.equalTo(profileView.snp.trailing).offset(37)
            
        }
        majorLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(profileView.snp.trailing).offset(37)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(20)

        }
        numberLabel.snp.makeConstraints {
            $0.top.equalTo(majorLabel.snp.bottom).offset(10)
            $0.leading.equalTo(profileView.snp.trailing).offset(37)
            
        }
        
    }
    // MARK: - Navigation
    
    let logoutAccess = LogoutApiModel()
    
    @objc
    func resetBtnTapped() {
        let resetPasswordViewController = ResetPasswordViewController()
        navigationController?.pushViewController(resetPasswordViewController, animated: true)
    }
    @objc
    func editBtnTapped() {
        let editMyProfileViewController = EditMyProfileViewController()
        navigationController?.pushViewController(editMyProfileViewController, animated: true)
    }
    @objc
    func deleteBtnTapped() {
        let deleteAccountController = DeleteAccountViewController()
        navigationController?.pushViewController(deleteAccountController, animated: true)
    }
    
    @objc
    func logoutBtnTapped() { // alert를 띄우고 ok 버튼 누르면 다음 화면으로 이동
        let msg = UIAlertController(title: "Log out", message: "Are you sure to log out UniA?", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: . default) { (_) in

        }
        let yesAction = UIAlertAction(title: "Yes", style: . cancel) { (_) in
            self.logoutAccess.logout() { data in
                print(data.body)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        msg.addAction(cancelAction)
        msg.addAction(yesAction)
        self.present(msg, animated: true)
    }
}
