//
//  HotPlacePopUpViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/31.
//

import UIKit
import Alamofire
import SnapKit
import Then
import SafariServices

enum ButtonType2: Int {
    case link1 = 1 // navigationBtn
    case link2 = 2 // seeRoadMapBtn
}

class DetailPlaceViewController: UIViewController {

    let getPlace = HotPlace()
    var places: [HotPlaceResponse] = []

    var selectedPlace = ""

    var number = ""
    var restaurantName = ""
    var distance = ""
    var navigationUrl = ""
    var roadMapUrl = ""

    let baseView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
    }

    let numberLabel = UILabel().then {
        $0.text = "1"
        $0.textColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 20)
    }

    let heartImageView = UIImageView().then {
        $0.image = UIImage(named: "small-heart")
    }

    let heartCountLabel = UILabel().then {
        $0.text = "999+"
        $0.textColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }

    let restaurantNameLabel = UILabel().then {
        $0.text = "Restaurant Name"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 20)
        $0.numberOfLines = 0
    }

    let kmLabel = UILabel().then {
        $0.text = "0.00 Km"
        $0.textColor = UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 12)
    }

    let navigationBtn = UIButton().then {
        $0.tag = ButtonType2.link1.rawValue
        $0.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.setTitle("Navigation", for: .normal)
        $0.setTitleColor(UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }

    let seeRoadMapBtn = UIButton().then {
        $0.tag = ButtonType2.link2.rawValue
        $0.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.setTitle("See Road Map", for: .normal)
        $0.setTitleColor(UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }

    lazy var backBtn = UIButton().then {
        $0.setImage(UIImage(named: "small-close"), for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.3)
        restaurantNameLabel.text = restaurantName
        kmLabel.text = distance
        backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        navigationBtn.addTarget(self, action: #selector(linkTapped2), for: .touchUpInside)
        seeRoadMapBtn.addTarget(self, action: #selector(linkTapped2), for: .touchUpInside)
        setUpView()
        setUpConstraint()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func setUpView() {
        self.view.addSubview(baseView)
        [heartImageView, heartCountLabel, numberLabel, restaurantNameLabel, kmLabel, navigationBtn, seeRoadMapBtn, backBtn].forEach {
            baseView.addSubview($0)
        }
        [numberLabel, restaurantNameLabel, kmLabel].forEach {
            $0.sizeToFit()
            $0.adjustsFontForContentSizeCategory = true
        }
    }

    func setUpConstraint() {
        baseView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15) // 대략
            $0.bottom.equalToSuperview().inset(53) // 대략
        }
        heartImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.leading.equalToSuperview().offset(30)
        }
        heartCountLabel.snp.makeConstraints {
            $0.leading.equalTo(heartImageView.snp.trailing).offset(5)
            $0.centerY.equalTo(heartImageView)
        }
        numberLabel.snp.makeConstraints {
            $0.top.equalTo(heartImageView.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(30)
        }
        restaurantNameLabel.snp.makeConstraints {
            $0.top.equalTo(numberLabel.snp.top)
            $0.leading.equalTo(numberLabel.snp.trailing).offset(30)
            $0.trailing.equalToSuperview().inset(30)
        }
        kmLabel.snp.makeConstraints {
            $0.top.equalTo(restaurantNameLabel.snp.bottom).offset(7)
            $0.leading.equalTo(restaurantNameLabel)
        }
        navigationBtn.snp.makeConstraints {
            $0.top.equalTo(kmLabel.snp.bottom).offset(38)
            $0.leading.equalTo(numberLabel)
            $0.bottom.equalToSuperview().inset(25)
            $0.height.equalTo(Constant.height * 40)
        }
        seeRoadMapBtn.snp.makeConstraints {
            $0.centerY.equalTo(navigationBtn)
            $0.leading.equalTo(navigationBtn.snp.trailing).offset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.width.equalTo(navigationBtn)
        }
        backBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().inset(14)
        }
    }

    @objc
    func backBtnTapped() {
        self.dismiss(animated: true)
    }

    @objc
    func linkTapped2(_ button: UIButton) {
        if let type = ButtonType2(rawValue: button.tag) {
            switch type {
            case .link1:
                let navigationUrl = NSURL(string: navigationUrl)
                let navigationSafariView: SFSafariViewController = SFSafariViewController(url: navigationUrl! as URL)
                self.present(navigationSafariView, animated: true, completion: nil)
            case .link2:
                let roadMapUrl = NSURL(string: roadMapUrl)
                let roadMapSafariView: SFSafariViewController = SFSafariViewController(url: roadMapUrl! as URL)
                self.present(roadMapSafariView, animated: true, completion: nil)
            }
        }
    }
}
