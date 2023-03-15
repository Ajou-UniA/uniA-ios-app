//
//  CreateAccountViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/03/15.
//

import SnapKit
import Then
import UIKit

class CreateAccountViewController: UIViewController {
    //MARK: - Properties
    
    lazy var titleLabel = UILabel().then {
        $0.text = "Create Account"
        $0.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
    }
    
    lazy var nameLabel = UILabel().then {
        $0.text = "Name"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var nameTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    lazy var studentIdLabel = UILabel().then {
        $0.text = "Student ID"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var studentIdTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    lazy var departmentLabel = UILabel().then {
        $0.text = "Department"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var departmentTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    lazy var passwordLabel = UILabel().then {
        $0.text = "Password"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var passwordTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    lazy var confirmPasswordLabel = UILabel().then {
        $0.text = "Confirm Password"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var confirmPasswordTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    lazy var signUpBtn = UIButton().then {
        $0.setTitle("Sign up", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
    }
    
    lazy var policyLabel = UILabel().then {
        $0.text = "By signing up, you agree to the User Agreement & Privace \nPolicy."
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    //MARK: - Lifecycles

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        signUpBtn.addTarget(self, action: #selector(signUpBtnTapped), for: .touchUpInside)

        setUpView()
        setUpConstraints()
    }
    
    //MARK: - Helper

    func setUpView() {
       
        [titleLabel,nameLabel,nameTextField,studentIdLabel,studentIdTextField,departmentLabel,departmentTextField,passwordLabel,passwordTextField,confirmPasswordLabel,confirmPasswordTextField,signUpBtn,policyLabel].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
      
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 220)
            $0.height.equalTo(Constant.height * 25)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(35)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 100)
            $0.height.equalTo(Constant.height * 22)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(57)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        studentIdLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 100)
            $0.height.equalTo(Constant.height * 22)
        }
        studentIdTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        departmentLabel.snp.makeConstraints {
            $0.top.equalTo(studentIdTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 100)
            $0.height.equalTo(Constant.height * 22)
        }
        departmentTextField.snp.makeConstraints {
            $0.top.equalTo(studentIdTextField.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(departmentTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 100)
            $0.height.equalTo(Constant.height * 22)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(departmentTextField.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        confirmPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 140)
            $0.height.equalTo(Constant.height * 22)
        }
        confirmPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        signUpBtn.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        policyLabel.snp.makeConstraints {
            $0.top.equalTo(signUpBtn.snp.bottom).offset(18)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 320)
            $0.height.equalTo(Constant.height * 30)
        }

    }
    @objc
    func signUpBtnTapped() {
        let congratulationsViewController = CongratulationsViewController()
        navigationController?.pushViewController(congratulationsViewController, animated: true)
    }
}

