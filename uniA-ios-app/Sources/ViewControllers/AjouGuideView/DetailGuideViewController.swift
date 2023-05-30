//
//  DetailGuideViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/29.
//

import SnapKit
import Then
import UIKit

class DetailGuideViewController: UIViewController, UITextViewDelegate {
    // MARK: - Properties
    
    lazy var backBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "chevron_left"), for: .normal)
        $0.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    lazy var titleLabel = UILabel().then {
        $0.text = "Ajou Campus Life"
        $0.textColor = .black
        $0.font = UIFont(name: "Urbanist-Bold", size: 20)
    }
    
    lazy var subtitleLabel = UILabel().then {
        $0.text = "Ajou Campus Life"
        $0.textAlignment = .left
        $0.font = UIFont(name: "Urbanist-Bold", size: 20)
        $0.numberOfLines = 0
        $0.textColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
    }
    lazy var textView = UITextView().then {
        $0.isEditable = false
        $0.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
    }
    
    let textViewPadding: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        textView.delegate = self
        textView.textContainerInset = textViewPadding

        setUpView()
        setUpConstraints()
    }
    
    
    // MARK: - Helper
    
    func setUpView() {
        [backBtn, titleLabel,subtitleLabel, textView].forEach {
            view.addSubview($0)
        }
    }
    
    func setUpConstraints() {
        
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
            $0.width.equalTo(Constant.width * 24)
            $0.height.equalTo(backBtn.snp.width).multipliedBy(1.0/1.0)
        }
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backBtn)
            $0.centerX.equalToSuperview()
        }
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(63)
        }
        textView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    // MARK: - Objc
    
    @objc
    func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
