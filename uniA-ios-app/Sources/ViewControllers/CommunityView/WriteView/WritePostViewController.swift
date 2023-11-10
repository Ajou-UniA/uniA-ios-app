//
//  WritePostViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/11/08.
//

import UIKit
import SnapKit
import Then

class WritePostViewController: UIViewController {
    // MARK: - Properties
    private let titleView = UIView().then {
        $0.backgroundColor = .white
    }
    lazy var closeBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "closeBtn"), for: .normal)
        $0.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
    }
    private let titleLabel = UILabel().then {
        $0.text = "Create new post"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 20)
    }
    lazy var postLabel = UILabel().then {
        $0.text = "Post"
        $0.font = UIFont(name: "Urbanist-Bold", size: 16)
        $0.isUserInteractionEnabled = true
        $0.textColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(postTap(_:))))
    }
    lazy var subtitleLabel = UILabel().then {
        $0.text = "Select a category"
        $0.textAlignment = .left
        $0.font = UIFont(name: "Urbanist-Bold", size: 16)
    }
    lazy var categoryScrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.showsHorizontalScrollIndicator = false
    }
    lazy var categoryStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.backgroundColor = .clear
    }
    lazy var allBtnView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
        $0.layer.cornerRadius = 21 // 적절한 코너 반경 설정 (width의 반 값)
        $0.clipsToBounds = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(allBtnTap(_:))))
    }
    lazy var allBtnLabel = UILabel().then {
        $0.text = "All"
        $0.textColor = .white
        $0.font = UIFont(name: "Urbanist-semiBold", size: 13)
    }
    lazy var noticeBtnView = UIView().then {
        $0.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        $0.layer.cornerRadius = 21 // 적절한 코너 반경 설정 (width의 반 값)
        $0.clipsToBounds = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(noticeBtnTap(_:))))
    }
    lazy var noticeBtnLabel = UILabel().then {
        $0.text = "Notice"
        $0.textColor = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
        $0.font = UIFont(name: "Urbanist-semiBold", size: 13)
    }
    lazy var promotionBtnView = UIView().then {
        $0.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        $0.layer.cornerRadius = 21 // 적절한 코너 반경 설정 (width의 반 값)
        $0.clipsToBounds = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(promotionBtnTap(_:))))
    }
    lazy var promotionBtnLabel = UILabel().then {
        $0.text = "Promotion"
        $0.textColor = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
        $0.font = UIFont(name: "Urbanist-semiBold", size: 13)
    }
    lazy var internationalBtnView = UIView().then {
        $0.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        $0.layer.cornerRadius = 21 // 적절한 코너 반경 설정 (width의 반 값)
        $0.clipsToBounds = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(internationalBtnTap(_:))))
    }
    lazy var internationalBtnLabel = UILabel().then {
        $0.text = "International student"
        $0.textColor = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
        $0.font = UIFont(name: "Urbanist-semiBold", size: 13)
    }
    lazy var exchangeBtnView = UIView().then {
        $0.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        $0.layer.cornerRadius = 21
        $0.clipsToBounds = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(exchangeBtnTap(_:))))
    }
    lazy var exchangeBtnLabel = UILabel().then {
        $0.text = "Exchange student"
        $0.textColor = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
        $0.font = UIFont(name: "Urbanist-semiBold", size: 13)
    }
    lazy var profileView = UIView().then {
        $0.backgroundColor = .white
    }
    lazy var profileImageView = UIImageView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//        $0.image = UIImage(named: "profileLogo")
        $0.layer.cornerRadius = $0.bounds.width / 2
        $0.clipsToBounds = true
        $0.backgroundColor = .black
    }
    lazy var nameLabel = UILabel().then {
        $0.text = "UniA Paranni"
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 14)
    }
    lazy var dateLabel = UILabel().then {
        $0.text = "15 July 2023"
        $0.font = UIFont(name: "Urbanist-Regular", size: 12)
        $0.textColor = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
    }
    lazy var titleTextField = UITextField().then {
        $0.placeholder = "Add a title"
        $0.borderStyle = .roundedRect
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 18)
    }
    lazy var contentTextField = UITextField().then {
        $0.placeholder = "Write something or add an image file!"
        $0.borderStyle = .roundedRect
        $0.font = UIFont(name: "Urbanist-Regular", size: 16)
    }
    lazy var addImageView = UIImageView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 18, height: 14)
        $0.image = UIImage(named: "addImage")
        $0.contentMode = .scaleAspectFit
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addImageBtnTap(_:))))

    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpView()
        setUpConstraints()
        categoryStackView.addArrangedSubview(allBtnView)
        categoryStackView.addArrangedSubview(noticeBtnView)
        categoryStackView.addArrangedSubview(promotionBtnView)
        categoryStackView.addArrangedSubview(internationalBtnView)
        categoryStackView.addArrangedSubview(exchangeBtnView)
    }
    func setUpView() {
        [titleView, closeBtn, titleLabel, postLabel, subtitleLabel, categoryScrollView,profileView,profileImageView,nameLabel,dateLabel,titleTextField, contentTextField, addImageView].forEach {
            view.addSubview($0) }
        allBtnView.addSubview(allBtnLabel)
        noticeBtnView.addSubview(noticeBtnLabel)
        promotionBtnView.addSubview(promotionBtnLabel)
        internationalBtnView.addSubview(internationalBtnLabel)
        exchangeBtnView.addSubview(exchangeBtnLabel)
        categoryScrollView.addSubview(categoryStackView)
    }
    func setUpConstraints() {
        titleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constant.height * 115)
        }
        closeBtn.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.top).offset(69)
            $0.leading.equalTo(titleView.snp.leading).offset(24)
            $0.bottom.equalTo(titleView.snp.bottom).inset(22)
            $0.width.equalTo(Constant.width * 24)
            $0.height.equalTo(closeBtn.snp.width).multipliedBy(1.0/1.0)
        }
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(closeBtn)
            $0.centerX.equalToSuperview()
        }
        postLabel.snp.makeConstraints {
            $0.centerY.equalTo(closeBtn)
            $0.trailing.equalTo(titleView.snp.trailing).inset(24)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(titleView.snp.trailing).inset(24)
        }
        categoryScrollView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(subtitleLabel.snp.bottom).offset(70)
        }
        categoryStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(categoryScrollView.snp.leading).offset(10)
            $0.trailing.equalTo(categoryScrollView.snp.trailing).inset(10)
        }
        allBtnLabel.snp.makeConstraints {
            $0.top.equalTo(allBtnView.snp.top).offset(12)
            $0.bottom.equalTo(allBtnView.snp.bottom).inset(12)
            $0.leading.equalTo(allBtnView.snp.leading).offset(20)
            $0.trailing.equalTo(allBtnView.snp.trailing).inset(20)
        }
        noticeBtnLabel.snp.makeConstraints {
            $0.top.equalTo(noticeBtnView.snp.top).offset(12)
            $0.bottom.equalTo(noticeBtnView.snp.bottom).inset(12)
            $0.leading.equalTo(noticeBtnView.snp.leading).offset(20)
            $0.trailing.equalTo(noticeBtnView.snp.trailing).inset(20)
        }
        promotionBtnLabel.snp.makeConstraints {
            $0.top.equalTo(promotionBtnView.snp.top).offset(12)
            $0.bottom.equalTo(promotionBtnView.snp.bottom).inset(12)
            $0.leading.equalTo(promotionBtnView.snp.leading).offset(20)
            $0.trailing.equalTo(promotionBtnView.snp.trailing).inset(20)
        }
        internationalBtnLabel.snp.makeConstraints {
            $0.top.equalTo(internationalBtnView.snp.top).offset(12)
            $0.bottom.equalTo(internationalBtnView.snp.bottom).inset(12)
            $0.leading.equalTo(internationalBtnView.snp.leading).offset(20)
            $0.trailing.equalTo(internationalBtnView.snp.trailing).inset(20)
        }
        exchangeBtnLabel.snp.makeConstraints {
            $0.top.equalTo(exchangeBtnView.snp.top).offset(12)
            $0.bottom.equalTo(exchangeBtnView.snp.bottom).inset(12)
            $0.leading.equalTo(exchangeBtnView.snp.leading).offset(20)
            $0.trailing.equalTo(exchangeBtnView.snp.trailing).inset(20)
        }
        profileView.snp.makeConstraints {
            $0.top.equalTo(categoryScrollView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constant.height * 72)
        }
        profileImageView.snp.makeConstraints {
            $0.centerY.equalTo(profileView)
            $0.leading.equalTo(profileView.snp.leading).offset(16)
            $0.width.equalTo(Constant.width * 40)
            $0.height.equalTo(Constant.height * 40)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.top.equalTo(profileView.snp.top).offset(20)
        }
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.bottom.equalTo(profileView.snp.bottom).inset(20)
        }
        titleTextField.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(profileView.snp.bottom).offset(16)
            $0.bottom.equalTo(profileView.snp.bottom).offset(40)
        }
        contentTextField.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.top.equalTo(titleTextField.snp.bottom).offset(16)
        }
        addImageView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        
    }
    // MARK: - Objc
    @objc
    func closeBtnTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc
    func postTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    var allFlag = 0
    var noticeFlag = 0
    var promotionFlag = 0
    var internationalFlag = 0
    var exchangeFlag = 0
    @objc
    func allBtnTap(_ sender: UITapGestureRecognizer) {
        if allFlag == 0 { // 눌린 상태면
            allBtnView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            allBtnLabel.textColor = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
            allFlag = 1
        } else if allFlag == 1 {
            allBtnView.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
            allBtnLabel.textColor = .white
            allFlag = 0
        }
    }
    @objc
    func noticeBtnTap(_ sender: UITapGestureRecognizer) {
        if noticeFlag == 0 { // 안눌린 상태면
            noticeBtnView.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
            noticeBtnLabel.textColor = .white
            noticeFlag = 1
        } else if noticeFlag == 1 { // 눌린 상태
            noticeBtnView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            noticeBtnLabel.textColor = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
            noticeFlag = 0
        }
    }
    @objc
    func promotionBtnTap(_ sender: UITapGestureRecognizer) {
        if promotionFlag == 0 { // 안눌린 상태면
            promotionBtnView.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
            promotionBtnLabel.textColor = .white
            promotionFlag = 1
        } else if promotionFlag == 1 { // 눌린 상태
            promotionBtnView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            promotionBtnLabel.textColor = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
            promotionFlag = 0
        }
    }
    @objc
    func internationalBtnTap(_ sender: UITapGestureRecognizer) {
        if internationalFlag == 0 { // 안눌린 상태면
            internationalBtnView.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
            internationalBtnLabel.textColor = .white
            internationalFlag = 1
        } else if internationalFlag == 1 { // 눌린 상태
            internationalBtnView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            internationalBtnLabel.textColor = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
            internationalFlag = 0
        }
    }
    @objc
    func exchangeBtnTap(_ sender: UITapGestureRecognizer) {
        if exchangeFlag == 0 { // 안눌린 상태면
            exchangeBtnView.backgroundColor = UIColor(red: 0.51, green: 0.33, blue: 1.0, alpha: 1.0)
            exchangeBtnLabel.textColor = .white
            exchangeFlag = 1
        } else if exchangeFlag == 1 { // 눌린 상태
            exchangeBtnView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            exchangeBtnLabel.textColor = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
            exchangeFlag = 0
        }
    }
    
    @objc
    func addImageBtnTap(_ sender: UITapGestureRecognizer) {
        print("1")
        let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            present(imagePickerController, animated: true, completion: nil)
  }
}

extension WritePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                // 선택한 이미지를 사용할 수 있습니다.
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
}
