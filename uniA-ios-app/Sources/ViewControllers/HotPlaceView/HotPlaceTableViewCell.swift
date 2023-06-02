//
//  HotPlaceTableViewCell.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/22.
//

import SnapKit
import Then
import UIKit
import Alamofire

protocol ContentsMainTextDelegate: AnyObject {
    func categoryButtonTapped()
}

class HotPlaceTableViewCell: UITableViewCell {

    static let cellIdentifier = "HotPlaceTableViewCell"

    var cellDelegate: ContentsMainTextDelegate?
    var count: Int = 0

    let getPlace = HotPlace()
    var places: [HotPlaceResponse] = []

    var selectedPlace = ""
    var restaurantName = ""

    let baseView = UIView().then {
        $0.backgroundColor = .white
    }

    let numberLabel = UILabel().then {
        $0.text = "1"
        $0.textColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 20)
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

    let heartBtn = UIButton()
//        .then {
//        $0.setImage(UIImage(named: "heart-off"), for: .normal)
//    }

    let countHeartLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 12)
    }

    let heartStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
    }

    let extraView = UIView().then {
        $0.backgroundColor = .yellow
    }

    let navigationBtn = UIButton().then {
        $0.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.setTitle("Navigation", for: .normal)
        $0.setTitleColor(UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }

    let seeRoadMapBtn = UIButton().then {
        $0.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.setTitle("See Road Map", for: .normal)
        $0.setTitleColor(UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectedBackgroundView = UIView()
        addBottomBorder(with: UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1), andWidth: CGFloat(1))
        extraView.isHidden = true
        setUpView()
        setUpConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpView() {
        self.contentView.addSubview(baseView)
        [numberLabel, restaurantNameLabel, kmLabel, heartStackView, extraView].forEach {
            baseView.addSubview($0)
        }
        [numberLabel, restaurantNameLabel, kmLabel, countHeartLabel].forEach {
            $0.sizeToFit()
            $0.adjustsFontForContentSizeCategory = true
        }
        [heartBtn, countHeartLabel].forEach {
            heartStackView.addSubview($0)
        }
    }

    func setUpConstraint() {
        baseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        numberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(33)
            $0.leading.equalToSuperview().offset(30)
        }
        restaurantNameLabel.snp.makeConstraints {
            $0.top.equalTo(numberLabel.snp.top)
            $0.leading.equalTo(numberLabel.snp.trailing).offset(30)
            $0.trailing.equalTo(heartStackView.snp.leading).inset(10) // 임시
        }
        kmLabel.snp.makeConstraints {
            $0.top.equalTo(restaurantNameLabel.snp.bottom).offset(7)
            $0.leading.equalTo(restaurantNameLabel)
            $0.bottom.equalToSuperview().inset(34)
////            $0.bottom.equalTo(extraView.snp.top).inset(34)
        }
        heartStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(27)
            $0.trailing.equalToSuperview().inset(30)
            $0.width.equalTo(heartBtn.snp.width)
        }
        heartBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Constant.height * 25)
            $0.width.equalTo(Constant.width * 30)
        }
        countHeartLabel.snp.makeConstraints {
            $0.top.equalTo(heartBtn.snp.bottom).offset(6.93)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        extraView.snp.makeConstraints {
            $0.top.equalTo(kmLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Constant.height * 25)
        }
    }

//    func updateLikeButton() {
//        let memberId = UserDefaults.standard.integer(forKey: "memberId")
//        getPlace.getLikedPlace(memberId: memberId) { likedRestaurants in
//            if likedRestaurants.contains(self.restaurantName) {
//                DispatchQueue.main.async {
//                    self.heartBtn.setImage(UIImage(named: "heart-on"), for: .normal)
//                }
//            } else {
//                DispatchQueue.main.async {
//                    self.heartBtn.setImage(UIImage(named: "heart-off"), for: .normal)
//                }
//            }
//        }
//    }

//    @objc
//    func heartBtnTapped(_ sender: UIButton) {
//        updateLikeButton()
//    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: baseView.frame.size.height - borderWidth, width: baseView.frame.size.width, height: borderWidth)
        baseView.addSubview(border)
    }
}

extension HotPlaceViewController: ContentsMainTextDelegate {

    func categoryButtonTapped() {
//        print("사용하고 싶은 기능들 추가")
    }
}



//print("heartBtnTapped")
//cellDelegate?.categoryButtonTapped()
//sender.isSelected.toggle()
//let memberId = UserDefaults.standard.integer(forKey: "memberId")
//let isSelected = sender.isSelected
//UserDefaults.standard.set(isSelected, forKey: selectedPlace)
//if isSelected == true {
//    print("selected")
//    getPlace.increaseLike(placeName: selectedPlace, memberId: memberId) { place in
//        print(self.selectedPlace, "increaseLike \(place)")
//        self.count += 1
//        DispatchQueue.main.async {
//        }
//    }
//    countHeartLabel.text = "\(count)"
//} else {
//    print("unselected")
//    getPlace.decreaseLike(placeName: selectedPlace, memberId: memberId) { place in
//        print(self.selectedPlace, "decreaseLike \(place)")
//        self.count -= 1
//        DispatchQueue.main.async {
//        }
//    }
//    countHeartLabel.text = "\(count)"
//}
//print("heartBtnTapped 2")
