//
//  SaveTaskViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/02.
//

import SnapKit
import Then
import UIKit

class SaveTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let popUpView = SaveTaskPopUpView()
    let taskViewController = TaskViewController()
    let taskTableView = TaskViewController().taskTableView

    var pickerView = UIPickerView()
    var data1 = ["Option 1", "Option 2", "Option 3"]
    var data2 = ["Choice 1", "Choice 2", "Choice 3"]

    lazy var toolbar = UIToolbar().then {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTapped))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelButtonTapped))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        $0.setItems([cancelButton, space, doneButton], animated: true)
        $0.isUserInteractionEnabled = true
        $0.sizeToFit()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.3)
        popUpView.layer.cornerRadius = 20
        popUpView.cancelBtn.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
        popUpView.saveBtn.addTarget(self, action: #selector(saveTaskBtnTapped), for: .touchUpInside)

        // pickerView 설정
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        popUpView.dueDateTextField.inputView = pickerView
        popUpView.dueDateTextField.inputAccessoryView = toolbar
        popUpView.dueTimeTextField.inputView = pickerView
        popUpView.dueTimeTextField.inputAccessoryView = toolbar

        // placeholder 설정
        popUpView.courseNameTextField.placeholder = taskViewController.courseNameArr[0]
        popUpView.taskNameTextField.placeholder = taskViewController.taskNameArr[0]
        popUpView.dueDateTextField.placeholder = "18 april, 2023"
        popUpView.dueTimeTextField.placeholder = "11:59 pm"

        setUpView()
        setUpConstraints()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }

    func setUpView() {
        [popUpView].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        popUpView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15) // 수정필요
            $0.center.equalToSuperview()
        }
    }

    @objc
    func cancelBtnTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc
    func saveTaskBtnTapped() {
        taskViewController.courseNameArr.append("Course Name")
        taskViewController.taskNameArr.append("Task Name")
        taskViewController.timeArr.append("by 12:00 am")
        taskViewController.dayArr.append("1")
        taskViewController.monthArr.append("January")
        taskViewController.taskTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }

    // 현재 선택된 항목 출력
    @objc func onDoneButtonTapped() {
        view.endEditing(true)
        if popUpView.dueDateTextField.isFirstResponder {
            let selectedIndex = pickerView.selectedRow(inComponent: 0)
            let selectedOption = data1[selectedIndex]
            print("Selected option: \(selectedOption)")
        } else if popUpView.dueTimeTextField.isFirstResponder {
            let selectedIndex = pickerView.selectedRow(inComponent: 0)
            let selectedChoice = data2[selectedIndex]
            print("Selected choice: \(selectedChoice)")
        }
    }

    @objc func onCancelButtonTapped() {
        view.endEditing(true)
    }

    // MARK: - PickerView
    // pickerView column 수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // pickerView row 수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if popUpView.dueDateTextField.isFirstResponder {
            return data1.count
        } else if popUpView.dueTimeTextField.isFirstResponder {
            return data2.count
        } else {
            return 0
        }
    }

    // pickerView 보여지는 값
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if popUpView.dueDateTextField.isFirstResponder {
            return data1[row]
        } else if popUpView.dueTimeTextField.isFirstResponder {
            return data2[row]
        } else {
            return nil
        }
    }

    // pickerView 선택시 데이터 호출
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if popUpView.dueDateTextField.isFirstResponder {
            popUpView.dueDateTextField.text = data1[row]
        } else if popUpView.dueTimeTextField.isFirstResponder {
            popUpView.dueTimeTextField.text = data2[row]
        }
    }
}

class SaveTaskPopUpView: UIView, UITextFieldDelegate {

    let baseView = UIView().then {
        $0.backgroundColor = .clear
    }

    let courseNameLabel = UILabel().then {
        $0.text = "Course name"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
        $0.numberOfLines = 0
    }

    let courseNameTextField = UITextField().then {
        // 회색 플레이스홀더 - UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1)
        // 회색 테두리 - UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1)
        // 민트 - UIColor(red: 0.498, green: 0.867, blue: 1, alpha: 1)
        $0.isUserInteractionEnabled = true
    }

    let taskNameTextField = UITextField().then {
        $0.isUserInteractionEnabled = true
    }

    let taskNameLabel = UILabel().then {
        $0.text = "Task name"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
        $0.numberOfLines = 0
    }

    let dueDateLabel = UILabel().then {
        $0.text = "Select a due date"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
        $0.numberOfLines = 0
    }

    let dueTimeLabel = UILabel().then {
        $0.text = "Select a time"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
        $0.numberOfLines = 0
    }

    let dueDateTextField = CustomUITextField().then {
        $0.isUserInteractionEnabled = true
    }

    let dueTimeTextField = CustomUITextField().then {
        $0.isUserInteractionEnabled = true
    }

    let cancelBtn = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.498, green: 0.867, blue: 1, alpha: 1).cgColor
        $0.setTitle("Cancel", for: .normal)
        $0.setTitleColor(UIColor(red: 0.498, green: 0.867, blue: 1, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }

    let saveBtn = UIButton().then {
        $0.backgroundColor = UIColor(red: 0.886, green: 0.969, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.setTitle("Save", for: .normal)
        $0.setTitleColor(UIColor(red: 0.498, green: 0.867, blue: 1, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }

    let selectADueDateBtn = UIButton()
    let selectADueTimeBtn = UIButton()
    let selectADueDateImageView = UIImageView()
    let selectADueTimeBtnImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        [courseNameTextField, taskNameTextField, dueDateTextField, dueTimeTextField].forEach {
            $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(red: 0.498, green: 0.867, blue: 1, alpha: 1).cgColor
            $0.textColor = UIColor(red: 0.498, green: 0.867, blue: 1, alpha: 1)
            $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
            $0.addLeftPadding2()
            $0.delegate = self
        }

        textFieldDidBeginEditing(courseNameTextField)
        textFieldDidEndEditing(courseNameTextField)
        textFieldDidBeginEditing(taskNameTextField)
        textFieldDidEndEditing(taskNameTextField)
        textFieldDidBeginEditing(dueDateTextField)
        textFieldDidEndEditing(dueDateTextField)
        textFieldDidBeginEditing(dueTimeTextField)
        textFieldDidEndEditing(dueTimeTextField)

        setUpView()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    // 화면을 터치 시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }

    func setUpView() {
        [selectADueDateBtn, selectADueTimeBtn].forEach {
            $0.backgroundColor = .clear
        }
        [selectADueDateImageView, selectADueTimeBtnImageView].forEach {
            $0.image = UIImage(named: "picker-green")
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [courseNameLabel, courseNameTextField, taskNameLabel, taskNameTextField, dueDateLabel, dueTimeLabel, dueDateTextField, dueTimeTextField, cancelBtn, saveBtn].forEach {
            addSubview($0)
        }
        dueDateTextField.addSubview(selectADueDateBtn)
        dueTimeTextField.addSubview(selectADueTimeBtn)
        selectADueDateBtn.addSubview(selectADueDateImageView)
        selectADueTimeBtn.addSubview(selectADueTimeBtnImageView)
    }

    func setUpConstraints() {
        courseNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(21)
        }
        courseNameTextField.snp.makeConstraints {
            $0.top.equalTo(courseNameLabel.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(Constant.height * 52)
        }
        taskNameLabel.snp.makeConstraints {
            $0.top.equalTo(courseNameTextField.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(21)
        }
        taskNameTextField.snp.makeConstraints {
            $0.top.equalTo(taskNameLabel.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(Constant.height * 52)
        }
        dueDateLabel.snp.makeConstraints {
            $0.top.equalTo(taskNameTextField.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(21)
        }
        dueTimeLabel.snp.makeConstraints {
            $0.centerY.equalTo(dueDateLabel)
            $0.bottom.equalTo(dueTimeTextField.snp.top).inset(7)
            $0.leading.equalTo(dueTimeTextField)
        }
        dueDateTextField.snp.makeConstraints {
            $0.top.equalTo(dueDateLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().offset(21)
            $0.width.equalTo(Constant.width * 196)
            $0.height.equalTo(Constant.height * 52)
        }
        dueTimeTextField.snp.makeConstraints {
            $0.leading.equalTo(dueDateTextField.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(21)
            $0.centerY.equalTo(dueDateTextField)
            $0.height.equalTo(Constant.height * 52)
        }
        cancelBtn.snp.makeConstraints {
            $0.top.equalTo(dueDateTextField.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(21)
            $0.width.equalTo(Constant.width * 130)
            $0.height.equalTo(Constant.height * 52)
            $0.bottom.equalToSuperview().inset(23)
        }
        saveBtn.snp.makeConstraints {
            $0.leading.equalTo(cancelBtn.snp.trailing).offset(10) // 11
            $0.trailing.equalToSuperview().inset(21)
            $0.centerY.equalTo(cancelBtn)
            $0.height.equalTo(Constant.height * 52)
        }
        [selectADueDateBtn, selectADueTimeBtn].forEach {
            $0.snp.makeConstraints {
                $0.top.lessThanOrEqualToSuperview().offset(23)
                $0.bottom.equalToSuperview().inset(20)
                $0.trailing.lessThanOrEqualToSuperview().inset(13)
                $0.height.equalTo(Constant.height * 9)
                $0.width.equalTo(Constant.width * 15)
            }
        }
        [selectADueDateImageView, selectADueTimeBtnImageView].forEach {
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }

    // MARK: - TextFieldDelegate
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.498, green: 0.867, blue: 1, alpha: 1).cgColor
        textField.placeholder = nil
    }

    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
    }
}

// MARK: 텍스트필드 왼쪽 간격 주기 -> 패딩에서 텍스트 입력 시작
extension UITextField {
    func addLeftPadding2() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
// 글자 수 제한
// course name - 35
// task name - 25
