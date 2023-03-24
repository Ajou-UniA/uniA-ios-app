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
        self.view.backgroundColor = .systemGray6
        self.navigationController?.navigationBar.backgroundColor = .white
        self.title = "About Ajou"
        
        self.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(descriptor: UIFontDescriptor(name: "SF Mono SemiBold", size: 30), size: 30)]
        
        setUpView()
        setUpConstraints()
    }
    
    //MARK: - Helper

    func setUpView() {
        [firstNewsBtn,secondNewsBtn,thirdNewsBtn,fourthNewsBtn,firstLabel,secondLabel,thirdLabel,fourthLabel].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        firstNewsBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.width.equalTo(Constant.width * 169)
            $0.height.equalTo(Constant.height * 169)
                  
        }
        secondNewsBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(17)
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
}
