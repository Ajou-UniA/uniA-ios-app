//
//  TaskViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/04/03.
//

import SnapKit
import Then
import UIKit

class TaskViewController: UIViewController {

    var courseNameArr: [String] = ["Data Structure", "Computer Networks", "Algorithms", "OPP", "Data Structure", "Computer Networks", "OPP"]
    var taskNameArr: [String] = ["Assignment 1", "Report", "Assignment 2", "Case study project", "Midterm report", "Assignment 3", "Assignment 4"]
    var timeArr: [String] = ["by 11:59 pm", "by 12:00 am", "by 12:00 am", "by 12:00 am", "by 11:59 am", "by 12:00 am", "by 12:00 am"]
    var dayArr: [String] = ["18", "19", "20", "1", "10", "17", "29"]
    var monthArr: [String] = ["April", "April", "April", "May", "May", "May", "May"]
    let colors = [UIColor(red: 0.733, green: 0.558, blue: 1, alpha: 1),
                  UIColor(red: 0.864, green: 0.775, blue: 1, alpha: 1),
                  UIColor(red: 0.767, green: 0.781, blue: 1, alpha: 1),
                  UIColor(red: 0.565, green: 0.863, blue: 1, alpha: 1),
                  UIColor(red: 0.788, green: 0.933, blue: 1, alpha: 1),
                  UIColor(red: 0.429, green: 0.657, blue: 1, alpha: 1)]
    var buttonTexts = ["Create", "Save"]

    let cell = TaskTableViewCell()
    let editPopUpView = SaveTaskPopUpView()
    let popUpView = CreateTaskPopUpView()

    private let titleView = UIView().then {
        $0.backgroundColor = .white
    }

    private let titleLabel = UILabel().then {
        $0.text = "My tasks"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 30)
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
        addTaskBtn.addTarget(self, action: #selector(addTaskBtnTapped), for: .touchUpInside)
        taskTableView.delegate = self
        taskTableView.dataSource = self
        setUpView()
        setUpConstraints()
    }

    func setUpView() {
        [titleView, taskTableView, addTaskBtn].forEach {
            view.addSubview($0)
        }
        titleView.addSubview(titleLabel)
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
        titleLabel.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(68) // SE에서 짤림 방지를 위해 삭제
            $0.leading.equalToSuperview().offset(16.12)
            $0.bottom.lessThanOrEqualToSuperview().inset(10) // 25
        }
        taskTableView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom) // offset(35) // equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        // 가로길이에 맞추어 정사각형 만들기
        addTaskBtn.heightAnchor.constraint(equalTo: addTaskBtn.widthAnchor, multiplier: 1.0/1.0).isActive = true
        addTaskBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(116)
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
}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {

    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            courseNameArr.remove(at: (indexPath as NSIndexPath).row)
            taskNameArr.remove(at: (indexPath as NSIndexPath).row)
            dayArr.remove(at: (indexPath as NSIndexPath).row)
            monthArr.remove(at: (indexPath as NSIndexPath).row)
            timeArr.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)}
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }

    // Override to support rearranging the table view.
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let courseNameToMove = courseNameArr[(fromIndexPath as NSIndexPath).row]
        let taskNameToMove = taskNameArr[(fromIndexPath as NSIndexPath).row]
        let dayToMove = dayArr[(fromIndexPath as NSIndexPath).row]
        let monthToMove = monthArr[(fromIndexPath as NSIndexPath).row]
        let timeToMove = timeArr[(fromIndexPath as NSIndexPath).row]
        courseNameArr.insert(courseNameToMove, at: (to as NSIndexPath).row)
        taskNameArr.insert(taskNameToMove, at: (to as NSIndexPath).row)
        dayArr.insert(dayToMove, at: (to as NSIndexPath).row)
        monthArr.insert(monthToMove, at: (to as NSIndexPath).row)
        timeArr.insert(timeToMove, at: (to as NSIndexPath).row)
    }

//    func swapByLongPress(with sender: UILongPressGestureRecognizer, to tableView: UITableView) {
//            let longPressedPoint = sender.location(in: tableView)
//            guard let indexPath = tableView.indexPathForRow(at: longPressedPoint) else { return }
//
//            struct BeforeIndexPath {
//                static var value: IndexPath?
//            }
//
//            switch sender.state {
//            case .began:
//                BeforeIndexPath.value = indexPath
//            case .changed:
//                if let beforeIndexPath = BeforeIndexPath.value, beforeIndexPath != indexPath {
//
//                    let beforeValue = players[beforeIndexPath.row]
//                    let afterValue = players[indexPath.row]
//                    players[beforeIndexPath.row] = afterValue
//                    players[indexPath.row] = beforeValue
//                    tableView.moveRow(at: beforeIndexPath, to: indexPath)
//
//                    BeforeIndexPath.value = indexPath
//                }
//            default:
//                // TODO animation
//                break
//            }
//        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseNameArr.count
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

//    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.cellIdentifier) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        cell.deadlineView.backgroundColor = self.colors[indexPath.row % self.colors.count]
        cell.courseNameLabel.text = courseNameArr[indexPath.row]
        cell.taskNameLabel.text = taskNameArr[indexPath.row]
        cell.dayLabel.text = dayArr[indexPath.row]
        cell.monthLabel.text = monthArr[indexPath.row]
        cell.timeLabel.text = timeArr[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.clipsToBounds = true
        let imageViewTappedRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(tapGestureRecognizer:)))
        // 상호작용 설정
        cell.moreImageView.isUserInteractionEnabled = true
        // 제스처인식기 연결
        cell.moreImageView.addGestureRecognizer(imageViewTappedRecognizer)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

    // MARK: imageView Clicked
    @objc func imageViewTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let saveTaskViewController = SaveTaskViewController()
        saveTaskViewController.modalPresentationStyle = .overFullScreen
        saveTaskViewController.modalTransitionStyle = .crossDissolve
        self.present(saveTaskViewController, animated: true)
    }
}
