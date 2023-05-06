//
//  AjouCampusMapViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/07.
//

import UIKit
import SnapKit
import Then

class AjouCampusMapView: UIView {

    let titleLabel = UILabel().then {
        $0.text = "Ajou Campus Map"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 20)
    }

    var imageView = UIImageView().then {
        $0.image = UIImage(named: "map")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
//        $0.layer.cornerRadius = 20
//        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.translatesAutoresizingMaskIntoConstraints = false
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
        [titleLabel, imageView].forEach {
            addSubview($0)
        }
    }

    func setUpConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(19)
        }
    }
}
