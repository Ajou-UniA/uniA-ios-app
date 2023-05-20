//
//  LoginViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/10.
//

import SnapKit
import Then
import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Properties

    lazy var titleLabel = UILabel().then {
        $0.text = "Welcome!"
        $0.font = UIFont(name: "Urbanist-Bold", size: 30)
    }

    lazy var emailLabel = UILabel().then {
        $0.text = "Email"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }

    lazy var emailTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
        $0.addLeftPadding()
        $0.autocapitalizationType = .none
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

    lazy var checkBoxBtn = UIButton().then {
        $0.setImage(UIImage(named: "checkbox"), for: .normal)
        $0.addTarget(self, action: #selector(checkBoxBtnTapped), for: .touchUpInside)
    }
    lazy var toggleBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        $0.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        $0.tintColor = .systemGray3
        $0.addTarget(self, action: #selector(toggleBtnTapped), for: .touchUpInside)
    }

    lazy var remeberLabel = UILabel().then {
        $0.text = "Remember-me"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }

    lazy var forgotLabel = UILabel().then {
        $0.text = "Forgot password?"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
        $0.isUserInteractionEnabled = true // Label에 사용자 상호 작용을 활성화합니다.
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(forgotLabelTapped)))
    }
    lazy var signInBtn = UIButton().then {
        $0.setTitle("Sign in", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
        $0.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(signInBtnTapped), for: .touchUpInside)

    }

    lazy var signUpBtn = UIButton().then {
        $0.setTitle("Sign up", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
        $0.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(signUpBtnTapped), for: .touchUpInside)
    }

    let memberInfoAccess = FindMemberApiModel()

    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        emailTextField.delegate = self
        passwordTextField.delegate = self

        if flag == 1 {
            emailTextField.text = UserDefaults.standard.string(forKey: "rememberemail")
            passwordTextField.text = UserDefaults.standard.string(forKey: "rememberpassword")
            checkBoxBtn.setImage(UIImage(named: "checkboxSelected"), for: .normal)
        } else {

        }

        setUpView()
        setUpConstraints()
    }
    // MARK: - Helper

    func setUpView() {
        [titleLabel, emailLabel, emailTextField, passwordLabel, passwordTextField, remeberLabel, forgotLabel, signInBtn, signUpBtn, checkBoxBtn, toggleBtn].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(119)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }

        emailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(52)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(74)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.bottom.equalTo(titleLabel.snp.bottom).offset(126)

        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)

        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(44)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.bottom.equalTo(emailTextField.snp.bottom).offset(96)
        }

        forgotLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(22)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(38)

        }

        checkBoxBtn.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(21)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(38)
            $0.width.equalTo(Constant.width * 20)
            $0.height.equalTo(Constant.height * 20)
        }

        remeberLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(22)
            $0.leading.equalTo(checkBoxBtn.snp.trailing).offset(3)
        }

        signInBtn.snp.makeConstraints {
            $0.top.equalTo(remeberLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(remeberLabel.snp.bottom).offset(72)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)

        }
        signUpBtn.snp.makeConstraints {
            $0.top.equalTo(signInBtn.snp.bottom).offset(10)
            $0.bottom.equalTo(signInBtn.snp.bottom).offset(62)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)

        }
        toggleBtn.snp.makeConstraints {
            $0.leading.equalTo(passwordTextField.snp.trailing).offset(-40)
            $0.centerY.equalTo(passwordTextField)
            $0.width.height.equalTo(30)
        }
    }
    // MARK: - BtnAction
    let signInAccess = SignInApiModel()
    let memberIdAccess = CallMemberApiModel()

    @objc
    func toggleBtnTapped() {
            passwordTextField.isSecureTextEntry.toggle()
            toggleBtn.isSelected = !passwordTextField.isSecureTextEntry
    }

    @objc func signUpBtnTapped() {
        // SignUpBtn 누르면 남아있는 textfield 값 지워주기
        UserDefaults.standard.set(0, forKey: "branch")
        emailTextField.text = nil
        passwordTextField.text = nil
        let policyViewController = PolicyViewController()
        navigationController?.pushViewController(policyViewController, animated: true)
    }

    @objc func signInBtnTapped() {

        guard let loginId = emailTextField.text,
         let password = passwordTextField.text else {return}

        let bodyData: Parameters = [

            //"loginId": "gkxotjs12@ajou.ac.kr",
            //"password": "1234567!"
            "loginId": loginId,
            "password": password
        ]

        signInAccess.requestSignInDataModel(bodyData: bodyData) { data in
            if data == 1 {
                self.memberIdAccess.callMember(memberEmail: self.emailTextField.text!) { data in
                    UserDefaults.standard.set(self.emailTextField.text, forKey: "loginemail")
                    UserDefaults.standard.set(data, forKey: "memberId")
                }
                UserDefaults.standard.set(password, forKey: "password")
                if self.flag == 1 { // remember me check
                    UserDefaults.standard.set(self.emailTextField.text, forKey: "rememberemail")
                    UserDefaults.standard.set(password, forKey: "rememberpassword")
                } else {
                    UserDefaults.standard.removeObject(forKey: "rememberemail")
                    UserDefaults.standard.removeObject(forKey: "rememberpassword")
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                }
                let homeViewController = TabBarController()
                self.navigationController?.pushViewController(homeViewController, animated: true)
            } else {
                let msg = UIAlertController(title: "Login failed", message: "Sorry, incorrect email or password.", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: . cancel) { (_) in
            }
            msg.addAction(okAction)
            self.present(msg, animated: true)
            }
        }
    }

    @objc func forgotLabelTapped() {
        UserDefaults.standard.set(1, forKey: "branch")
        emailTextField.text = nil
        passwordTextField.text = nil
        let signUpViewController = ConfirmEmailViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }

    var flag = 0
    @objc func checkBoxBtnTapped() {
        if flag == 0 {
            checkBoxBtn.setImage(UIImage(named: "checkboxSelected"), for: .normal)
            flag = 1
        } else {
            checkBoxBtn.setImage(UIImage(named: "checkbox"), for: .normal)
            flag = 0
        }
    }
    // MARK: - TextFieldDelegate

    // textfield 입력 시 borderColor 색깔변경
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = CGColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
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
}
    // MARK: - Extension
// textField padding 값 넣어주기
extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
