//
//  CongratulationsView.swift
//  uniA-ios-app
//
//  Created by HA on 2023/03/15.
//

import SnapKit
import Then
import UIKit

class CongratulationsView: UIViewController {
    //MARK: - Properties
    lazy var titleLabel = UILabel().then {
        $0.text = "Congratulations!"
        $0.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
    }
    //MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setUpView()
        setUpConstraints()
    }
    
    //MARK: - Helper

    func setUpView() {
        [titleLabel].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(114)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 220)
            $0.height.equalTo(Constant.height * 30)
        }
    }
}
