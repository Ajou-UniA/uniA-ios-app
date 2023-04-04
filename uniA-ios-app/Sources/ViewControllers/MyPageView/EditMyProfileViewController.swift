//
//  EditMyProfileViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/02.
//

import SnapKit
import Then
import UIKit

class EditMyProfileViewController: UIViewController {
    //MARK: - Properties
    lazy var backBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "chevron_left"), for: .normal)
        $0.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
    }
    
    lazy var titleLabel = UILabel().then {
        $0.text = "Edit My Profile"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
    }
    let borderView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    }
    lazy var firstNameLabel = UILabel().then {
        $0.text = "First Name"
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    lazy var firstNameTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.addLeftPadding()
    }
    lazy var lastNameLabel = UILabel().then {
        $0.text = "Last Name"
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    lazy var lastNameTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.addLeftPadding()
    }
    lazy var departmentLabel = UILabel().then {
        $0.text = "Department"
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    lazy var departmentTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.addLeftPadding()
    }
    lazy var studentIdLabel = UILabel().then {
        $0.text = "Student ID"
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    lazy var studentIdTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.addLeftPadding()
    }
    lazy var saveBtn = UIButton().then {
        $0.setTitle("Save", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(saveBtnTapped), for: .touchUpInside)
    }
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true;

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
        borderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(85)
            $0.height.equalTo(Constant.height * 0.5)
            $0.leading.trailing.equalToSuperview()
        }
        backBtn.snp.makeConstraints {
            $0.bottom.equalTo(borderView.snp.top).offset(-20)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
            $0.width.equalTo(Constant.width * 35)
            $0.height.equalTo(Constant.height * 35)
        }
        titleLabel.snp.makeConstraints{
            $0.bottom.equalTo(borderView.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 180)
        }
        firstNameLabel.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(35)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 100)
            $0.height.equalTo(Constant.height * 22)
        }
        firstNameTextField.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(57)
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
        departmentLabel.snp.makeConstraints {
            $0.top.equalTo(lastNameTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 100)
            $0.height.equalTo(Constant.height * 22)
        }
        departmentTextField.snp.makeConstraints {
            $0.top.equalTo(lastNameTextField.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        studentIdLabel.snp.makeConstraints {
            $0.top.equalTo(departmentTextField.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 130)
            $0.height.equalTo(Constant.height * 22)
        }
        studentIdTextField.snp.makeConstraints {
            $0.top.equalTo(departmentTextField.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        saveBtn.snp.makeConstraints {
            $0.top.equalTo(studentIdTextField.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
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
