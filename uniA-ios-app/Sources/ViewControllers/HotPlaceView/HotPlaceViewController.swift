//
//  HotPlaceViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/22.
//

import UIKit
import Alamofire
import SnapKit
import Then

class HotPlaceViewController: UIViewController {

    private let titleView = UIView().then {
        $0.backgroundColor = .white
    }

    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo-small")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let titleLabel = UILabel().then {
        $0.text = "Hot Place"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 20)
    }

    let hotPlaceTableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.showsVerticalScrollIndicator = false
        $0.register(HotPlaceTableViewCell.self, forCellReuseIdentifier: HotPlaceTableViewCell.cellIdentifier)
        $0.backgroundColor = .clear
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        hotPlaceTableView.delegate = self
        hotPlaceTableView.dataSource = self
        setUpView()
        setUpConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func setUpView() {
        [titleView, hotPlaceTableView].forEach {
            view.addSubview($0)
        }
        [titleLabel, logoImageView].forEach {
            titleView.addSubview($0)
        }
        self.hotPlaceTableView.separatorStyle = .singleLine
        self.hotPlaceTableView.separatorColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1)
//        self.taskTableView.separatorInset = UIEdgeInsets.zero
        self.hotPlaceTableView.contentInset = UIEdgeInsets(top: 35, left: 0, bottom: 35, right: 0)
        // MARK: 테이블뷰 헤더 간격 없앰
        if #available(iOS 15.0, *) {
            hotPlaceTableView.sectionHeaderTopPadding = 0
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
        hotPlaceTableView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom) // offset(35)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension HotPlaceViewController: UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HotPlaceTableViewCell.cellIdentifier) as? HotPlaceTableViewCell else {
            return UITableViewCell()
        }

        cell.backgroundColor = UIColor.clear
        cell.clipsToBounds = true

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
