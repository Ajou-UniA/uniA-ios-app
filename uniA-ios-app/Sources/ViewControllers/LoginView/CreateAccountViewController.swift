//
//  CreateAccountViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/03/15.
//

import SnapKit
import Then
import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    //MARK: - Properties
    let pickerView = UIPickerView()
    let pick = pickerdata
    var selectCity = ""
    lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = .white
    }
    
    lazy var titleLabel = UILabel().then {
        $0.text = "Create Account"
        $0.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
    }
    
    lazy var firstNameLabel = UILabel().then {
        $0.text = "First Name"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var firstNameTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.addLeftPadding()
    }
    lazy var lastNameLabel = UILabel().then {
        $0.text = "Last Name"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var lastNameTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.addLeftPadding()
    }
    lazy var studentIdLabel = UILabel().then {
        $0.text = "Student ID"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var studentIdTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.addLeftPadding()
    }
    lazy var departmentLabel = UILabel().then {
        $0.text = "Department"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var departmentTextField = UITextField().then {
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
    lazy var confirmPasswordLabel = UILabel().then {
        $0.text = "Confirm Password"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var confirmPasswordTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.addLeftPadding()
    }
    
    lazy var signUpBtn = UIButton().then {
        $0.setTitle("Sign up", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
        $0.layer.cornerRadius = 10
    }
    
    lazy var policyLabel = UILabel().then {
        $0.text = "By signing up, you agree to the User Agreement & Privace \nPolicy."
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    lazy var toolbar = UIToolbar().then {
        $0.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTapped))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelButtonTapped))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        $0.setItems([cancelButton,space,doneButton], animated: true)
        $0.isUserInteractionEnabled = true
    }
    
    
        //MARK: - Lifecycles
   
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        signUpBtn.addTarget(self, action: #selector(signUpBtnTapped), for: .touchUpInside)
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        studentIdTextField.delegate = self
        departmentTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        departmentTextField.inputView = pickerView
        departmentTextField.inputAccessoryView = toolbar

        scrollTap()
        setUpView()
        setUpConstraints()
    }
    
    //MARK: - Helper

    func setUpView() {
        self.view.addSubview(scrollView)

        [titleLabel,firstNameLabel,firstNameTextField,lastNameLabel,lastNameTextField,studentIdLabel,studentIdTextField,departmentLabel,departmentTextField,passwordLabel,passwordTextField,confirmPasswordLabel,confirmPasswordTextField,signUpBtn,policyLabel].forEach {
            scrollView.addSubview($0)
        }
    }

    func setUpConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview() // pin to all edges of superview
        }
     
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 220)
            $0.height.equalTo(Constant.height * 25)
                  
        }
        firstNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(35)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 100)
            $0.height.equalTo(Constant.height * 22)
        }
        firstNameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(57)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        lastNameLabel.snp.makeConstraints {
            $0.top.equalTo(firstNameTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 100)
            $0.height.equalTo(Constant.height * 22)
        }
        lastNameTextField.snp.makeConstraints {
            $0.top.equalTo(firstNameTextField.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        studentIdLabel.snp.makeConstraints {
            $0.top.equalTo(lastNameTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 100)
            $0.height.equalTo(Constant.height * 22)
        }
        studentIdTextField.snp.makeConstraints {
            $0.top.equalTo(lastNameTextField.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        departmentLabel.snp.makeConstraints {
            $0.top.equalTo(studentIdTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 100)
            $0.height.equalTo(Constant.height * 22)
        }
        departmentTextField.snp.makeConstraints {
            $0.top.equalTo(studentIdTextField.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(departmentTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 100)
            $0.height.equalTo(Constant.height * 22)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(departmentTextField.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        confirmPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 140)
            $0.height.equalTo(Constant.height * 22)
        }
        confirmPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        signUpBtn.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        policyLabel.snp.makeConstraints {
            $0.top.equalTo(signUpBtn.snp.bottom).offset(18)
            $0.bottom.equalToSuperview() //마지막에 있는건 무조건..바텀값 주자..안그러면 작동안한다..
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 320)
            $0.height.equalTo(Constant.height * 30)
        }
    }
    //MARK: -PickerView
    //pickerView column 수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
    //pickerView row 수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerdata.count
        }
    //pickerView 보여지는 값
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerdata[row]
        }
    //pickerView 선택시 데이터 호출
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          selectCity = pickerdata[row]
      }
    //pickerView text color
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        return NSAttributedString(string: pickerdata[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)])
//    }
    @objc func onDoneButtonTapped() {
        departmentTextField.text = selectCity
        departmentTextField.resignFirstResponder() //pickerView 내리기
        selectCity = ""
        }
    
    @objc func onCancelButtonTapped() {
        departmentTextField.resignFirstResponder()
        selectCity = ""
        }
    
    //MARK: - scrollView tap시 keboard 내리기
    func scrollTap(){
            let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
            singleTapGestureRecognizer.numberOfTapsRequired = 1
            singleTapGestureRecognizer.isEnabled = true
            singleTapGestureRecognizer.cancelsTouchesInView = false
            scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    @objc
    func MyTapMethod(sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
    }
    //MARK: -Navigation
    @objc
    func signUpBtnTapped() {
        firstNameTextField.text = nil
        lastNameTextField.text = nil
        studentIdTextField.text = nil
        departmentTextField.text = nil
        passwordTextField.text = nil
        confirmPasswordTextField.text = nil
        
        let congratulationsViewController = CongratulationsViewController()
        navigationController?.pushViewController(congratulationsViewController, animated: true)
    }
    //MARK: - TextFieldDelegate
    //textfield 입력 시 borderColor 색깔변경
    func textFieldDidBeginEditing(_ textField: UITextField){
        textField.layer.borderColor = CGColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.systemGray5.cgColor
    }
   
}
