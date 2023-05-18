//
//  DeleteAccountController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/15.
//

import SnapKit
import Then
import UIKit

class DeleteAccountViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Properties
    lazy var backBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "chevron_left"), for: .normal)
        $0.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    lazy var titleLabel = UILabel().then {
        $0.text = "Delete Account"
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
    lazy var confirmLabel = UILabel().then {
        $0.text = "Confirm Password"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }
    
    lazy var confirmTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
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
    
    lazy var warningLabel = UILabel().then {
        $0.text = ""
        $0.textColor = UIColor(red: 0.875, green: 0.094, blue: 0.094, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 10)
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        passwordTextField.delegate = self
        confirmTextField.delegate = self
        
        setUpView()
        setUpConstraints()
    }
    // MARK: - Helper

    func setUpView() {
        [borderView, backBtn, titleLabel, passwordLabel, passwordTextField, confirmLabel, confirmTextField, submitBtn, warningLabel].forEach {
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
        confirmLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        confirmTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(44)
            $0.bottom.equalTo(passwordTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
     
        submitBtn.snp.makeConstraints {
            $0.top.equalTo(confirmTextField.snp.bottom).offset(44)
            $0.bottom.equalTo(confirmTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(confirmTextField.snp.bottom).offset(1)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        
    }
    // MARK: - TextFieldDelegate
    
    // textfield 입력 시 borderColor 색깔변경
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = CGColor(red: 0.498, green: 0.867, blue: 1, alpha: 1)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
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
    
    let deleteAccess = DeleteAccountApiModel()
    let memberPassword = UserDefaults.standard.string(forKey: "password")
    let memberId = UserDefaults.standard.integer(forKey: "memberId")

    var id: Int = 0

    @objc
    func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func submitBtnTapped() { // alert를 띄우고 ok 버튼 누르면 다음 화면으로 이동

        if memberPassword == passwordTextField.text && passwordTextField.text == confirmTextField.text {
            let msg = UIAlertController(title: "Delete account", message: "Are you sure to leave UniA?", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: . default) { (_) in
            }
            let yesAction = UIAlertAction(title: "Yes", style: . cancel) { (_) in
                let msg = UIAlertController(title: "Account deleted", message: "Your UniA account has been deleted successfully.", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: . cancel) { (_) in
                    self.deleteAccess.deleteAccount(memberId: self.memberId) { data in
                            print(data)
                        }
                    UserDefaults.standard.removeObject(forKey: "memberId")
                    UserDefaults.standard.removeObject(forKey: "password")

                    self.navigationController?.popToRootViewController(animated: true)
                }
                msg.addAction(okAction)
                self.present(msg, animated: true)
            }
            msg.addAction(cancelAction)
            msg.addAction(yesAction)
            self.present(msg, animated: true)
        } else {
            warningLabel.text = "Please make sure your passwords match."
            confirmLabel.textColor = UIColor(red: 0.875, green: 0.095, blue: 0.095, alpha: 1)
            confirmTextField.layer.borderColor = UIColor(red: 0.875, green: 0.095, blue: 0.095, alpha: 1).cgColor
        }
    }
}
