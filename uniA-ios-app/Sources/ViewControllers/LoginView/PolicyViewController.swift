//
//  PolicyViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/19.
//

import UIKit
import PDFKit

class PolicyViewController: UIViewController {
    // MARK: - Properties

    lazy var backBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "chevron_left"), for: .normal)
        $0.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
    lazy var titleLabel = UILabel().then {
        $0.text = "To access UniA's services, please agree to the terms and conditions."
        $0.textAlignment = .left
        $0.font = UIFont(name: "Urbanist-Bold", size: 30)
        $0.numberOfLines = 0
    }
    lazy var termLabel = UILabel().then {
        $0.text = "I agree and accept Terms of Use"
        $0.textAlignment = .left
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }
    lazy var policyLabel = UILabel().then {
        $0.text = "I agree and accept Privacy Policy"
        $0.textAlignment = .left
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }
    lazy var termView = UIView().then {
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(termViewTapped)))
    }
    lazy var policyView = UIView().then {
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(policyViewTapped)))
    }
    lazy var chevronRightView1 = UIImageView().then {
        $0.image = UIImage(named: "chevron_right")
    }
    lazy var chevronRightView2 = UIImageView().then {
        $0.image = UIImage(named: "chevron_right")
    }
    lazy var agreeBtn = UIButton().then {
        $0.setTitle("Agree and continue", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(agreeBtnTapped), for: .touchUpInside)
        $0.titleLabel?.font = UIFont(name: "Urbanist-SemiBold", size: 15)
    }
    lazy var circleBtn1 = UIButton().then {
        $0.setImage(UIImage(named: "circle"), for: .normal)
        $0.addTarget(self, action: #selector(circle1BtnTapped), for: .touchUpInside)
    }
    lazy var circleBtn2 = UIButton().then {
        $0.setImage(UIImage(named: "circle"), for: .normal)
        $0.addTarget(self, action: #selector(circle2BtnTapped), for: .touchUpInside)
    }

    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true

        changeLabelColor()
        setUpView()
        setUpConstraints()
    }
    // MARK: - Helper

    func setUpView() {
        [backBtn, titleLabel, circleBtn1, circleBtn2, termView, policyView, agreeBtn].forEach {
            view.addSubview($0)
        }
        [circleBtn1, chevronRightView1, termLabel].forEach { termView.addSubview($0) }
        [circleBtn2, chevronRightView2, policyLabel].forEach { policyView.addSubview($0) }
    }

    func setUpConstraints() {
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
            $0.width.equalTo(Constant.width * 24)
            $0.height.equalTo(backBtn.snp.width).multipliedBy(1.0/1.0)

        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backBtn.snp.bottom).offset(100)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(39)
        }
        circleBtn1.snp.makeConstraints {
            $0.centerY.equalTo(termView)
            $0.leading.equalTo(termView.snp.leading)
            $0.width.equalTo(Constant.width * 30)
            $0.height.equalTo(circleBtn1.snp.width).multipliedBy(1.0/1.0)

        }

        circleBtn2.snp.makeConstraints {
            $0.centerY.equalTo(policyView)
            $0.leading.equalTo(policyView.snp.leading)
            $0.width.equalTo(Constant.width * 30)
            $0.height.equalTo(circleBtn2.snp.width).multipliedBy(1.0/1.0)
        }
        termView.snp.makeConstraints {
            $0.top.equalTo(agreeBtn.snp.top).offset(-120)
            $0.bottom.equalTo(agreeBtn.snp.top).offset(-90)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(39)
        }
        policyView.snp.makeConstraints {
            $0.top.equalTo(agreeBtn.snp.top).offset(-70)
            $0.bottom.equalTo(agreeBtn.snp.top).offset(-40)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(39)
        }
        termLabel.snp.makeConstraints {
            $0.centerY.equalTo(termView)
            $0.leading.equalTo(circleBtn1.snp.trailing).offset(11)
        }
        policyLabel.snp.makeConstraints {
            $0.centerY.equalTo(policyView)
            $0.leading.equalTo(circleBtn2.snp.trailing).offset(11)
        }
        chevronRightView1.snp.makeConstraints {
            $0.centerY.equalTo(termView)
            $0.trailing.equalTo(termView.snp.trailing)
            $0.width.equalTo(Constant.width * 24)
            $0.height.equalTo(chevronRightView1.snp.width).multipliedBy(1.0/1.0)

        }
        chevronRightView2.snp.makeConstraints {
            $0.centerY.equalTo(policyView)
            $0.trailing.equalTo(policyView.snp.trailing)
            $0.width.equalTo(Constant.width * 24)
            $0.height.equalTo(chevronRightView2.snp.width).multipliedBy(1.0/1.0)
        }
        agreeBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(183)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(131)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(39)
        }
    }

    func changeLabelColor() {
        let termAttributedText = NSMutableAttributedString(string: termLabel.text ?? "")
        let termRange = (termLabel.text as NSString?)?.range(of: "Terms of Use")
        termAttributedText.addAttribute(.foregroundColor, value: UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1), range: termRange!)
        termLabel.attributedText = termAttributedText

        let policyAttributedText = NSMutableAttributedString(string: policyLabel.text ?? "")
        let policyRange = (policyLabel.text as NSString?)?.range(of: "Privacy Policy")
        policyAttributedText.addAttribute(.foregroundColor, value: UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1), range: policyRange!)
        policyLabel.attributedText = policyAttributedText
    }

    // MARK: - Objc

    @objc
    func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc
    func agreeBtnTapped() {
        if count == 2 {
            let confirmEmailViewController = ConfirmEmailViewController()
            navigationController?.pushViewController(confirmEmailViewController, animated: true)
        } else {
            return
        }
    }
    var pdfView: PDFView?
    var backButton: UIButton?

    @objc func termViewTapped() {
        pdfView = PDFView(frame: view.bounds)
        pdfView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(pdfView!)

        if let pdfURL = Bundle.main.url(forResource: "Terms&conditions", withExtension: "pdf") {
            if let pdfDocument = PDFDocument(url: pdfURL) {
                pdfView?.document = pdfDocument
                pdfView?.autoScales = true
                backButton = UIButton(type: .system)
                backButton?.setTitle("Back", for: .normal)
                backButton?.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
                view.addSubview(backButton!)
                backButton?.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
                    make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
                }
            }
        }
    }

    @objc func backButtonTapped() {
        backButton?.isHidden = true
        backButton?.removeFromSuperview()
        backButton = nil
        pdfView?.removeFromSuperview()
        pdfView = nil
    }

    @objc
    func policyViewTapped() {
        pdfView = PDFView(frame: view.bounds)
        pdfView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(pdfView!)

        if let pdfURL = Bundle.main.url(forResource: "Privacy_policy", withExtension: "pdf") {
            if let pdfDocument = PDFDocument(url: pdfURL) {
                pdfView?.document = pdfDocument
                pdfView?.autoScales = true
                backButton = UIButton(type: .system)
                backButton?.setTitle("Back", for: .normal)
                backButton?.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
                view.addSubview(backButton!)
                backButton?.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
                    make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
                }
            }
        }
    }
    var flag1 = 0
    var flag2 = 0
    var count = 0
    @objc func circle1BtnTapped() {
            if flag1 == 0 {
                circleBtn1.setImage(UIImage(named: "circle_selected"), for: .normal)
                count += 1
                flag1 = 1
            } else {
                circleBtn1.setImage(UIImage(named: "circle"), for: .normal)
                count -= 1
                flag1 = 0
            }
        }

    @objc func circle2BtnTapped() {
            if flag2 == 0 {
                circleBtn2.setImage(UIImage(named: "circle_selected"), for: .normal)
                count += 1
                flag2 = 1
            } else {
                circleBtn2.setImage(UIImage(named: "circle"), for: .normal)
                count -= 1
                flag2 = 0
            }
        }
}
