//
//  PopUpViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/03/25.
//

import SnapKit
import Then
import UIKit

class PopUpViewController: UIViewController {
    //MARK: - Properties
    
    var imageName = ["card1","card2","card3"]
    var numImage = 0
    
    lazy var cancelBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "close"), for: .normal)
        $0.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
    }
    lazy var cardView = UIImageView().then{
        $0.image = UIImage(named: imageName[numImage])
        $0.layer.cornerRadius = 20.0
    }
   
    //MARK: - Lifecycles
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpGesture()
        setUpView()
        setUpConstraints()
    }
    //MARK: - Helper
    
    func setUpView() {
        [cardView,cancelBtn].forEach {
            view.addSubview($0)
        }
    }
    
    func setUpConstraints() {
        cardView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(17)
            $0.width.equalTo(Constant.width * 350)
            $0.height.equalTo(Constant.height * 350)
            
        }
        cancelBtn.snp.makeConstraints {
            $0.top.equalTo(cardView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 50)
            $0.height.equalTo(Constant.height * 50)
                  
        }
    }
    
    func setUpGesture(){
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeLeftGesture.direction = .left
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeRightGesture.direction = .right

        view.addGestureRecognizer(swipeLeftGesture)
        view.addGestureRecognizer(swipeRightGesture)
    }
    
    //MARK: - objc
    @objc func cancelBtnTapped() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            numImage += 1
            if numImage < imageName.count{
                cardView.image = UIImage(named: imageName[numImage])
            }else{
                numImage = 0
                cardView.image = UIImage(named: imageName[numImage])
            }
        
        } else if gesture.direction == .right {
            numImage -= 1
            if numImage < 0{
                numImage = imageName.count - 1
                cardView.image = UIImage(named: imageName[numImage])
            }else {
                cardView.image = UIImage(named: imageName[numImage])
            }
        }
    }
}
//0,1,2
