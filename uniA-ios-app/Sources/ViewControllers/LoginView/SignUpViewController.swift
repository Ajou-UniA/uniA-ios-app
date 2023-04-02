//
//  SignUpViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/03/14.
//

import SnapKit
import Then
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    //MARK: - Properties
    
    lazy var titleLabel = UILabel().then {
        $0.text = "Confirm Your \nAjou University Email"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        $0.numberOfLines = 2
    }
    
    lazy var emailLabel = UILabel().then {
        $0.text = "Email"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var emailTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.addLeftPadding()
    }
    
    lazy var confirmBtn = UIButton().then {
        $0.setTitle("Confirm", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(confirmBtnTapped), for: .touchUpInside)
    }
    
    lazy var explainLabel = UILabel().then {
        $0.text = "When your Ajou University email verification is complete,\nwe will send you a verification code via your email."
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        emailTextField.delegate = self
        setUpView()
        setUpConstraints()
    }
    
    //MARK: - Helper
    func setUpView() {
        [titleLabel,emailLabel,emailTextField,confirmBtn,explainLabel].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(166)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 290)
            $0.height.equalTo(Constant.height * 80)
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(35)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 126)
            $0.height.equalTo(Constant.height * 22)
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(57)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        confirmBtn.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(33)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(confirmBtn.snp.bottom).offset(18)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 320)
            $0.height.equalTo(Constant.height * 30)
        }
    }
    //MARK: -Navigation
    @objc
    func confirmBtnTapped() {
        emailTextField.text = nil
        let verificationViewController = VerificationViewController()
        navigationController?.pushViewController(verificationViewController, animated: true)
    }
    //MARK: - TextFieldDelegate
    
    //textfield 입력 시 borderColor 색깔변경
    func textFieldDidBeginEditing(_ textField: UITextField){
        textField.layer.borderColor = CGColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemGray5.cgColor
    }
    //화면 터치시 keybord 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

