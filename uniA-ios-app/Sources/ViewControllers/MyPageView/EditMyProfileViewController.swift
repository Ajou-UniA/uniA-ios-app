//
//  EditMyProfileViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/02.
//

import SnapKit
import Then
import UIKit

class EditMyProfileViewController: UIViewController, UITextFieldDelegate {
    //MARK: - Properties
    lazy var backBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "chevron_left"), for: .normal)
        $0.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
    }
    
    lazy var titleLabel = UILabel().then {
        $0.text = "Edit My Profile"
        $0.textColor = .black
        $0.font = UIFont(name: "Urbanist-Bold", size: 30)
    }
    let borderView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
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
    lazy var saveBtn = UIButton().then {
        $0.setTitle("Save", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 0.498, green: 0.867, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(saveBtnTapped), for: .touchUpInside)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true;
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        studentIdTextField.delegate = self
        departmentTextField.delegate = self

        setUpView()
        setUpConstraints()
    }
    //MARK: - Helper

    func setUpView() {
        [borderView,backBtn,titleLabel,firstNameLabel,firstNameTextField,lastNameLabel,lastNameTextField,departmentLabel,departmentTextField,studentIdLabel,studentIdTextField,saveBtn].forEach {
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
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            $0.centerX.equalToSuperview()
        }
        borderView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(22)
            $0.height.equalTo(Constant.height * 0.5)
            $0.leading.trailing.equalToSuperview()
        }
        firstNameLabel.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(37)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        firstNameTextField.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(59)
            $0.bottom.equalTo(borderView.snp.bottom).offset(111)
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
        departmentLabel.snp.makeConstraints {
            $0.top.equalTo(lastNameTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        departmentTextField.snp.makeConstraints {
            $0.top.equalTo(lastNameTextField.snp.bottom).offset(44)
            $0.bottom.equalTo(lastNameTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        studentIdLabel.snp.makeConstraints {
            $0.top.equalTo(departmentTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        studentIdTextField.snp.makeConstraints {
            $0.top.equalTo(departmentTextField.snp.bottom).offset(44)
            $0.bottom.equalTo(departmentTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        saveBtn.snp.makeConstraints {
            $0.top.equalTo(studentIdTextField.snp.bottom).offset(40)
            $0.bottom.equalTo(studentIdTextField.snp.bottom).offset(96)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
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
    //MARK: - Navigation
    @objc func cancelBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc
    func saveBtnTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
