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
    // MARK: - Properties

    lazy var titleLabel = UILabel().then {
        $0.text = "Verification Code"
        $0.font = UIFont(name: "Urbanist-Bold", size: 30)
    }
    lazy var timerLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.875, green: 0.094, blue: 0.094, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 12)
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
        $0.attributedText = NSMutableAttributedString(string: "Enter code that we have sent to your Ajou University \nemail.",
                                                      attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    lazy var otpField = CHIOTPFieldOne().then {
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

    var timer: Timer?
    var secondsLeft: Int = 5
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        otpField.delegate = self
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

        setUpView()
        setUpConstraints()
    }
    // MARK: - Helper

    func setUpView() {
        [titleLabel, subtitleLabel, otpField, timerLabel, submitBtn, resendBtn, backBtn].forEach {
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
        
        timerLabel.snp.makeConstraints {
            $0.top.equalTo(otpField.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(38)
           
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
    // MARK: - Navigation
    let verificationAccess = VerificationApiModel()
    let sendCodeAccess = SendCodeApiModel()
    var email: String = ""
    let branch = UserDefaults.standard.integer(forKey: "branch")
    
    @objc
    func submitBtnTapped() { // alert를 띄우고 ok 버튼 누르면 다음 화면으로 이동
        guard let code = otpField.text else {return}

        let bodyData: Parameters = ["email": self.email, "verificationCode": code]
        self.verificationAccess.requestVerificationDataModel(bodyData: bodyData){ data in
            if data.statusCodeValue == 200 {
                let msg = UIAlertController(title: "Verification Success", message: "Your verification code has been verified successfully.", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: . cancel) { (_) in
                    if self.branch == 0 {
                        let createAccountViewController = CreateAccountViewController()
                        self.navigationController?.pushViewController(createAccountViewController, animated: true)

                    } else if self.branch == 1 {
                        let forgotPasswordViewController = ForgotPasswordViewController()
                        self.navigationController?.pushViewController(forgotPasswordViewController, animated: true)
                    }
                    else {
                        return
                    }
                }
                msg.addAction(okAction)
                self.present(msg, animated: true)
            } else {
                let msg = UIAlertController(title: "Invaild verification code", message: "Sorry, this verification code is incorrect. Please verify your code.",
                                            preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: . cancel) { (_) in
            }
            msg.addAction(okAction)
            self.present(msg, animated: true)
            }
        }
    }
    
    @objc func updateTimer() {
        var minutes = self.secondsLeft / 60
        var seconds = self.secondsLeft % 60
        secondsLeft -= 1

        if self.secondsLeft >= -1 {
            self.timerLabel.text = String(format: "Time remaining %02d:%02d", minutes, seconds)
        } else {
            let msg = UIAlertController(title: "Verification code expired", message: "This verification code has expired. Please try again.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: . cancel) { (_) in
        }
            msg.addAction(okAction)
            self.present(msg, animated: true)
            timer?.invalidate()
        }
    }

    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    func resetTimer() {
        self.secondsLeft = 10
        timer?.invalidate()
        timer = nil
        
    }
    @objc func resendBtnTapped() {
        let msg = UIAlertController(title: "Resend Code Success", message: "New verification code has been sent to your Ajou University email.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: . cancel) { (_) in
            self.resetTimer()
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
            self.sendCodeAccess.sendCode(memberEmail: self.email) {  data in
                print(data)
            }
        }
        msg.addAction(okAction)
        self.present(msg, animated: true)
            
    }
}
