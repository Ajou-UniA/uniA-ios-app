//
//  ResetPasswordViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/02.
//

import SnapKit
import Then
import UIKit

class ResetPasswordViewController: UIViewController {
    //MARK: - Properties
    lazy var backBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "chevron_left"), for: .normal)
        $0.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    lazy var titleLabel = UILabel().then {
        $0.text = "Reset Password"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
    }
    let borderView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    }
    lazy var emailLabel = UILabel().then {
        $0.text = "Email"
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    lazy var emailTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.addLeftPadding()
    }
    lazy var passwordLabel = UILabel().then {
        $0.text = "Password"
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    lazy var passwordTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.addLeftPadding()
    }
    lazy var confirmLabel = UILabel().then {
        $0.text = "Confirm Password"
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    lazy var confirmTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.addLeftPadding()
    }
    lazy var submitBtn = UIButton().then {
        $0.setTitle("Submit", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
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
        [borderView,backBtn,titleLabel,emailLabel,emailTextField,passwordLabel,passwordTextField,confirmLabel,confirmTextField,submitBtn].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        borderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(85)
            $0.height.equalTo(Constant.height * 0.5)
            $0.leading.trailing.equalToSuperview()
        }
        backBtn.snp.makeConstraints {
            $0.bottom.equalTo(borderView.snp.top).offset(-20)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
            $0.width.equalTo(Constant.width * 35)
            $0.height.equalTo(Constant.height * 35)
        }
        titleLabel.snp.makeConstraints{
            $0.bottom.equalTo(borderView.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 180)
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(35)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 100)
            $0.height.equalTo(Constant.height * 22)
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(57)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 100)
            $0.height.equalTo(Constant.height * 22)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        confirmLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 130)
            $0.height.equalTo(Constant.height * 22)
        }
        confirmTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        submitBtn.snp.makeConstraints {
            $0.top.equalTo(confirmTextField.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func submitBtnTapped() { //alert를 띄우고 ok 버튼 누르면 다음 화면으로 이동
        let msg = UIAlertController(title: "Password changed", message: "Your password has been changed successfully.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: . cancel){ (_) in
            self.navigationController?.popViewController(animated: true)
        }
        msg.addAction(okAction)
        self.present(msg, animated: true)
    }
}
