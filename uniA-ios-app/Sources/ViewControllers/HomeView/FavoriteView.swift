//
//  FavoriteView.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/02.
//

import UIKit
import SafariServices
import SnapKit
import Then

enum ButtonType: Int {
    case link1 = 1
    case link2 = 2
    case link3 = 3
    case link4 = 4
}

class FavoriteView: UIView {

    let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }

    let contentView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    let favoriteTitleLabel = UILabel().then {
        $0.text = "Favorite"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 20)
    }

    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 11
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
    }

    // 공지사항
    let noticeBtn = UIButton().then {
        $0.tag = ButtonType.link1.rawValue
        $0.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        $0.layer.cornerRadius = 15
    }

    let noticeBtnLabel = UILabel().then {
        $0.text = "AN"
        $0.textColor = UIColor(red: 0.429, green: 0.657, blue: 1, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 37)
    }


    let noticeLabel = UILabel().then {
        $0.text = "Ajou Notice"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 12)
    }

    // 포탈
    let portalBtn = UIButton().then {
        $0.tag = ButtonType.link2.rawValue
        $0.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        $0.layer.cornerRadius = 15
    }

    let portalBtnLabel = UILabel().then {
        $0.text = "AP"
        $0.textColor = UIColor(red: 0.565, green: 0.863, blue: 1, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 37)
    }

    let portalLabel = UILabel().then {
        $0.text = "Ajou Portal"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 12)
    }

    // OIA
    let OIABtn = UIButton().then {
        $0.tag = ButtonType.link3.rawValue
        $0.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        $0.layer.cornerRadius = 15
    }

    let OIABtnLabel = UILabel().then {
        $0.text = "OIA"
        $0.textColor = UIColor(red: 0.765, green: 0.78, blue: 1, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 37)
    }

    let OIALabel = UILabel().then {
        $0.text = "OIA"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 12)
    }

    // 중앙도서관
    let libraryBtn = UIButton().then {
        $0.tag = ButtonType.link4.rawValue
        $0.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        $0.layer.cornerRadius = 15
    }

    let libraryBtnLabel = UILabel().then {
        $0.text = "CL"
        $0.textColor = UIColor(red: 0.863, green: 0.776, blue: 1, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 37)
    }

    let libraryLabel = UILabel().then {
        $0.text = "Central Library"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 12)
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
        [favoriteTitleLabel, scrollView].forEach {
            addSubview($0)
        }
        self.scrollView.addSubview(contentView)
        [noticeBtn, noticeLabel, portalBtn, portalLabel, OIABtn, OIALabel, libraryBtn, libraryLabel].forEach {
            contentView.addSubview($0)
        }
        self.noticeBtn.addSubview(noticeBtnLabel)
        self.portalBtn.addSubview(portalBtnLabel)
        self.OIABtn.addSubview(OIABtnLabel)
        self.libraryBtn.addSubview(libraryBtnLabel)
    }

    func setUpConstraints() {
        favoriteTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(favoriteTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(scrollView.snp.height) // 스크롤 안됨 현상 해결
        }
        noticeBtn.heightAnchor.constraint(equalTo: noticeBtn.widthAnchor, multiplier: 1.0/1.0).isActive = true
        noticeBtn.snp.makeConstraints {
            $0.top.equalTo(favoriteTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.width.equalTo(Constant.width * 70)
        }
        noticeBtnLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        noticeLabel.snp.makeConstraints {
            $0.centerX.equalTo(noticeBtn)
            $0.top.equalTo(noticeBtn.snp.bottom).offset(15)
            $0.bottom.equalToSuperview()
        }
        portalBtn.snp.makeConstraints {
            $0.top.equalTo(favoriteTitleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(noticeBtn.snp.trailing).offset(25)
            $0.height.width.equalTo(noticeBtn)
        }
        portalBtnLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        portalLabel.snp.makeConstraints {
            $0.centerX.equalTo(portalBtn)
            $0.top.equalTo(portalBtn.snp.bottom).offset(15)
            $0.bottom.equalToSuperview()
        }
        OIABtn.snp.makeConstraints {
            $0.top.equalTo(favoriteTitleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(portalBtn.snp.trailing).offset(25)
            $0.height.width.equalTo(noticeBtn)
        }
        OIABtnLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        OIALabel.snp.makeConstraints {
            $0.centerX.equalTo(OIABtn)
            $0.top.equalTo(OIABtn.snp.bottom).offset(15)
            $0.bottom.equalToSuperview()
        }
        libraryBtn.snp.makeConstraints {
            $0.top.equalTo(favoriteTitleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(OIABtn.snp.trailing).offset(25)
            $0.trailing.equalToSuperview()
            $0.height.width.equalTo(noticeBtn)
        }
        libraryBtnLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        libraryLabel.snp.makeConstraints {
            $0.centerX.equalTo(libraryBtn)
            $0.top.equalTo(libraryBtn.snp.bottom).offset(15)
            $0.bottom.equalToSuperview()
        }
    }
}
