//
//  VerificationViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/03/14.
//

import SnapKit
import Then
import UIKit
import SwiftUI

class VerificationViewController: UIViewController {
    //MARK: - Properties

    lazy var titleLabel = UILabel().then {
        $0.text = "Verification Code"
        $0.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        $0.numberOfLines = 2
    }
    
    lazy var subtitleLabel = UILabel().then {
        $0.text = "Enter code that we have sent to your Ajou University \nemail."
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 13)
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
        [titleLabel,subtitleLabel].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(181)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 240)
            $0.height.equalTo(Constant.height * 35)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(22)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(37)
            $0.width.equalTo(Constant.width * 340)
            $0.height.equalTo(Constant.height * 40)
        }
    }
}
//MARK: - SwiftUI

struct MyViewController_PreViews: PreviewProvider {
static var previews: some View {
    VerificationViewController().toPreview() //원하는 VC를 여기다 입력하면 된다.
}
}
extension UIViewController {
private struct Preview: UIViewControllerRepresentable {
        let VerificationViewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return VerificationViewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

func toPreview() -> some View {
    Preview(VerificationViewController: self)
}
}
