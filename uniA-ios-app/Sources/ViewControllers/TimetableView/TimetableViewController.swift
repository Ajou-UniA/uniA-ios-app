//
//  ScheduleViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/10.
//

import SnapKit
import Then
import UIKit

class TimetableViewController: UIViewController {

    let mainView = TimetableView().then {
        $0.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        mainView.addCourseBtn.addTarget(self, action: #selector(addCourseBtnTapped), for: .touchUpInside)
        setUpView()
        setUpConstraints()
    }

    func setUpView() {
        [mainView].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        mainView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }

    @objc
    func addCourseBtnTapped() {
    }
}
