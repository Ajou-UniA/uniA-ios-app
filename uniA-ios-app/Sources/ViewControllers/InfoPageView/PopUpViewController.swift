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
    
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        
        setUpView()
        setUpConstraints()
    }
    //MARK: - Helper
    func setUpView() {
        [].forEach {
            view.addSubview($0)
        }
    }

    func setUpConstraints() {
    }
}
