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
    lazy var pwLabel = UILabel().then {
        $0.text = "Password"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }
    
    lazy var pwTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
        $0.addLeftPadding()
    }
    lazy var confirmPwLabel = UILabel().then {
        $0.text = "Confirm Password"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }
    
    lazy var confirmPwTextField = UITextField().then {
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
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true;
        pwTextField.delegate = self
        confirmPwTextField.delegate = self
        
        setUpView()
        setUpConstraints()
    }
    // MARK: - Helper

    func setUpView() {
        [borderView, backBtn, titleLabel, pwLabel, pwTextField, confirmPwLabel, confirmPwTextField, submitBtn].forEach {
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
        pwLabel.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(35)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(59)
            $0.bottom.equalTo(borderView.snp.bottom).offset(111)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        confirmPwLabel.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        confirmPwTextField.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(44)
            $0.bottom.equalTo(pwTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
     
        submitBtn.snp.makeConstraints {
            $0.top.equalTo(confirmPwTextField.snp.bottom).offset(44)
            $0.bottom.equalTo(confirmPwTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
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
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func submitBtnTapped() { // alert를 띄우고 ok 버튼 누르면 다음 화면으로 이동
        let msg = UIAlertController(title: "Delete account", message: "Are you sure to leave UniA?", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: . default) { (_) in

        }
        let yesAction = UIAlertAction(title: "Yes", style: . cancel) { (_) in
            let msg = UIAlertController(title: "Account deleted", message: "Your UniA account has been deleted successfully.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: . cancel) { (_) in
                self.navigationController?.popViewController(animated: true)
            }
            msg.addAction(okAction)
            self.present(msg, animated: true)
        }
        msg.addAction(cancelAction)
        msg.addAction(yesAction)
        self.present(msg, animated: true)
    }
}
