//
//  WritePostViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/11/08.
//

import UIKit

class WritePostViewController: UIViewController {

    private let titleView = UIView().then {
        $0.backgroundColor = .white
    }

    private let titleLabel = UILabel().then {
        $0.text = "Create new post"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        setUpView()
        setUpConstraints()
    }

    func setUpView() {
        [titleView, titleLabel].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
        titleView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constant.height * 115)
        }
    }
}
