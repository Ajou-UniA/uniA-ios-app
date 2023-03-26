//
//  PopUpViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/03/25.
//

import SnapKit
import Then
import UIKit

class PopUpView: UIViewController {
    //MARK: - Properties
    lazy var aboutBtn = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    lazy var popupView = UIView().then {
        $0.backgroundColor = .systemRed
    }
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        
        setUpView()
        setUpConstraints()
    }
    //MARK: - Helper
    func setUpView() {
        [popupView].forEach {
            view.addSubview($0)
        }
        self.popupView.addSubview(aboutBtn)
    }
    
    func setUpConstraints() {
        
        popupView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(17)
            $0.width.equalTo(Constant.width * 350)
            $0.height.equalTo(Constant.height * 350)
            
        }
     
        aboutBtn.snp.makeConstraints {
            $0.top.equalTo(popupView.snp.top).offset(15)
            $0.trailing.equalTo(popupView.snp.trailing).inset(15)
            $0.width.equalTo(Constant.width * 30)
            $0.height.equalTo(Constant.height * 30)
                  
        }
    }
}
