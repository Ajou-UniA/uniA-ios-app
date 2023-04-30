//
//  VerificationViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/03/14.
//

import SnapKit
import Then
import UIKit
import CHIOTPField
import Alamofire

class VerificationViewController: UIViewController, UITextFieldDelegate {
    //MARK: - Properties

    lazy var titleLabel = UILabel().then {
        $0.text = "Verification Code"
        $0.font = UIFont(name: "Urbanist-Bold", size: 30)
    }
    lazy var backBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "chevron_left"), for: .normal)
        $0.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    lazy var subtitleLabel = UILabel().then {
        $0.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.39
        $0.attributedText = NSMutableAttributedString(string: "Enter code that we have sent to your Ajou University \nemail.", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    lazy var otpField = CHIOTPFieldOne().then{
        $0.numberOfDigits = 4
        $0.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1)
        $0.cornerRadius = 8
        $0.spacing = 18
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.keyboardType = .numberPad
    }
    
    lazy var submitBtn = UIButton().then {
        $0.setTitle("Submit", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
        $0.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
    }
    lazy var resendBtn = UIButton().then {
        $0.setTitle("Resend Code", for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(resendBtnTapped), for: .touchUpInside)
    }
    
    //MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        otpField.delegate = self

        setUpView()
        setUpConstraints()
    }
    //MARK: - Helper

    func setUpView() {
        [titleLabel,subtitleLabel,otpField,submitBtn,resendBtn,backBtn].forEach {
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
            $0.top.equalTo(backBtn.snp.top).offset(89)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
           
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(25)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        otpField.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(25)
            $0.bottom.equalTo(subtitleLabel.snp.bottom).offset(73)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(38)
        }
        submitBtn.snp.makeConstraints {
            $0.top.equalTo(otpField.snp.bottom).offset(40)
            $0.bottom.equalTo(otpField.snp.bottom).offset(92)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
         
        }
        resendBtn.snp.makeConstraints {
            $0.top.equalTo(submitBtn.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
    }
    //MARK: -Navigation
    let verificationAccess = VerificationApiModel()
    let sendCodeAccess = SendCodeApiModel()
    var email : String = ""
    
    @objc
    func submitBtnTapped() { //alert를 띄우고 ok 버튼 누르면 다음 화면으로 이동
        guard let code = otpField.text else {return}

        let msg = UIAlertController(title: "Verification Success", message: "Your verification code has been verified successfully.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: . cancel){ (_) in
            
            let bodyData : Parameters = ["email" : self.email , "verificationCode" : code ]
            self.verificationAccess.requestVerificationDataModel(bodyData: bodyData)
            
            let createAccountViewController = CreateAccountViewController()
            self.navigationController?.pushViewController(createAccountViewController, animated: true)

        }
        msg.addAction(okAction)
        self.present(msg, animated: true)
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func resendBtnTapped() {
        sendCodeAccess.sendCode(email: "gkxotjs12@ajou.ac.kr"){  data in
            print(data)
        }
        
    }
}

