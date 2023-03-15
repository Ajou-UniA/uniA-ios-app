//
//  CongratulationsViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/03/15.
//

import SnapKit
import Then
import UIKit
import SwiftUI

class CongratulationsViewController: UIViewController {
    //MARK: - Properties
    lazy var titleLabel = UILabel().then {
        $0.text = "Congratulations!"
        $0.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
    }
    
    lazy var imageView = UIImageView().then {
        $0.image = UIImage(named: "UniALogo")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var signInBtn = UIButton().then {
        $0.setTitle("Sign in", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
    }
    
    //MARK: - Lifecycles
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        signInBtn.addTarget(self, action: #selector(signInBtnTapped), for: .touchUpInside)

        setUpView()
        setUpConstraints()
    }
    
    //MARK: - Helper

    func setUpView() {
        [titleLabel,imageView,signInBtn].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(114)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 240)
            $0.height.equalTo(Constant.height * 33)
        }
        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(109)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 150)
            $0.height.equalTo(Constant.height * 220)
        }
        signInBtn.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(95)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 272)
            $0.height.equalTo(Constant.height * 52)
        }
    }
    @objc
    func signInBtnTapped() {
        self.navigationController?.popToRootViewController(animated: true)

    }
}
//MARK: - SwiftUI

struct MyViewController_PreViews: PreviewProvider {
static var previews: some View {
    CongratulationsViewController().toPreview() //원하는 VC를 여기다 입력하면 된다.
}
}
extension UIViewController {
private struct Preview: UIViewControllerRepresentable {
        let CongratulationsViewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return CongratulationsViewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

func toPreview() -> some View {
    Preview(CongratulationsViewController: self)
}
}

