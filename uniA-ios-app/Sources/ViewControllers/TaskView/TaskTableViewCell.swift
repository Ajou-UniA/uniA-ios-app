//
//  TaskTableViewCell.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/04/03.
//

import SnapKit
import Then
import UIKit

class TaskTableViewCell: UITableViewCell {

    static let cellIdentifier = "TaskTableViewCell"

    let baseView = UIView().then {
        $0.backgroundColor = .white
    }

    let courseNameLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 12)
    }

    let taskNameLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 16)
    }

    let timeLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 14)
    }

    let deadlineView = UIView().then {
        $0.layer.cornerRadius = 16
        $0.backgroundColor = UIColor(red: 1, green: 0.94, blue: 0.729, alpha: 1)
    }

    let dayLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 23)
    }

    let monthLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13) // 10
    }

    let dateStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
    }

    let moreImageView = UIImageView().then {
        $0.image = UIImage(named: "moreBtn")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectedBackgroundView = UIView()
        addBottomBorder(with: UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1), andWidth: CGFloat(1))
        setUpView()
        setUpConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpView() {
        self.contentView.addSubview(baseView)
        [courseNameLabel, taskNameLabel, timeLabel, deadlineView, moreImageView].forEach {
            baseView.addSubview($0)
        }
        [dateStackView].forEach {
            deadlineView.addSubview($0)
        }
        [dayLabel, monthLabel].forEach {
            dateStackView.addSubview($0)
        }
        [courseNameLabel, taskNameLabel, timeLabel, dayLabel, monthLabel].forEach {
            $0.sizeToFit()
            $0.adjustsFontForContentSizeCategory = true
        }
    }

    func setUpConstraint() {
        baseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        deadlineView.snp.makeConstraints {
            $0.top.bottom.lessThanOrEqualToSuperview().inset(15)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(deadlineView.snp.height)
            $0.centerY.equalToSuperview()
        }
        courseNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(23)
            $0.trailing.equalTo(moreImageView.snp.leading)
            $0.leading.equalTo(deadlineView.snp.trailing).offset(15)
        }
        taskNameLabel.snp.makeConstraints {
            $0.top.equalTo(courseNameLabel.snp.bottom).offset(9) // 9
            $0.leading.equalTo(courseNameLabel)
            $0.trailing.equalTo(moreImageView.snp.leading)
            $0.bottom.equalToSuperview().inset(41)
        }
        timeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(17)
            $0.bottom.equalToSuperview().inset(25)
        }
        dateStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.center.equalToSuperview()
        }
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        monthLabel.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom) // .offset(8.7)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        moreImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(Constant.height * 21)
            $0.width.equalTo(Constant.width * 21)
        }
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: baseView.frame.size.height - borderWidth, width: baseView.frame.size.width, height: borderWidth)
        baseView.addSubview(border)
    }
}
