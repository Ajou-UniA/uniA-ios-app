//
//  LoginViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/10.
//

import SnapKit
import Then
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    //MARK: - Properties

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
    }
    
    lazy var passwordLabel = UILabel().then {
        $0.text = "Password"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }
    
    lazy var passwordTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
        $0.addLeftPadding()
    }
    
    lazy var checkBoxBtn = UIButton().then {
        $0.setImage(UIImage(named: "checkbox"), for: .normal)
        $0.addTarget(self, action: #selector(checkBoxBtnTapped), for: .touchUpInside)
    }
    
    lazy var remeberLabel = UILabel().then {
        $0.text = "Remember-me"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }
    
    lazy var forgotLabel = UILabel().then {
        $0.text = "Forgot password?"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }
    lazy var signInBtn = UIButton().then {
        $0.setTitle("Sign in", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
        $0.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
        $0.layer.cornerRadius = 10
    }
    
    lazy var signUpBtn = UIButton().then {
        $0.setTitle("Sign up", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
        $0.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(signUpBtnTapped), for: .touchUpInside)

    }
    //MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setUpView()
        setUpConstraints()
    }
    //MARK: - Helper

    func setUpView() {
        [titleLabel,emailLabel,emailTextField,passwordLabel,passwordTextField,remeberLabel,forgotLabel,signInBtn,signUpBtn,checkBoxBtn].forEach {
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
    }
    //MARK: -BtnAction
    @objc func signUpBtnTapped() {
        //SignUpBtn 누르면 남아있는 textfield 값 지워주기
        emailTextField.text = nil
        passwordTextField.text = nil
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    var flag = 1
    @objc func checkBoxBtnTapped() {
        if flag == 1{
            checkBoxBtn.setImage(UIImage(named: "checkboxSelected"), for: .normal)
            flag = 0
        }else {
            checkBoxBtn.setImage(UIImage(named: "checkbox"), for: .normal)
            flag = 1
        }
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
    //MARK: - Extension
//textField padding 값 넣어주기
extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
