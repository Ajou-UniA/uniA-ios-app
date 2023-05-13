//
//  CreateTaskViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/02.
//

import SnapKit
import Then
import UIKit
import Alamofire

protocol CreateTaskDelegate: AnyObject {
    func didCreateTask()
}

class CreateTaskViewController: UIViewController, UITextFieldDelegate {

    weak var createTaskDelegate: CreateTaskDelegate?
    
    let getTask = Task()
    var tasks: [TaskResponse] = []

    let popUpView = CreateTaskPopUpView()
    let taskViewController = TaskViewController()
    let taskTableView = TaskViewController().taskTableView

    let saveTaskPopUpView = SaveTaskPopUpView()

    var datePickerView = UIDatePicker()
    var timePickerView = UIDatePicker()

    var selectedAssignmentID = 0
    var selectedDeadline = ""
    var selectedLectureName = ""
    var selectedName = ""

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
        popUpView.createBtn.addTarget(self, action: #selector(createTaskBtnTapped), for: .touchUpInside)
        datePickerView.addTarget(self, action: #selector(changed), for: .valueChanged)
        timePickerView.addTarget(self, action: #selector(changed1), for: .valueChanged)

        datePickerView.backgroundColor = .white
        timePickerView.backgroundColor = .white

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
    func createTaskBtnTapped() {

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

        getTask.getLastAssignmentId { [weak self] lastAssignmentId in
            self?.selectedAssignmentID = lastAssignmentId!
            print("Last assignment ID: \(lastAssignmentId)")
        }

        let bodyData: Parameters = [
            "assignmentId": selectedAssignmentID+1,
            "deadline": "\(combinedString)",
            "lectureName": courseName,
            "name": taskName ]

        getTask.createTask(bodyData: bodyData)

        getTask.getMyTask(memberId: 202021758) { tasks in
            self.tasks = tasks
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.tasks = tasks
                self.createTaskDelegate?.didCreateTask()
                // Task 생성 후에 NotificationCenter로 TaskViewController로 데이터 업데이트 요청
                NotificationCenter.default.post(name: Notification.Name("TaskUpdateNotification"), object: nil)
            }
        }

        self.dismiss(animated: true, completion: nil)

//        getTask.getMyTask(memberId: 202021758) { tasks in
//            print(tasks.count)
//            self.tasks = tasks
//            DispatchQueue.main.async {
//                // Task 생성 후에 TaskViewController를 업데이트
//                if let taskViewController = self.presentingViewController as? TaskViewController {
//                taskViewController.refreshTasks()
//            }
//                self.taskViewController.taskTableView.reloadData()
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
    }

    @objc
    func refresh() {
        self.getTask.getLastAssignmentId { lastAssignmentId in
            self.selectedAssignmentID = lastAssignmentId!
            let indexPath = IndexPath(row: lastAssignmentId!+1, section: 0)
            self.taskTableView.insertRows(at: [indexPath], with: .automatic)
            self.getTask.getMyTask(memberId: 202021758) { tasks in
                print(tasks.count)
                self.tasks = tasks
                self.taskTableView.reloadData()
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

class CreateTaskPopUpView: UIView, UITextFieldDelegate {

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
        $0.textColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
        $0.isUserInteractionEnabled = true
    }

    let taskNameTextField = UITextField().then {
        $0.textColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
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
        $0.layer.borderColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1).cgColor
        $0.setTitle("Cancel", for: .normal)
        $0.setTitleColor(UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }

    let createBtn = UIButton().then {
        $0.backgroundColor = UIColor(red: 0.856, green: 0.746, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.setTitle("Create", for: .normal)
        $0.setTitleColor(UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1), for: .normal)
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
            $0.addLeftPadding2()
            $0.delegate = self
        }
        [courseNameTextField, taskNameTextField, dueDateTextField, dueTimeTextField].forEach {
            $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            $0.textColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
            $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
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
            $0.image = UIImage(named: "pickerBtn")
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [courseNameLabel, courseNameTextField, taskNameLabel, taskNameTextField, dueDateLabel, dueTimeLabel, dueDateTextField, dueTimeTextField, cancelBtn, createBtn].forEach {
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
        createBtn.snp.makeConstraints {
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
        textField.layer.borderColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1).cgColor
        textField.placeholder = nil
    }

    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
    }
}

// MARK: - UIPickerView 사용 시 UITextField copy, paste 기능 없애기 위한 Customizing
class CustomUITextField: UITextField {

    var enableLongPressActions = false

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
   }
}
