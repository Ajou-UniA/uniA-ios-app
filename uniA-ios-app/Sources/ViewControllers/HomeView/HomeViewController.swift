//
//  HomeViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/10.
//

import UIKit
import Alamofire
import SafariServices
import SnapKit
import Then

class HomeViewController: UIViewController {

    var nickname: String = "UniA Paranni"

    let colors = [UIColor(red: 0.733, green: 0.558, blue: 1, alpha: 1),
                  UIColor(red: 0.864, green: 0.775, blue: 1, alpha: 1),
                  UIColor(red: 0.767, green: 0.781, blue: 1, alpha: 1),
                  UIColor(red: 0.565, green: 0.863, blue: 1, alpha: 1),
                  UIColor(red: 0.788, green: 0.933, blue: 1, alpha: 1),
                  UIColor(red: 0.429, green: 0.657, blue: 1, alpha: 1)]

    let getTask = Task()
    var tasks: [TaskResponse] = []

    let dateFormatter = DateFormatter()

    private let titleView = UIView().then {
        $0.backgroundColor = .white
    }

    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo-small")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }

    let contentView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    let helloLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 30)
        $0.numberOfLines = 0
    }

    var taskCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TaskCollectionViewCell.self,
                                forCellWithReuseIdentifier: TaskCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.decelerationRate = .fast
        return collectionView
        }()

    let favoriteView = FavoriteView()
    let ajouCampusMapView = AjouCampusMapView()
    let cell = TaskCollectionViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let hello: String = "Hello \(nickname)!"
        helloLabel.text = hello
        taskCollectionView.delegate = self
        taskCollectionView.dataSource = self
        scrollView.insetsLayoutMarginsFromSafeArea = (0 != 0)
        favoriteView.noticeBtn.addTarget(self, action: #selector(linkTapped), for: .touchUpInside)
        favoriteView.portalBtn.addTarget(self, action: #selector(linkTapped), for: .touchUpInside)
        favoriteView.OIABtn.addTarget(self, action: #selector(linkTapped), for: .touchUpInside)
        favoriteView.libraryBtn.addTarget(self, action: #selector(linkTapped), for: .touchUpInside)
//        self.view.layoutIfNeeded()
        taskCollectionView.reloadData()
        setUpView()
        setUpConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.taskCollectionView.reloadData()

        getMyTaskSortedByDeadline { [weak self] tasks in
            // 정렬된 할 일 목록(tasks)을 사용하여 필요한 작업을 수행
            let currentDate = Date()
            let threeDaysAhead = Calendar.current.date(byAdding: .day, value: 3, to: currentDate)!
            let filteredTasks = tasks.filter { $0.deadline <= threeDaysAhead }
            self?.tasks = filteredTasks
            self?.taskCollectionView.reloadData()
        }
    }

    func setUpView() {
        [titleView, scrollView].forEach {
            view.addSubview($0)
        }
        self.titleView.addSubview(logoImageView)
        self.scrollView.addSubview(contentView)
        [helloLabel, taskCollectionView, favoriteView, ajouCampusMapView].forEach {
            contentView.addSubview($0)
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
        scrollView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(25)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        helloLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        taskCollectionView.snp.makeConstraints {
            $0.top.equalTo(helloLabel.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Constant.height * 210)
        }
        favoriteView.snp.makeConstraints {
            $0.top.equalTo(taskCollectionView.snp.bottom).offset(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        ajouCampusMapView.snp.makeConstraints {
            $0.top.equalTo(favoriteView.snp.bottom).offset(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
    }

    func loca() {
        favoriteView.snp.makeConstraints {
            $0.top.equalTo(helloLabel.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Constant.height * 210)
        }
    }

    @objc
    func linkTapped(_ button: UIButton) {
        if let type = ButtonType(rawValue: button.tag) {
            switch type {
            case .link1:
                let noticeUrl = NSURL(string: "https://www.ajou.ac.kr/en/ajou/notice.do")
                let noticeSafariView: SFSafariViewController = SFSafariViewController(url: noticeUrl! as URL)
                self.present(noticeSafariView, animated: true, completion: nil)
            case .link2:
                let portalUrl = NSURL(string: "https://mportal.ajou.ac.kr/main.do")
                let portalSafariView: SFSafariViewController = SFSafariViewController(url: portalUrl! as URL)
                self.present(portalSafariView, animated: true, completion: nil)
            case .link3:
                let OIAUrl = NSURL(string: "https://www.ajou.ac.kr/oia/index.do")
                let OIASafariView: SFSafariViewController = SFSafariViewController(url: OIAUrl! as URL)
                self.present(OIASafariView, animated: true, completion: nil)
            case .link4:
                let libraryUrl = NSURL(string: "https://library.ajou.ac.kr/#/")
                let librarySafariView: SFSafariViewController = SFSafariViewController(url: libraryUrl! as URL)
                self.present(librarySafariView, animated: true, completion: nil)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    // 셀 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = taskCollectionView.frame.height
        return CGSize(width: height, height: height)
    }

    // 섹션에서 콘텐츠를 배치하는 데 사용되는 여백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tasks.count == 0 { // There are no imminent tasks.
            collectionView.setEmptyView(title: "Good news!", message: "You have a 2-day break from tasks.", image: .checkmark)
        } else {
            collectionView.restore()
        }
        return tasks.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionViewCell.identifier, for: indexPath) as? TaskCollectionViewCell
        else { return UICollectionViewCell() }

        let task = tasks[indexPath.row]
        let currentDate = Date()

        let daysRemaining = Calendar.current.dateComponents([.day], from: currentDate, to: task.deadline).day
        var dayLeftText: String

        if daysRemaining! < 1 {
            dayLeftText = "Less than 1 day left"
        } else if daysRemaining == 1 {
            dayLeftText = "1 day left"
        } else if daysRemaining! < 3 {
            dayLeftText = "2 days left"
        } else {
            dayLeftText = "" // 3일 이상 남은 경우는 표시하지 않음
        }

        cell.baseView.backgroundColor = self.colors[indexPath.row % self.colors.count]
        cell.courseNameLabel.text = task.lectureName
        cell.taskNameLabel.text = task.name
        cell.dayLeftLabel.text = dayLeftText

        cell.backgroundColor = UIColor.clear
        cell.clipsToBounds = true
        return cell
    }
}

extension HomeViewController {
    func getMyTaskSortedByDeadline(onCompleted: @escaping ([TaskResponse]) -> Void) {
        getTask.getMyTask(memberId: 202021758) { tasks in
            let currentDate = Date()
            let sortedTasks = tasks.sorted { task1, task2 in
                let daysRemaining1 = Calendar.current.dateComponents([.day], from: currentDate, to: task1.deadline).day ?? 0
                let daysRemaining2 = Calendar.current.dateComponents([.day], from: currentDate, to: task2.deadline).day ?? 0
                return daysRemaining1 < daysRemaining2
            }
            onCompleted(sortedTasks)
        }
    }
}

extension UICollectionView {

    func setEmptyView(title: String, message: String, image: UIImage) {
        let emptyView: UIView = {
            let view = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.width, height: self.bounds.height))
            view.backgroundColor = .white

            return view
        }()

        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = title
            label.textColor = .black
            label.font = UIFont(name: "Urbanist-Bold", size: 30)
            label.numberOfLines = 0
            label.textAlignment = .left
            return label
        }()

        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.textColor = UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1)
            label.font = UIFont(name: "Urbanist-SemiBold", size: 15)
            label.numberOfLines = 0
            label.textAlignment = .left
            return label
        }()

        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(emptyView.snp.top).offset(40)
            $0.left.equalTo(emptyView.snp.left).offset(20)
        }
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.equalTo(emptyView.snp.left).offset(20)
            $0.right.equalTo(emptyView.snp.right).offset(-40)
        }
        self.backgroundView = emptyView
    }
    func restore() {
        self.backgroundView = nil
    }
}

class TaskCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "TaskCollectionViewCell"

    let baseView = UIView().then {
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 20
    }

    let courseNameLabel = UILabel().then {
        $0.text = "Data Structure"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }

    let taskNameLabel = UILabel().then {
        $0.text = "Assignment 1"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 25)
        $0.numberOfLines = 0
    }

    let dayLeftLabel = UILabel().then {
        $0.text = "1 day left"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpView() {
        self.contentView.addSubview(baseView)
        [courseNameLabel, taskNameLabel, dayLeftLabel].forEach {
            baseView.addSubview($0)
        }
    }

    func setUpConstraint() {
        baseView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
        }
        courseNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        taskNameLabel.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(courseNameLabel.snp.bottom).offset(10) // 16
            $0.leading.equalTo(courseNameLabel)
            $0.trailing.equalToSuperview().inset(25)
        }
        dayLeftLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(25)
            $0.leading.equalTo(courseNameLabel)
            $0.trailing.equalToSuperview().inset(25)
        }
    }
}
