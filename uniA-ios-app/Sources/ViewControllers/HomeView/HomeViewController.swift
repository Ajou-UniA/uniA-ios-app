//
//  HomeViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/10.
//

import UIKit
import SafariServices
import SnapKit
import Then

class HomeViewController: UIViewController {

    var nickname: String = "UniA Paranni"
    var courseNameArr: [String] = ["Data Structure", "Computer Networks", "Algorithms"]
    var taskNameArr: [String] = ["Assignment 1", "Report", "Assignment 2"]
    var dayLeftArr: [String] = ["1 day left", "2 days left", "3 days left"]
    let colors = [UIColor(red: 0.733, green: 0.558, blue: 1, alpha: 1),
                  UIColor(red: 0.864, green: 0.775, blue: 1, alpha: 1),
                  UIColor(red: 0.767, green: 0.781, blue: 1, alpha: 1),
                  UIColor(red: 0.565, green: 0.863, blue: 1, alpha: 1),
                  UIColor(red: 0.788, green: 0.933, blue: 1, alpha: 1),
                  UIColor(red: 0.429, green: 0.657, blue: 1, alpha: 1)]

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
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(TaskCollectionViewCell.self,
                                forCellWithReuseIdentifier: TaskCollectionViewCell.identifier)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = false
        cv.decelerationRate = .fast
        return cv
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
        setUpView()
        setUpConstraints()
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
        // MARK: - StackView 여러개 만들지 생각
    }

    func setUpConstraints() {
        titleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constant.height * 115)
        }
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.lessThanOrEqualToSuperview().inset(10) // 20
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        helloLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        taskCollectionView.snp.makeConstraints {
            $0.top.equalTo(helloLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(Constant.height * 210)
        }
        favoriteView.snp.makeConstraints {
            $0.top.equalTo(taskCollectionView.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        ajouCampusMapView.snp.makeConstraints {
            $0.top.equalTo(favoriteView.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
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

    @objc
    func noticeBtnTapped() {
        let noticeUrl = NSURL(string: "https://www.ajou.ac.kr/en/ajou/notice.do")
        let noticeSafariView: SFSafariViewController = SFSafariViewController(url: noticeUrl as! URL)
        self.present(noticeSafariView, animated: true, completion: nil)
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
        return courseNameArr.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionViewCell.identifier, for: indexPath) as? TaskCollectionViewCell
        else { return UICollectionViewCell() }
        cell.baseView.backgroundColor = self.colors[indexPath.row % self.colors.count]
        cell.courseNameLabel.text = courseNameArr[indexPath.row]
        cell.taskNameLabel.text = taskNameArr[indexPath.row]
        cell.dayLeftLabel.text = dayLeftArr[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.clipsToBounds = true
        return cell
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
//        // 가로길이에 맞추어 정사각형 만들기
//        baseView.heightAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 1.0/1.0).isActive = true
        baseView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
//            $0.height.equalTo(Constant.height * 210)
//            $0.width.equalTo(Constant.width * 210)
        }
        courseNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        taskNameLabel.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(courseNameLabel.snp.bottom).offset(10) // 16
            $0.leading.equalTo(courseNameLabel)
            $0.trailing.equalToSuperview().inset(15) // 25
        }
        dayLeftLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(25)
            $0.leading.equalTo(courseNameLabel)
        }
    }
}
