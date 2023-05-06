//
//  AboutUniAMembersView.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/02.
//

import UIKit
import SafariServices
import SnapKit
import Then

class AboutUniAMembersView: UIView {

    let titleLabel = UILabel().then {
        $0.text = "About UniA Members"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 20)
    }

    let baseView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1).cgColor
    }

    let subView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1).cgColor
    }

    var imageView = UIImageView().then {
        $0.image = UIImage(named: "members")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    let subLabel = UILabel().then {
        $0.text = "About Our UniA Team Members!"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 18)
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
        [titleLabel, baseView].forEach {
            addSubview($0)
        }
        [subView, imageView].forEach {
            baseView.addSubview($0)
        }
        [subLabel].forEach {
            subView.addSubview($0)
        }
    }

    func setUpConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        baseView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Constant.height*214)
        }
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(subView.snp.top)
        }
        subView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Constant.height*70)
        }
        subLabel.snp.makeConstraints {
            $0.centerY.equalTo(subView)
            $0.leading.trailing.equalToSuperview().inset(14)
        }
    }
}
