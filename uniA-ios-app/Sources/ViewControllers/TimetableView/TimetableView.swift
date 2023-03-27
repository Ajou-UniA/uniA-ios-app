//
//  TimetableView.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/25.
//

import SnapKit
import Then
import UIKit

class TimetableView: UIView {

    var timeArr: [String] = ["9:00-10:15", "9:00-10:15", "9:00-10:15", "9:00-10:15", "9:00-10:15", "9:00-10:15", "9:00-10:15"]
    var courseNameArr: [String] = ["Data Structure", "Data Structure", "Data Structure", "Data Structure", "Data Structure", "Data Structure", "Data Structure"]

    let timetableTableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.showsVerticalScrollIndicator = false
        $0.register(TimetableTableViewCell.self, forCellReuseIdentifier: TimetableTableViewCell.cellIdentifier)
        $0.register(TimetableHeaderView.self, forHeaderFooterViewReuseIdentifier: TimetableHeaderView.headerViewIdentifier)
        $0.backgroundColor = .clear
    }

    let addCourseBtn = UIButton().then {
        $0.backgroundColor = .black
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium), forImageIn: .normal)
        $0.tintColor = .white
        $0.setTitleColor(.white, for: .normal)
        $0.layer.shadowRadius = 10
        $0.layer.shadowOpacity = 0.3
        $0.layer.cornerRadius = 20
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    func setUpView() {
        timetableTableView.delegate = self
        timetableTableView.dataSource = self
        timetableTableView.separatorStyle = .none
        [timetableTableView].forEach {
            addSubview($0)
        }

        // MARK: 테이블뷰 헤더 간격 없앰
        if #available(iOS 15.0, *) {
            timetableTableView.sectionHeaderTopPadding = 0
        }
    }

    func setUpConstraints() {
        timetableTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension TimetableView: UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArr.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TimetableTableViewCell.cellIdentifier) as? TimetableTableViewCell else {
            return UITableViewCell()
        }
        cell.timeLabel.text = timeArr[indexPath.row]
        cell.courseNameLabel.text = courseNameArr[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.clipsToBounds = true
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TimetableHeaderView.headerViewIdentifier) as? TimetableHeaderView else {
            return UIView()
        }
        headerView.backgroundColor = UIColor.clear
        headerView.clipsToBounds = true
        [headerView.monBtn, headerView.tueBtn, headerView.wedBtn, headerView.thuBtn, headerView.friBtn].forEach {
            $0.addTarget(self, action: #selector(dayOfWeekBtnTapped), for: .touchUpInside)
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.section).")
    }

    @IBAction func dayOfWeekBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected // 버튼의 isSelected 속성 반전
        if sender.isSelected {
            sender.layer.backgroundColor = UIColor(red: 0.856, green: 0.746, blue: 1, alpha: 1).cgColor
        } else {
            sender.backgroundColor = .clear
        }
    }
}

class TimetableHeaderView: UITableViewHeaderFooterView {

    static let headerViewIdentifier = "TimetableHeaderView"

    let mainView = UIView()

    let semesterLabel = UILabel().then {
        $0.text = "2023 Spring"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 25)
    }

    let dayOfWeekStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 11
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
    }

    let monBtn = UIButton()
    let tueBtn = UIButton()
    let wedBtn = UIButton()
    let thuBtn = UIButton()
    let friBtn = UIButton()

    let monLabel = UILabel().then {
        $0.text = "Mon"
    }

    let tueLabel = UILabel().then {
        $0.text = "Tue"
    }

    let wedLabel = UILabel().then {
        $0.text = "Wed"
    }

    let thuLabel = UILabel().then {
        $0.text = "Thu"
    }

    let friLabel = UILabel().then {
        $0.text = "Fri"
    }

    override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
        setUpView()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    func setUpView() {
        addSubview(mainView)
        [semesterLabel, dayOfWeekStackView].forEach {
            mainView.addSubview($0)
        }
        [monLabel, tueLabel, wedLabel, thuLabel, friLabel].forEach {
            $0.textColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
            $0.font = UIFont(name: "Urbanist-SemiBold", size: 15)
        }
        [monBtn, tueBtn, wedBtn, thuBtn, friBtn].forEach {
            dayOfWeekStackView.addArrangedSubview($0)
            $0.backgroundColor = .clear
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 54 / 2.0
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        monBtn.addSubview(monLabel)
        tueBtn.addSubview(tueLabel)
        wedBtn.addSubview(wedLabel)
        thuBtn.addSubview(thuLabel)
        friBtn.addSubview(friLabel)
    }

    func setUpConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        semesterLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(29)
            $0.centerX.equalToSuperview()
        }
        dayOfWeekStackView.snp.makeConstraints {
            $0.top.equalTo(semesterLabel.snp.bottom).offset(29)
            $0.leading.trailing.equalToSuperview().inset(38)
        }
        monBtn.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }
        tueBtn.snp.makeConstraints {
            $0.centerY.equalTo(monBtn)
            $0.leading.equalTo(monBtn.snp.trailing).offset(11)
        }
        wedBtn.snp.makeConstraints {
            $0.centerY.equalTo(monBtn)
            $0.leading.equalTo(tueBtn.snp.trailing).offset(11)
        }
        thuBtn.snp.makeConstraints {
            $0.centerY.equalTo(monBtn)
            $0.leading.equalTo(wedBtn.snp.trailing).offset(11)
        }
        friBtn.snp.makeConstraints {
            $0.centerY.equalTo(monBtn)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(thuBtn.snp.trailing).offset(11)
        }
        [monBtn, tueBtn, wedBtn, thuBtn, friBtn].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(Constant.height * 54)
                $0.width.equalTo(Constant.width * 54)
            }
        }
        [monLabel, tueLabel, wedLabel, thuLabel, friLabel].forEach {
            $0.snp.makeConstraints {
            $0.center.equalToSuperview()
            }
        }
    }
}
