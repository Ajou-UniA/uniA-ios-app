//
//  SaveTaskViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/02.
//

import SnapKit
import Then
import UIKit
import Alamofire

protocol UpdateTaskDelegate: AnyObject {
    func didCreateTask()
}

class SaveTaskViewController: UIViewController, UITextFieldDelegate {

    weak var updateTaskDelegate: UpdateTaskDelegate?

    private let defaults = UserDefaults.standard

    let getTask = Task()
    var tasks: [TaskResponse] = []

    let popUpView = SaveTaskPopUpView()
    let taskViewController = TaskViewController()
    let taskTableView = TaskViewController().taskTableView

    var datePickerView = UIDatePicker()
    var timePickerView = UIDatePicker()

    var courseNamePlaceholder: String?
    var taskNamePlaceholder: String?
    var dueDatePlaceholder: String?
    var dueTimePlaceholder: String?

    var selectedAssignmentID = 0
    var updatedCourseName = ""
    var updatedTaskName = ""
    var updatedDate = ""
    var updatedTime = ""

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
        datePickerView.addTarget(self, action: #selector(changed), for: .valueChanged)
        timePickerView.addTarget(self, action: #selector(changed1), for: .valueChanged)

        popUpView.dueDateTextField.inputView = datePickerView
        popUpView.dueDateTextField.inputAccessoryView = toolbar

        popUpView.dueTimeTextField.inputView = timePickerView
        popUpView.dueTimeTextField.inputAccessoryView = toolbar

        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.datePickerMode = .date

        timePickerView.translatesAutoresizingMaskIntoConstraints = false
        timePickerView.preferredDatePickerStyle = .wheels
        timePickerView.datePickerMode = .time

        // 언어 설정
        self.datePickerView.locale = Locale(identifier: "English")
        self.timePickerView.locale = Locale(identifier: "English")

        popUpView.courseNameTextField.placeholder = courseNamePlaceholder
        popUpView.taskNameTextField.placeholder = taskNamePlaceholder
        popUpView.dueDateTextField.placeholder = dueDatePlaceholder
        popUpView.dueTimeTextField.placeholder = dueTimePlaceholder

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
    func changed() {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        dateformatter.timeStyle = .none
        dateformatter.locale = Locale(identifier: "English")
        dateformatter.dateFormat = "d MMMM, yyyy"
        let date = dateformatter.string(from: datePickerView.date)
        popUpView.dueDateTextField.text = date
        print(date)
    }

    @objc
    func changed1() {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .medium
        dateformatter.locale = Locale(identifier: "English")
        dateformatter.dateFormat = "h:mm a"
        let time = dateformatter.string(from: timePickerView.date).lowercased()
        popUpView.dueTimeTextField.text = time
    }

    @objc
    func cancelBtnTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc
    func saveTaskBtnTapped() {

        guard let courseName = popUpView.courseNameTextField.text,
              let taskName = popUpView.taskNameTextField.text,
              let dueDate = popUpView.dueDateTextField.text,
              let dueTime = popUpView.dueTimeTextField.text else {return}

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "English")
        dateFormatter.dateFormat = "d MMMM, yyyy"
        guard let date = dateFormatter.date(from: dueDate)
        else {
            return print("Unexpected dateString format")
        }

        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "English")
        timeFormatter.dateFormat = "h:mm a"
        guard let time = timeFormatter.date(from: dueTime)
        else {
            return print("Unexpected timeString format")
        }

        let combinedDate = Calendar.current.date(bySettingHour: Calendar.current.component(.hour, from: time), minute: Calendar.current.component(.minute, from: time), second: 0, of: date)!

        let combinedFormatter = DateFormatter()
        combinedFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let combinedString = combinedFormatter.string(from: combinedDate)

        print(combinedString)

        let bodyData: Parameters = [
            "assignmentId": selectedAssignmentID,
            "deadline": "\(combinedString)",
            "lectureName": courseName,
            "name": taskName
        ]

        getTask.updateTask(assignmentId: selectedAssignmentID, bodyData: bodyData) { success in
            if success {
                print("Task updated successfully")
            } else {
                print("Failed to update task")
            }
        }

        getTask.getMyTask(memberId: 202021758) { tasks in
            self.tasks = tasks
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.tasks = tasks
                self.updateTaskDelegate?.didCreateTask()
                // Task 생성 후에 NotificationCenter로 TaskViewController로 데이터 업데이트 요청
                NotificationCenter.default.post(name: Notification.Name("TaskUpdateNotification"), object: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    // 현재 선택된 항목 출력
    @objc func onDoneButtonTapped() {
        view.endEditing(true)
    }

    @objc func onCancelButtonTapped() {
        view.endEditing(true)
    }
}

class SaveTaskPopUpView: UIView, UITextFieldDelegate {

    let baseView = UIView().then {
        $0.backgroundColor = .clear
    }

    let courseNameLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
        $0.numberOfLines = 0
    }

    let courseNameTextField = UITextField().then {
        $0.isUserInteractionEnabled = true
    }

    let taskNameTextField = UITextField().then {
        $0.isUserInteractionEnabled = true
    }

    let taskNameLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
        $0.numberOfLines = 0
    }

    let dueDateLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
        $0.numberOfLines = 0
    }

    let dueTimeLabel = UILabel().then {
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
            $0.textColor = UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1)
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
        textField.attributedPlaceholder = NSAttributedString(
            string: "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1)]
        )
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
