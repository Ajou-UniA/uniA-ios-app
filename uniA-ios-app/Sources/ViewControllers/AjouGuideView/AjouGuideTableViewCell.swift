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
        addBottomBorder(with: UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1), andWidth: CGFloat(1))
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
    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
            let border = UIView()
            border.backgroundColor = color
            border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
            border.frame = CGRect(x: 0, y: baseView.frame.size.height - borderWidth, width: baseView.frame.size.width, height: borderWidth)
            baseView.addSubview(border)
        }
    
}
