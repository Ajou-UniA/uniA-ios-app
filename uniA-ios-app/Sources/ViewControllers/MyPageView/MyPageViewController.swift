//
//  MyPageViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/10.
//

import SnapKit
import Then
import UIKit

class MyPageViewController: UIViewController {
    lazy var backBtn = UIButton().then {
        $0.setTitle("뒤로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)

        setUpView()
        setUpConstraint()
    }

    func setUpView() {
        [backBtn].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraint() {
        backBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 70)
            $0.height.equalTo(Constant.height * 50)
        }
    }

    @objc
    func backBtnTapped() {
        dismissView()
    }
}
