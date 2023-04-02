//
//  EditMyProfileViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/02.
//

import SnapKit
import Then
import UIKit

class EditMyProfileViewController: UIViewController {
    //MARK: - Properties
    lazy var backBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "chevron_left"), for: .normal)
        $0.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
    }
    
    lazy var titleLabel = UILabel().then {
        $0.text = "Edit My Profile"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
    }
    let borderView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    }
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true;

        setUpView()
        setUpConstraints()
    }
    //MARK: - Helper

    func setUpView() {
        [borderView,backBtn,titleLabel].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        borderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(85)
            $0.height.equalTo(Constant.height * 0.5)
            $0.leading.trailing.equalToSuperview()
        }
        backBtn.snp.makeConstraints {
            $0.bottom.equalTo(borderView.snp.top).offset(-20)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
            $0.width.equalTo(Constant.width * 35)
            $0.height.equalTo(Constant.height * 35)
        }
        titleLabel.snp.makeConstraints{
            $0.bottom.equalTo(borderView.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 180)
        }
    }
    //MARK: - Navigation
    @objc func cancelBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
