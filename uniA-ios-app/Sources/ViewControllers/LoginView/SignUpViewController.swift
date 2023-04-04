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
        $0.font = UIFont(name: "Urbanist-Bold", size: 30)
        $0.numberOfLines = 2
    }
    
    lazy var emailLabel = UILabel().then {
        $0.text = "Email"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
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
        $0.titleLabel?.font = UIFont(name: "Urbanist-Bold", size: 15)
        $0.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(confirmBtnTapped), for: .touchUpInside)
    }
    
    lazy var explainLabel = UILabel().then {
        $0.lineBreakMode = .byWordWrapping
            var paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.41
            $0.attributedText = NSMutableAttributedString(string: "When your Ajou University email verification is complete, \nwe will send you a verification code via your email.", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
            $0.numberOfLines = 2
            $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    lazy var backBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "chevron_left"), for: .normal)
        $0.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true;

        emailTextField.delegate = self
        setUpView()
        setUpConstraints()
    }
    
    //MARK: - Helper
    func setUpView() {
        [titleLabel,emailLabel,emailTextField,confirmBtn,explainLabel,backBtn].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(21)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(30)
            $0.width.equalTo(Constant.width * 24)
            $0.height.equalTo(Constant.height * 24)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backBtn.snp.bottom).offset(74)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(72)
            $0.bottom.equalTo(titleLabel.snp.bottom).offset(124)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        confirmBtn.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(40)
            $0.bottom.equalTo(emailTextField.snp.bottom).offset(92)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(confirmBtn.snp.bottom).offset(15)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
    }
    //MARK: -Navigation
    @objc
    func confirmBtnTapped() {
        emailTextField.text = nil
        let verificationViewController = VerificationViewController()
        navigationController?.pushViewController(verificationViewController, animated: true)
    }
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
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

