//
//  PolicyViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/19.
//

import UIKit

class PolicyViewController: UIViewController{
    // MARK: - Properties
    lazy var backBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "chevron_left"), for: .normal)
        $0.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    lazy var titleLabel = UILabel().then {
        $0.text = "To access UniA's services, please agree to the terms and conditions."
        $0.textAlignment = .left
        $0.font = UIFont(name: "Urbanist-Bold", size: 30)
        $0.numberOfLines = 0
    }
    lazy var termLabel = UILabel().then {
        $0.text = "I agree and accept Terms of Use"
        $0.textAlignment = .left
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }
    lazy var policyLabel = UILabel().then {
        $0.text = "I agree and accept Privacy Policy"
        $0.textAlignment = .left
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }
    lazy var termView = UIView().then {
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(termViewTapped)))
    }
    lazy var policyView = UIView().then {
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(policyViewTapped)))
    }
    lazy var chevronRightView1 = UIImageView().then {
        $0.image = UIImage(named: "chevron_right")
    }
    lazy var chevronRightView2 = UIImageView().then {
        $0.image = UIImage(named: "chevron_right")
    }
    lazy var agreeBtn = UIButton().then {
        $0.setTitle("Agree and continue", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(agreeBtnTapped), for: .touchUpInside)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }
    lazy var circleBtn1 = UIButton().then {
        $0.setImage(UIImage(named: "circle"), for: .normal)
        $0.addTarget(self, action: #selector(circle1BtnTapped), for: .touchUpInside)
    }
    lazy var circleBtn2 = UIButton().then {
        $0.setImage(UIImage(named: "circle"), for: .normal)
        $0.addTarget(self, action: #selector(circle2BtnTapped), for: .touchUpInside)
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.navigationController?.navigationBar.isHidden = true

        setUpView()
        setUpConstraints()
    }
    // MARK: - Helper
    
    func setUpView() {
        [backBtn, titleLabel, circleBtn1, circleBtn2, termView, policyView, agreeBtn].forEach {
            view.addSubview($0)
        }
        [chevronRightView1, termLabel].forEach { termView.addSubview($0) }
        [chevronRightView2, policyLabel].forEach { policyView.addSubview($0) }

    }
    
    func setUpConstraints() {
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
            $0.width.equalTo(Constant.width * 24)
            $0.height.equalTo(Constant.height * 24)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backBtn.snp.bottom).offset(100)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
        circleBtn1.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(199)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(25)
            $0.width.equalTo(Constant.width * 30)
            $0.height.equalTo(Constant.height * 30)
        }
        circleBtn2.snp.makeConstraints {
            $0.top.equalTo(circleBtn1.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(25)
            $0.width.equalTo(Constant.width * 30)
            $0.height.equalTo(Constant.height * 30)
        }
        termView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(203)
            $0.bottom.equalTo(titleLabel.snp.bottom).offset(227)
            $0.leading.equalTo(circleBtn1.snp.trailing).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(27)
        }
        policyView.snp.makeConstraints {
            $0.top.equalTo(termView.snp.bottom).offset(28)
            $0.bottom.equalTo(termView.snp.bottom).offset(52)
            $0.leading.equalTo(circleBtn2.snp.trailing).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(27)
        }
        termLabel.snp.makeConstraints {
            $0.top.equalTo(termView.snp.top)
            $0.leading.equalTo(termView.snp.leading)
        }
        policyLabel.snp.makeConstraints {
            $0.top.equalTo(policyView.snp.top)
            $0.leading.equalTo(policyView.snp.leading)
        }
        chevronRightView1.snp.makeConstraints {
            $0.top.equalTo(termView.snp.top)
            $0.trailing.equalTo(termView.snp.trailing)
            $0.width.equalTo(Constant.width * 24)
            $0.height.equalTo(Constant.height * 24)
        }
        chevronRightView2.snp.makeConstraints {
            $0.top.equalTo(policyView.snp.top)
            $0.trailing.equalTo(policyView.snp.trailing)
            $0.width.equalTo(Constant.width * 24)
            $0.height.equalTo(Constant.height * 24)
        }
        agreeBtn.snp.makeConstraints {
            $0.top.equalTo(policyView.snp.bottom).offset(43)
            $0.bottom.equalTo(policyView.snp.bottom).offset(95)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(37)
        }
    }
    // MARK: - Objc

    @objc
    func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc
    func agreeBtnTapped() {
        if count == 2 {
            let confirmEmailViewController = ConfirmEmailViewController()
            navigationController?.pushViewController(confirmEmailViewController, animated: true)
        } else {
            return
        }
    }
    
    @objc
    func termViewTapped() {
        
    }
    @objc
    func policyViewTapped() {
        
    }
    var flag1 = 0
    var flag2 = 0
    var count = 0
    @objc func circle1BtnTapped() {
            if flag1 == 0 {
                circleBtn1.setImage(UIImage(named: "circle_selected"), for: .normal)
                count += 1
                flag1 = 1
            } else {
                circleBtn1.setImage(UIImage(named: "circle"), for: .normal)
                count -= 1
                flag1 = 0
            }
        }
    
    @objc func circle2BtnTapped() {
            if flag2 == 0 {
                circleBtn2.setImage(UIImage(named: "circle_selected"), for: .normal)
                count += 1
                flag2 = 1
            } else {
                circleBtn2.setImage(UIImage(named: "circle"), for: .normal)
                count -= 1
                flag2 = 0
            }
        }
}
