//
//  SignUpViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/03/14.
//

import SnapKit
import Then
import UIKit
import SwiftUI

class SignUpViewController: UIViewController {
    //MARK: - Properties

    lazy var titleLabel = UILabel().then {
        $0.text = "Confirm Your \nAjou University Email"
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        $0.numberOfLines = 2
    }
    
    lazy var emailLabel = UILabel().then {
        $0.text = "Email"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var emailTextField = UITextField().then {
        $0.layer.cornerRadius = 10.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    lazy var confirmBtn = UIButton().then {
        $0.setTitle("Confirm", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
    }
    
    lazy var explainLabel = UILabel().then {
        $0.text = "When your Ajou University email verification is complete,\nwe will send you a verification code via your email."
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setUpView()
        setUpConstraints()
    }
    
    //MARK: - Helper
    func setUpView() {
        [titleLabel,emailLabel,emailTextField,confirmBtn,explainLabel].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(166)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 290)
            $0.height.equalTo(Constant.height * 80)
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(35)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 126)
            $0.height.equalTo(Constant.height * 22)
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(57)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        confirmBtn.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(33)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Constant.width * 315)
            $0.height.equalTo(Constant.height * 52)
        }
        explainLabel.snp.makeConstraints {
            $0.top.equalTo(confirmBtn.snp.bottom).offset(18)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 320)
            $0.height.equalTo(Constant.height * 30)
        }
    }
}

//MARK: - SwiftUI

struct MyViewController_PreViews: PreviewProvider {
static var previews: some View {
    SignUpViewController().toPreview() //원하는 VC를 여기다 입력하면 된다.
}
}
extension UIViewController {
private struct Preview: UIViewControllerRepresentable {
        let SignUpViewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return SignUpViewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

func toPreview() -> some View {
    Preview(SignUpViewController: self)
}
}
