//
//  CreateAccountViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/03/15.
//

import SnapKit
import Then
import UIKit
import Alamofire
import RxKeyboard
import RxSwift
import RxCocoa

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Properties

    let pickerView = UIPickerView()
    let pick = pickerdata
    var selectMajor = ""
    lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = .white
    }

    lazy var backBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "chevron_left"), for: .normal)
        $0.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }

    lazy var titleLabel = UILabel().then {
        $0.text = "Create Account"
        $0.font = UIFont(name: "Urbanist-Bold", size: 30)
    }

    lazy var firstNameLabel = UILabel().then {
        $0.text = "First Name"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }

    lazy var firstNameTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
        $0.addLeftPadding()
    }
    lazy var lastNameLabel = UILabel().then {
        $0.text = "Last Name"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }

    lazy var lastNameTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
        $0.addLeftPadding()
    }
    lazy var studentIdLabel = UILabel().then {
        $0.text = "Student ID"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }

    lazy var studentIdTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
        $0.addLeftPadding()
    }
    lazy var departmentLabel = UILabel().then {
        $0.text = "Department"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }

    lazy var departmentTextField = UITextField().then {
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
        $0.isSecureTextEntry = true
        $0.addLeftPadding()
    }

    lazy var confirmPasswordLabel = UILabel().then {
        $0.text = "Confirm Password"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }

    lazy var confirmPasswordTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.isEnabled = false
        $0.isSecureTextEntry = true
        $0.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
        $0.addLeftPadding()
    }

    lazy var submitBtn = UIButton().then {
        $0.setTitle("Submit", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }

    lazy var policyLabel = UILabel().then {
        $0.text = ""
        }

    lazy var toolbar = UIToolbar().then {
        $0.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTapped))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelButtonTapped))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        $0.setItems([cancelButton, space, doneButton], animated: true)
        $0.isUserInteractionEnabled = true
    }

    lazy var warningLabel1 = UILabel().then {
        $0.text = ""
        $0.numberOfLines = 0
        $0.textColor = UIColor(red: 0.875, green: 0.094, blue: 0.094, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 10)
    }
    lazy var warningLabel2 = UILabel().then {
        $0.text = ""
        $0.numberOfLines = 0
        $0.textColor = UIColor(red: 0.875, green: 0.094, blue: 0.094, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 10)
    }

        // MARK: - Lifecycles
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
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

        self.navigationController?.navigationBar.isHidden = true

        scrollTap()
        setUpView()
        setUpConstraints()

        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: passwordTextField)

        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] keyboardVisibleHeight in
                guard let strongSelf = self else { return }

                if strongSelf.confirmPasswordTextField.isFirstResponder || strongSelf.passwordTextField.isFirstResponder
                    || strongSelf.departmentTextField.isFirstResponder {
                    strongSelf.adjustButtonPositionForKeyboard(height: keyboardVisibleHeight)
                }
            })
            .disposed(by: disposeBag)
    }



    // MARK: - Helper

    func setUpView() {
        self.view.addSubview(scrollView)
        self.view.addSubview(backBtn)
        [titleLabel, firstNameLabel, firstNameTextField, lastNameLabel, lastNameTextField, studentIdLabel, studentIdTextField, departmentLabel, departmentTextField,
         passwordLabel, passwordTextField, warningLabel1, warningLabel2, confirmPasswordLabel, confirmPasswordTextField, submitBtn, policyLabel].forEach {
            scrollView.addSubview($0)
        }
    }

    func setUpConstraints() {

        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
            $0.width.equalTo(Constant.width * 24)
            $0.height.equalTo(backBtn.snp.width).multipliedBy(1.0/1.0)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(backBtn.snp.bottom).offset(39)
            $0.bottom.trailing.leading.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        firstNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(35)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        firstNameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(57)
            $0.bottom.equalTo(titleLabel.snp.bottom).offset(109)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        lastNameLabel.snp.makeConstraints {
            $0.top.equalTo(firstNameTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        lastNameTextField.snp.makeConstraints {
            $0.top.equalTo(firstNameTextField.snp.bottom).offset(44)
            $0.bottom.equalTo(firstNameTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        studentIdLabel.snp.makeConstraints {
            $0.top.equalTo(lastNameTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        studentIdTextField.snp.makeConstraints {
            $0.top.equalTo(lastNameTextField.snp.bottom).offset(44)
            $0.bottom.equalTo(lastNameTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        departmentLabel.snp.makeConstraints {
            $0.top.equalTo(studentIdTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        departmentTextField.snp.makeConstraints {
            $0.top.equalTo(studentIdTextField.snp.bottom).offset(44)
            $0.bottom.equalTo(studentIdTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(departmentTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(departmentTextField.snp.bottom).offset(44)
            $0.bottom.equalTo(departmentTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        warningLabel1.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(1)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        warningLabel2.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(1)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        confirmPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(24) //22
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        confirmPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(44)
            $0.bottom.equalTo(passwordTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        submitBtn.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(40)
            $0.bottom.equalTo(confirmPasswordTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)

        }

        policyLabel.snp.makeConstraints {
            $0.top.equalTo(submitBtn.snp.bottom).offset(18)
            $0.bottom.equalToSuperview() // 마지막에 있는건 무조건..바텀값 주자..안그러면 작동안한다..
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
    }

    // MARK: - adjustButtonPosition

    private func adjustButtonPositionForKeyboard(height: CGFloat) {
        let bottomInset = max(height - scrollView.safeAreaInsets.bottom, 0)
        scrollView.contentInset.bottom = bottomInset

        let scrollViewBottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom)
        scrollView.setContentOffset(scrollViewBottomOffset, animated: true)
    }

    // MARK: - scrollView tap시 keboard 내리기

    func scrollTap() {
            let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTapMethod))
            singleTapGestureRecognizer.numberOfTapsRequired = 1
            singleTapGestureRecognizer.isEnabled = true
            singleTapGestureRecognizer.cancelsTouchesInView = false
            scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }

    @objc
    func myTapMethod(sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
    }
    // MARK: - Navigation
    let createAccountAccess = CreateAccountApiModel()
    let memberEmail = UserDefaults.standard.string(forKey: "email")

    @objc
    func submitBtnTapped() {

        guard let firstName = firstNameTextField.text,
         let lastName = lastNameTextField.text,
         let memberId = studentIdTextField.text,
         let memberMajor = departmentTextField.text,
         let memberPassword = passwordTextField.text,
         let memberConfirmPassword = confirmPasswordTextField.text else {return}

        let isEmptyField = firstName.isEmpty || lastName.isEmpty || memberId.isEmpty || memberMajor.isEmpty || memberPassword.isEmpty || memberConfirmPassword.isEmpty
            if isEmptyField {
                let msg = UIAlertController(title: "Empty field", message: "It looks like you forgot to fill in this field. Please enter a value.", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: . cancel) { (_) in
            }
            msg.addAction(okAction)
            self.present(msg, animated: true)
                print("공백하나라도 있다.")
                return
            }
            // password와 confirmPassword 일치 여부 체크
            if memberPassword != memberConfirmPassword {
                warningLabel2.text = "Please make sure your passwords match."
                confirmPasswordLabel.textColor = UIColor(red: 0.875, green: 0.095, blue: 0.095, alpha: 1)
                confirmPasswordTextField.layer.borderColor = UIColor(red: 0.875, green: 0.095, blue: 0.095, alpha: 1).cgColor
                return
            }

         let bodyData: Parameters = [
            "firstName": firstName,
            "lastName": lastName,
            "memberConfirmPassword": memberConfirmPassword,
            "memberEmail": memberEmail,
            "memberId": Int(memberId),
            "memberMajor": memberMajor,
            "memberPassword": memberPassword
        ]

        createAccountAccess.requestSignUpDataModel(bodyData: bodyData) { data in
            print(data.body)
        }

        let congratulationsViewController = CongratulationsViewController()
        navigationController?.pushViewController(congratulationsViewController, animated: true)
    }
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - TextFieldDelegate
    // textfield 입력 시 borderColor 색깔변경
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = CGColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
        warningLabel2.text = ""
        confirmPasswordLabel.textColor = .black
        confirmPasswordTextField.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor

    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
        passwordLabel.textColor = .black
        warningLabel1.text = ""

    }



    @objc private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {

                if text.count > 12 {
                    // 8글자 넘어가면 자동으로 키보드 내려감
                    textField.resignFirstResponder()
                }

                // 초과되는 텍스트 제거
                if text.count >= 12 {
                    let index = text.index(text.startIndex, offsetBy: 12)
                    let newString = text[text.startIndex..<index]
                    textField.text = String(newString)
                }

                // 특수문자 포함 여부 체크
                let specialCharSet = CharacterSet(charactersIn: "!@#$%^&*()-_=+[{]};:'\",<.>/?")
                let hasSpecialChar = text.rangeOfCharacter(from: specialCharSet) != nil

                if text.count < 8 || !hasSpecialChar {
                    warningLabel1.text = "Your password must contain at least 8 characters and 1 special character."
                    warningLabel1.textColor = UIColor(red: 0.875, green: 0.095, blue: 0.095, alpha: 1)
                    passwordTextField.layer.borderColor = UIColor(red: 0.875, green: 0.095, blue: 0.095, alpha: 1).cgColor
                    passwordLabel.textColor = UIColor(red: 0.875, green: 0.095, blue: 0.095, alpha: 1)
                    confirmPasswordTextField.isEnabled = false

                } else {
                    warningLabel1.text = "Your password is great."
                    warningLabel1.textColor = UIColor(red: 0.13, green: 0.842, blue: 0.286, alpha: 1)
                    passwordTextField.layer.borderColor = UIColor(red: 0.13, green: 0.842, blue: 0.286, alpha: 1).cgColor
                    passwordLabel.textColor = UIColor(red: 0.13, green: 0.842, blue: 0.286, alpha: 1)
                    confirmPasswordTextField.isEnabled = true
                }
            }

        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension CreateAccountViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // pickerView column 수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
    // pickerView row 수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerdata.count
        }
    // pickerView 보여지는 값
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerdata[row]
        }
    // pickerView 선택시 데이터 호출
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          selectMajor = pickerdata[row]
      }
    // pickerView text color
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        return NSAttributedString(string: pickerdata[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)])
//    }
    @objc func onDoneButtonTapped() {
        departmentTextField.text = selectMajor
        departmentTextField.resignFirstResponder() // pickerView 내리기
        selectMajor = ""
        }

    @objc func onCancelButtonTapped() {
        departmentTextField.resignFirstResponder()
        selectMajor = ""
        }

}


