//
//  AboutAjouViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/03/23.
//

import SnapKit
import Then
import UIKit

class AboutAjouViewController: UIViewController {
    //MARK: - Properties
    lazy var topView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    lazy var backBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "chevron_left"), for: .normal)
        $0.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)

    }
    lazy var titleLabel = UILabel().then {
        $0.text = "About Ajou"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
    }
    lazy var firstLabel = UILabel().then {
        $0.text = "Card1"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    lazy var secondLabel = UILabel().then {
        $0.text = "Card2"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    lazy var thirdLabel = UILabel().then {
        $0.text = "Card3"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    lazy var fourthLabel = UILabel().then {
        $0.text = "Card4"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    lazy var firstNewsBtn = UIButton().then {
        $0.layer.cornerRadius = 20.0
        $0.backgroundColor = .white
        $0.addTarget(self, action: #selector(firstNewsBtnTapped), for: .touchUpInside)

    }
    
    lazy var secondNewsBtn = UIButton().then {
        $0.layer.cornerRadius = 20.0
        $0.backgroundColor = .white
    }
    
    lazy var thirdNewsBtn = UIButton().then {
        $0.layer.cornerRadius = 20.0
        $0.backgroundColor = .white
    }
    
    lazy var fourthNewsBtn = UIButton().then {
        $0.layer.cornerRadius = 20.0
        $0.backgroundColor = .white
    }
    
    //MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true;

        setUpView()
        setUpConstraints()
    }
    
    //MARK: - Helper

    func setUpView() {
        self.view.addSubview(topView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(backBtn)
        [firstNewsBtn,secondNewsBtn,thirdNewsBtn,fourthNewsBtn,firstLabel,secondLabel,thirdLabel,fourthLabel].forEach {
            topView.addSubview($0)
        }
    }

    func setUpConstraints() {
        
        topView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(68)
        }
        titleLabel.snp.makeConstraints{
            $0.bottom.equalTo(topView.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 160)
            $0.height.equalTo(Constant.height * 30)
        }
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(23)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
            $0.width.equalTo(Constant.width * 35)
            $0.height.equalTo(Constant.height * 35)
                  
        }
        firstNewsBtn.snp.makeConstraints {
            $0.top.equalTo(topView.snp.top).offset(17)
            $0.leading.equalTo(topView.snp.leading).offset(17)
            $0.width.equalTo(Constant.width * 169)
            $0.height.equalTo(Constant.height * 169)
                  
        }
        
        secondNewsBtn.snp.makeConstraints {
            $0.top.equalTo(topView.snp.top).offset(17)
            $0.leading.equalTo(firstNewsBtn.snp.trailing).offset(17)
            $0.width.equalTo(Constant.width * 169)
            $0.height.equalTo(Constant.height * 169)
                  
        }
        thirdNewsBtn.snp.makeConstraints {
            $0.top.equalTo(firstLabel.snp.bottom).offset(21)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(17)
            $0.width.equalTo(Constant.width * 169)
            $0.height.equalTo(Constant.height * 169)
                  
        }
        fourthNewsBtn.snp.makeConstraints {
            $0.top.equalTo(secondLabel.snp.bottom).offset(21)
            $0.leading.equalTo(thirdNewsBtn.snp.trailing).offset(17)
            $0.width.equalTo(Constant.width * 169)
            $0.height.equalTo(Constant.height * 169)
                  
        }
        firstLabel.snp.makeConstraints {
            $0.top.equalTo(firstNewsBtn.snp.bottom).offset(6)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(72)
            $0.width.equalTo(Constant.width * 60)
            $0.height.equalTo(Constant.height * 25)
                  
        }
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(secondNewsBtn.snp.bottom).offset(6)
            $0.leading.equalTo(firstLabel.snp.trailing).offset(126)
            $0.width.equalTo(Constant.width * 60)
            $0.height.equalTo(Constant.height * 25)
                  
        }
        thirdLabel.snp.makeConstraints {
            $0.top.equalTo(thirdNewsBtn.snp.bottom).offset(6)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(72)
            $0.width.equalTo(Constant.width * 60)
            $0.height.equalTo(Constant.height * 25)
                  
        }
        fourthLabel.snp.makeConstraints {
            $0.top.equalTo(fourthNewsBtn.snp.bottom).offset(6)
            $0.leading.equalTo(thirdLabel.snp.trailing).offset(126)
            $0.width.equalTo(Constant.width * 60)
            $0.height.equalTo(Constant.height * 25)
                  
        }
    }
    //MARK: - Navigation
    @objc func firstNewsBtnTapped() {
        let popUpViewController = PopUpViewController()
        navigationController?.pushViewController(popUpViewController, animated: false)
    }
    
    @objc func cancelBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
