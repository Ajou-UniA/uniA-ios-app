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
        $0.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
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
    
    lazy var passwordLabel = UILabel().then {
        $0.text = "Password"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var passwordTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.addLeftPadding()
    }
    
    lazy var checkBoxBtn = UIButton().then {
        $0.setImage(UIImage(named: "checkbox"), for: .normal)
        $0.addTarget(self, action: #selector(checkBoxBtnTapped), for: .touchUpInside)
    }
    
    lazy var remeberLabel = UILabel().then {
        $0.text = "Remember-me"
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    lazy var forgotBtn = UIButton().then {
        $0.setTitle("Forgot password?", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12)
    }
    
    lazy var signInBtn = UIButton().then {
        $0.setTitle("Sign in", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
        $0.layer.cornerRadius = 10
    }
    
    lazy var signUpBtn = UIButton().then {
        $0.setTitle("Sign up", for: .normal)
        $0.setTitleColor(.white, for: .normal)
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
        [titleLabel,emailLabel,emailTextField,passwordLabel,passwordTextField,remeberLabel,forgotBtn,signInBtn,signUpBtn,checkBoxBtn].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(161)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 140)
            $0.height.equalTo(Constant.height * 22)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 126)
            $0.height.equalTo(Constant.height * 22)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(27)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 140)
            $0.height.equalTo(Constant.height * 22)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(49)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        
        forgotBtn.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(15)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(38)
            $0.width.equalTo(Constant.width * 110)
            $0.height.equalTo(Constant.height * 22)
        }
        
        checkBoxBtn.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(38)
            $0.width.equalTo(Constant.width * 20)
            $0.height.equalTo(Constant.height * 20)
        }
        
        remeberLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(15)
            $0.leading.equalTo(checkBoxBtn.snp.trailing).offset(3)
            $0.width.equalTo(Constant.width * 90)
            $0.height.equalTo(Constant.height * 22)
        }

        signInBtn.snp.makeConstraints {
            $0.top.equalTo(remeberLabel.snp.bottom).offset(26)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        signUpBtn.snp.makeConstraints {
            $0.top.equalTo(signInBtn.snp.bottom).offset(11)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
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
