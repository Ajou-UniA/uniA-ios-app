//
//  AjouGuideTableViewCell.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/28.
//


import SnapKit
import Then
import UIKit

class AjouGuideTableViewCell: UITableViewCell {
    // MARK: - Properties

    static let cellIdentifier = "AjouGuideTableViewCell"

    let baseView = UIView()

    let nameLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 15)
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
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(27)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-27)
            $0.centerY.equalToSuperview()
        }
    }
    
}
