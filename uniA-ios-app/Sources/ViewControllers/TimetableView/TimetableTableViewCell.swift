//
//  TimetableTableViewCell.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/03/25.
//

import SnapKit
import Then
import UIKit

class TimetableTableViewCell: UITableViewCell {

    static let cellIdentifier = "TimetableTableViewCell"

    let baseView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }

    let timeLabel = UILabel().then {
        $0.text = "9:00-10:15"
        $0.textColor = UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 12)
    }

    let courseNameLabel = UILabel().then {
        $0.text = "Data Structure"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 15)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectedBackgroundView = UIView()
        setUpView()
        setUpConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpView() {
        self.contentView.addSubview(baseView)
        [timeLabel, courseNameLabel].forEach {
            baseView.addSubview($0)
        }
    }

    func setUpConstraint() {
        baseView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(38)
            $0.bottom.equalToSuperview().inset(17)
        }
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22.5)
            $0.leading.equalToSuperview().inset(21)
        }
        courseNameLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(3)
            $0.leading.equalTo(timeLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(22.5)
        }
    }
}
