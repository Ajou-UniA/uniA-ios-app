//
//  FeedViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/11/08.
//

import UIKit
import Alamofire
import SnapKit
import Then

class FeedViewController: UIViewController {

    var customTabBarController: UITabBarController?

    private let titleView = UIView().then {
        $0.backgroundColor = .white
    }

    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo-small")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let titleLabel = UILabel().then {
        $0.text = "Community"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 20)
    }

    let addPostBtn = UIButton().then {
        $0.backgroundColor = UIColor(red: 0.856, green: 0.746, blue: 1, alpha: 1)
        $0.setImage(UIImage(named: "plus"), for: .normal)
        $0.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 14, weight: .medium), forImageIn: .normal)
        $0.layer.cornerRadius = 10
    }

    let moveToPostViewBtn = UIButton().then {
        $0.backgroundColor = UIColor(red: 0.856, green: 0.746, blue: 1, alpha: 1)
        $0.setTitle("MoveToPostView", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 14, weight: .medium), forImageIn: .normal)
        $0.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addPostBtn.addTarget(self, action: #selector(addPostBtnTapped), for: .touchUpInside)
        moveToPostViewBtn.addTarget(self, action: #selector(moveToPostViewBtnTapped), for: .touchUpInside)
        setUpView()
        setUpConstraints()
    }

    func setUpView() {
        [titleView, addPostBtn, moveToPostViewBtn].forEach {
            view.addSubview($0)
        }
        [titleLabel, logoImageView].forEach {
            titleView.addSubview($0)
        }
    }

    func setUpConstraints() {
        titleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constant.height * 115)
        }
        logoImageView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.bottom.lessThanOrEqualToSuperview().inset(10) // 20
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(20)
            $0.centerY.equalTo(logoImageView)
        }
        // 가로길이에 맞추어 정사각형 만들기
        addPostBtn.heightAnchor.constraint(equalTo: addPostBtn.widthAnchor, multiplier: 1.0/1.0).isActive = true
        addPostBtn.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(40) //21
            $0.width.equalTo(Constant.width * 52)
        }
        moveToPostViewBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(Constant.height * 52)
            $0.width.equalTo(Constant.width * 200)
        }
    }

    @objc
    func addPostBtnTapped() {
        let writePostViewController = WritePostViewController()
        writePostViewController.modalPresentationStyle = .overFullScreen
        writePostViewController.modalTransitionStyle = .crossDissolve
        self.present(writePostViewController, animated: true)
    }

    @objc
    func moveToPostViewBtnTapped() {
        let postViewController = PostViewController()
        postViewController.modalPresentationStyle = .overFullScreen
        postViewController.modalTransitionStyle = .crossDissolve
        self.present(postViewController, animated: true)
    }
}
