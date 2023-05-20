//
//  TaskViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/04/03.
//

import UIKit
import Alamofire
import SnapKit
import Then

class TaskViewController: UIViewController {

    weak var createTaskDelegate: CreateTaskDelegate?
    weak var updateTaskDelegate: UpdateTaskDelegate?

    let colors = [UIColor(red: 0.733, green: 0.558, blue: 1, alpha: 1),
                  UIColor(red: 0.864, green: 0.775, blue: 1, alpha: 1),
                  UIColor(red: 0.767, green: 0.781, blue: 1, alpha: 1),
                  UIColor(red: 0.565, green: 0.863, blue: 1, alpha: 1),
                  UIColor(red: 0.788, green: 0.933, blue: 1, alpha: 1),
                  UIColor(red: 0.429, green: 0.657, blue: 1, alpha: 1)]

    let getTask = Task()
    var tasks: [TaskResponse] = []

    let dateFormatter = DateFormatter()

    let cell = TaskTableViewCell()
    let saveTaskPopUpView = SaveTaskPopUpView()
    let createTaskPopUpView = CreateTaskPopUpView()

    let refreshControl = UIRefreshControl()

    var customTabBarController: UITabBarController?

    private let titleView = UIView().then {
        $0.backgroundColor = .white
    }

    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo-small")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let titleLabel = UILabel().then {
        $0.text = "My tasks"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 20)
    }

    let taskTableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.showsVerticalScrollIndicator = false
        $0.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.cellIdentifier)
        $0.backgroundColor = .clear
    }

    let taskFootView = UIView()

    let addTaskBtn = UIButton().then {
        $0.backgroundColor = UIColor(red: 0.856, green: 0.746, blue: 1, alpha: 1)
        $0.setImage(UIImage(named: "plus"), for: .normal)
        $0.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 14, weight: .medium), forImageIn: .normal)
        $0.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        taskTableView.delegate = self
        taskTableView.dataSource = self
        addTaskBtn.addTarget(self, action: #selector(addTaskBtnTapped), for: .touchUpInside)
        dateFormatter.locale = Locale(identifier: "English")
        NotificationCenter.default.addObserver(self, selector: #selector(handleTaskUpdate), name: Notification.Name("TaskUpdateNotification"), object: nil)
        initRefreshControl()
        setUpView()
        setUpConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let memberId = UserDefaults.standard.integer(forKey: "memberId")
        getTask.getMyTask(memberId: memberId) { tasks in
            self.tasks = tasks
            DispatchQueue.main.async {
                self.taskTableView.reloadData()
            }
        }
    }

    func setUpView() {
        [titleView, taskTableView, addTaskBtn].forEach {
            view.addSubview($0)
        }
        [titleLabel, logoImageView].forEach {
            titleView.addSubview($0)
        }
        self.taskTableView.separatorStyle = .singleLine
        self.taskTableView.separatorColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1)
//        self.taskTableView.separatorInset = UIEdgeInsets.zero
        self.taskTableView.contentInset = UIEdgeInsets(top: 35, left: 0, bottom: 35, right: 0)

        // MARK: 테이블뷰 헤더 간격 없앰
        if #available(iOS 15.0, *) {
            taskTableView.sectionHeaderTopPadding = 0
        }
    }

    func setUpConstraints() {
        titleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constant.height * 115)
        }
        logoImageView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.bottom.lessThanOrEqualToSuperview().inset(10) // 20
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(20)
            $0.centerY.equalTo(logoImageView)
        }
        taskTableView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom) // offset(35)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        // 가로길이에 맞추어 정사각형 만들기
        addTaskBtn.heightAnchor.constraint(equalTo: addTaskBtn.widthAnchor, multiplier: 1.0/1.0).isActive = true
        addTaskBtn.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(40) //21
            $0.width.equalTo(Constant.width * 52)
        }
    }

    @objc
    func addTaskBtnTapped() {
        let createTaskViewController = CreateTaskViewController()
        createTaskViewController.modalPresentationStyle = .overFullScreen
        createTaskViewController.modalTransitionStyle = .crossDissolve
        self.present(createTaskViewController, animated: true)
    }

    @objc func handleTaskUpdate() {
        let memberId = UserDefaults.standard.integer(forKey: "memberId")
        getTask.getMyTask(memberId: memberId) { tasks in
            self.tasks = tasks
            DispatchQueue.main.async {
                self.taskTableView.reloadData()
            }
        }
    }

    func initRefreshControl() {
        taskTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: UIControl.Event.valueChanged)
    }

    @objc func handleRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.refreshControl.endRefreshing()
        }
    }

    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: taskTableView)
            if let indexPath = taskTableView.indexPathForRow(at: touchPoint) {
                // your code here, get the row for the indexPath or do whatever you want
            }
        }
    }
}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            getTask.deleteTask(assignmentId: tasks[indexPath.row].assignmentId) { _ in
                self.tasks.remove(at: indexPath.row)
                self.taskTableView.deleteRows(at: [indexPath], with: .automatic)
                self.cell.deadlineView.backgroundColor = self.colors[indexPath.row % self.colors.count]
                self.taskTableView.reloadData()
            }
        } else { editingStyle == .insert }
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
        headerView.backgroundColor = .clear
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.cellIdentifier) as? TaskTableViewCell else {
            return UITableViewCell()
        }

        let task = tasks[indexPath.row]

        cell.deadlineView.backgroundColor = self.colors[indexPath.row % self.colors.count]
        cell.courseNameLabel.text = task.lectureName
        cell.taskNameLabel.text = task.name

        // "MMMM" 형식의 월 이름을 monthLabel에 표시
        dateFormatter.dateFormat = "MMMM"
        let monthString = dateFormatter.string(from: task.deadline)
        cell.monthLabel.text = monthString

        // "d" 형식의 일자를 dayLabel에 표시
        dateFormatter.dateFormat = "d"
        let dayString = dateFormatter.string(from: task.deadline)
        cell.dayLabel.text = dayString

        // "h:mm" 형식의 일자를 dayLabel에 표시
        dateFormatter.dateFormat = "'by' h:mm a"
        let timeString = dateFormatter.string(from: task.deadline).lowercased()
        cell.timeLabel.text = timeString

        cell.backgroundColor = UIColor.clear
        cell.clipsToBounds = true

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        let task = tasks[indexPath.row]

        let saveTaskViewController = SaveTaskViewController()
        saveTaskViewController.courseNamePlaceholder = task.lectureName
        saveTaskViewController.taskNamePlaceholder = task.name

        dateFormatter.locale = Locale(identifier: "English")
        dateFormatter.dateFormat = "d MMMM, yyyy"
        let date = dateFormatter.string(from: task.deadline)
        saveTaskViewController.dueDatePlaceholder = date

        dateFormatter.locale = Locale(identifier: "English")
        dateFormatter.dateFormat = "h:mm a"
        let time = dateFormatter.string(from: task.deadline)
        saveTaskViewController.dueTimePlaceholder = time
        saveTaskViewController.selectedAssignmentID = task.assignmentId

        saveTaskViewController.modalPresentationStyle = .overFullScreen
        saveTaskViewController.modalTransitionStyle = .crossDissolve
        self.present(saveTaskViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedTask = tasks.remove(at: sourceIndexPath.row)
        tasks.insert(movedTask, at: destinationIndexPath.row)
        taskTableView.reloadData()
    }
}

extension TaskViewController {
    func refreshTasks() {
        let memberId = UserDefaults.standard.integer(forKey: "memberId")
        getTask.getMyTask(memberId: memberId) { tasks in
            self.tasks = tasks
            DispatchQueue.main.async {
                self.taskTableView.reloadData()
            }
        }
    }
}
