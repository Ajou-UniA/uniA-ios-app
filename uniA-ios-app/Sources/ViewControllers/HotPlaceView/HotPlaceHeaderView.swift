//
//  HotPlaceHeaderView.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/06/01.
//

import UIKit
import Alamofire
import SnapKit
import Then

protocol HotPlaceHeaderViewDelegate: AnyObject {
    func searchBtnTapped2()
    func searchTextFieldChanged(_ text: String)
    func filteredText(_ query: String)
}

class HotPlaceHeaderView: UIView, UITextFieldDelegate {

    weak var delegate: HotPlaceHeaderViewDelegate?

    let getPlace = HotPlace()
    var places: [HotPlaceResponse] = []

    let baseView = UIView().then {
        $0.backgroundColor = .clear
    }

    let hotPlaceLabel = UILabel().then {
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 30)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.text = "Show some love\nto the restaurants\nyou enjoy!"
    }

    let hotPlaceImageView = UIImageView().then {
        $0.image = UIImage(named: "IceCream")
        $0.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi/12)
    }

    let searchTextField = UITextField().then {
        $0.font = UIFont(name: "Urbanist-Bold", size: 13)
        $0.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.textColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
        $0.tintColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
    }

    lazy var searchBtn = UIButton().then {
        $0.setImage(UIImage(named: "search"), for: .normal)
        $0.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 15, weight: .regular), forImageIn: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(searchBtnTapped), for: .touchUpInside)
    }

    lazy var sortByDistanceBtn = UIButton().then {
        $0.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        $0.layer.cornerRadius = 15
        $0.setTitle("Distance", for: .normal)
        $0.setTitleColor(UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }

    lazy var sortByRankBtn = UIButton().then {
        $0.backgroundColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 15
        $0.setTitle("Rank", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 13)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addBottomBorder(with: UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1), andWidth: CGFloat(1))
        searchTextField.delegate = self
        searchTextField.returnKeyType = .search
        setUpView()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }

    func setUpView() {
        addSubview(baseView)
        [hotPlaceLabel, hotPlaceImageView, searchTextField, sortByDistanceBtn, sortByRankBtn].forEach {
            baseView.addSubview($0)
        }
        searchTextField.addSubview(searchBtn)
        searchTextField.addLeftPadding3()
        searchTextField.addRightPadding()
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    func setUpConstraints() {
        baseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        hotPlaceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(39)
        }
        hotPlaceImageView.snp.makeConstraints {
            $0.centerY.equalTo(hotPlaceLabel)
            $0.leading.equalTo(hotPlaceLabel.snp.trailing)
        }
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(hotPlaceLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(39)
            $0.height.equalTo(Constant.height * 52)
        }
        searchBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(25)
        }
        sortByDistanceBtn.snp.makeConstraints {
            $0.leading.equalTo(searchTextField)
            $0.top.equalTo(searchTextField.snp.bottom).offset(15)
            $0.height.equalTo(Constant.height * 34)
            $0.width.equalTo(Constant.width * 90)
            $0.bottom.equalToSuperview().inset(15)
        }
        sortByRankBtn.snp.makeConstraints {
            $0.centerY.equalTo(sortByDistanceBtn)
            $0.leading.equalTo(sortByDistanceBtn.snp.trailing).offset(10)
            $0.height.equalTo(sortByDistanceBtn)
            $0.width.equalTo(Constant.width * 69)
        }
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: baseView.frame.size.height - borderWidth, width: baseView.frame.size.width, height: borderWidth)
        baseView.addSubview(border)
    }

    @objc
    func searchBtnTapped() {
        delegate?.searchBtnTapped2()
    }

    @objc
    func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            delegate?.searchTextFieldChanged(text)
            delegate?.filteredText(text)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.searchBtnTapped2()
        return true
    }
}
