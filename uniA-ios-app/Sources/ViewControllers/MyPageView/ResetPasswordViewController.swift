//
//  ResetPasswordViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/02.
//

import SnapKit
import Then
import UIKit

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Properties
    lazy var backBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "chevron_left"), for: .normal)
        $0.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    lazy var titleLabel = UILabel().then {
        $0.text = "Reset Password"
        $0.textColor = .black
        $0.font = UIFont(name: "Urbanist-Bold", size: 30)
    }
    let borderView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }
    
    lazy var passwordLabel = UILabel().then {
        $0.text = "Password"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }
    
    lazy var passwordTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
        $0.isSecureTextEntry = true
        $0.addLeftPadding()
    }
    
    lazy var newPasswordLabel = UILabel().then {
        $0.text = "New Password"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }
    
    lazy var newPasswordTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
        $0.isSecureTextEntry = true
        $0.addLeftPadding()
    }
    lazy var confirmPasswordLabel = UILabel().then {
        $0.text = "Confirm Password"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }
    
    lazy var confirmPasswordTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.isEnabled = false
        $0.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
        $0.isSecureTextEntry = true
        $0.addLeftPadding()
    }
    lazy var submitBtn = UIButton().then {
        $0.setTitle("Submit", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 0.498, green: 0.867, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }
    lazy var warningLabel1 = UILabel().then {
        $0.text = ""
        $0.textColor = UIColor(red: 0.875, green: 0.094, blue: 0.094, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 10)
    }
    lazy var warningLabel2 = UILabel().then {
        $0.text = ""
        $0.textColor = UIColor(red: 0.875, green: 0.094, blue: 0.094, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 10)
    }
    
    // MARK: - Lifecycles

    let memberInfoAccess = FindMemberApiModel()
    let memberId = UserDefaults.standard.integer(forKey: "memberId")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        newPasswordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        setUpView()
        setUpConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: newPasswordTextField)
    }
    // MARK: - Helper

    func setUpView() {
        [borderView, backBtn, titleLabel, passwordLabel, passwordTextField,
         newPasswordLabel, newPasswordTextField, confirmPasswordLabel, confirmPasswordTextField, submitBtn, warningLabel1, warningLabel2].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
            $0.width.equalTo(Constant.width * 24)
            $0.height.equalTo(Constant.height * 24)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            $0.centerX.equalToSuperview()
        }
        borderView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(22)
            $0.height.equalTo(Constant.height * 0.5)
            $0.leading.trailing.equalToSuperview()
        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(35)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(59)
            $0.bottom.equalTo(borderView.snp.bottom).offset(111)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        
        newPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        newPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(44)
            $0.bottom.equalTo(passwordTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        confirmPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(newPasswordTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        confirmPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(newPasswordTextField.snp.bottom).offset(44)
            $0.bottom.equalTo(newPasswordTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        submitBtn.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(40)
            $0.bottom.equalTo(confirmPasswordTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        warningLabel1.snp.makeConstraints {
            $0.top.equalTo(newPasswordTextField.snp.bottom).offset(1)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        warningLabel2.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(1)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        
    }
    // MARK: - TextFieldDelegate
    
    // textfield 입력 시 borderColor 색깔변경
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = CGColor(red: 0.498, green: 0.867, blue: 1, alpha: 1)
        confirmPasswordLabel.textColor = .black
        warningLabel2.text = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
        warningLabel1.text = ""
        newPasswordLabel.textColor = .black
    }
    // 화면 터치시 keybord 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Objc
    let resetAccess = ResetPasswordApiModel()
    let editAccess = EditMyProfileApiModel()
    let password = UserDefaults.standard.string(forKey: "password")

    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func submitBtnTapped() { // alert를 띄우고 ok 버튼 누르면 다음 화면으로 이동
        if passwordTextField.text == password {
            
        }
        if newPasswordTextField.text == confirmPasswordTextField.text {
            let msg = UIAlertController(title: "Password changed", message: "Your password has been changed successfully.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: . cancel) { (_) in
                self.resetAccess.resetPassword(newPassword: self.newPasswordTextField.text!, memberId: self.memberId){ data in
                self.navigationController?.popViewController(animated: true)
                }
            }
            msg.addAction(okAction)
            self.present(msg, animated: true)
        } else {
            warningLabel2.text = "Please make sure your passwords match."
            confirmPasswordLabel.textColor = UIColor(red: 0.875, green: 0.095, blue: 0.095, alpha: 1)
            confirmPasswordTextField.layer.borderColor = UIColor(red: 0.875, green: 0.095, blue: 0.095, alpha: 1).cgColor
        }
    }
    
    @objc
    private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                
                if text.count > 12 {
                // 8글자 넘어가면 자동으로 키보드 내려감
                    textField.resignFirstResponder()
                }
                // 초과되는 텍스트 제거
                if text.count >= 12 {
                    let index = text.index(text.startIndex, offsetBy: 12)
                    let newString = text[text.startIndex..<index]
                    textField.text = String(newString)
                }
                // 특수문자 포함 여부 체크
                let specialCharSet = CharacterSet(charactersIn: "!@#$%^&*()-_=+[{]};:'\",<.>/?")
                let hasSpecialChar = text.rangeOfCharacter(from: specialCharSet) != nil
                
                if text.count < 8 || !hasSpecialChar {
                    warningLabel1.text = "Your password must contain at least 8 characters and 1 special character."
                    warningLabel1.textColor = UIColor(red: 0.875, green: 0.095, blue: 0.095, alpha: 1)
                    newPasswordTextField.layer.borderColor = UIColor(red: 0.875, green: 0.095, blue: 0.095, alpha: 1).cgColor
                    newPasswordLabel.textColor = UIColor(red: 0.875, green: 0.095, blue: 0.095, alpha: 1)
                    confirmPasswordTextField.isEnabled = false

                } else {
                    warningLabel1.text = "Your password is great."
                    warningLabel1.textColor = UIColor(red: 0.13, green: 0.842, blue: 0.286, alpha: 1)
                    newPasswordTextField.layer.borderColor = UIColor(red: 0.13, green: 0.842, blue: 0.286, alpha: 1).cgColor
                    newPasswordLabel.textColor = UIColor(red: 0.13, green: 0.842, blue: 0.286, alpha: 1)
                    confirmPasswordTextField.isEnabled = true
                }
            }
        }
    }
}
