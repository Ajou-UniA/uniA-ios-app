//
//  DetailMapViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/18.
//

import UIKit
import SnapKit
import Then

class DetailMapViewController: UIViewController, UIGestureRecognizerDelegate {

    let scrollView = UIScrollView().then {
        $0.contentMode = .scaleAspectFit
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
    }

    let imageView = UIImageView().then {
        $0.image = UIImage(named: "map")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    lazy var backBtn = UIButton().then {
        $0.setImage(UIImage(named: "backBtn"), for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.3)
        backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        scrollView.delegate = self
        scrollView.zoomScale = 1.0
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0

        // Double tap gesture recognizer
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapOnScrollView))
        scrollView.addGestureRecognizer(doubleTapGesture)
        setUpView()
        setUpConstraints()
    }

    func setUpView() {
        self.view.addSubview(scrollView)
        [imageView, backBtn].forEach {
            scrollView.addSubview($0)
        }
    }

    func setUpConstraints() {
        scrollView.frame = view.bounds
        imageView.frame = scrollView.bounds
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        backBtn.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
        }
    }

    @objc
    func backBtnTapped() {
        self.dismiss(animated: true)
    }
}

extension DetailMapViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.zoomScale <= 1.0 {
//            scrollView.zoomScale = 1.0
//        }
//        if scrollView.zoomScale >= 6.0 {
//            scrollView.zoomScale = 6.0
//        }
//    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView.zoomScale <= scrollView.minimumZoomScale {
                scrollView.zoomScale = scrollView.minimumZoomScale
                backBtn.isHidden = false
            } else if scrollView.zoomScale >= scrollView.maximumZoomScale {
                scrollView.zoomScale = scrollView.maximumZoomScale
                backBtn.isHidden = true
            } else {
                backBtn.isHidden = scrollView.isZooming || scrollView.isZoomBouncing
            }
        }

    @objc func handleDoubleTapOnScrollView(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.backBtn.isHidden = self.scrollView.zoomScale > self.scrollView.minimumZoomScale
        }
    }
}
