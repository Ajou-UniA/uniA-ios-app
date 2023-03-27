//
//  DetailCoursePopUpViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/25.
//

import SnapKit
import Then
import UIKit

class DetailCoursePopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        setUpView()
        setUpConstraints()
    }

    func setUpView() {
        [].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
    }
}
