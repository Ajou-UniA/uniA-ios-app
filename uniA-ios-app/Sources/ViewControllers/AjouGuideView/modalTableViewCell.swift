//
//  ModalTableViewCell.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/28.
//


import SnapKit
import Then
import UIKit

class ModalTableViewCell: UITableViewCell {
    // MARK: - Properties

    static let cellIdentifier = "ModalTableViewCell"

    let baseView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .clear
    }

    let nameLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 13)
    }

    // MARK: - Lifecycles

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectedBackgroundView = UIView()
        setUpView()
        setUpConstraint()
        self.contentView.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helper

    func setUpView() {
        self.contentView.addSubview(baseView)
        [nameLabel].forEach {
            baseView.addSubview($0)
        }
    }

    func setUpConstraint() {
        baseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
}
