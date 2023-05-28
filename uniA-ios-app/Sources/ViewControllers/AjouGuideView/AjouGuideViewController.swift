//
//  AjouGuideViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/20.
//

import UIKit


class AjouGuideViewController: UIViewController {
    // MARK: - Properties
    
    let overView = UIView()
    let blurView = UIVisualEffectView()
    let tableView = UITableView()
    let items = ["Ajou Campus Life", "Accademic Affairs", "Student Portal", "Immigration Guide", "Life in Korea", "Appendix"]

    private let titleView = UIView().then {
        $0.backgroundColor = .clear
    }
    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo-small")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let titleLabel = UILabel().then {
        $0.text = "Ajou Guide"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 20)
    }
    
    lazy var subtitleLabel = UILabel().then {
        $0.text = "Ajou Campus Life"
        $0.textAlignment = .left
        $0.font = UIFont(name: "Urbanist-Bold", size: 20)
        $0.textColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
    }
    lazy var listBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "listBtn"), for: .normal)
        $0.addTarget(self, action: #selector(listBtnTapped), for: .touchUpInside)
    }

    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        setUpView()
        setUpConstraints()
    }
    // MARK: - Helper
    
    func setUpView() {
        
        view.addSubview(overView)
        [titleView, subtitleLabel, tableView].forEach {
            overView.addSubview($0)
        }
        [titleLabel, logoImageView, listBtn].forEach {
            titleView.addSubview($0)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(AjouGuideTableViewCell.self, forCellReuseIdentifier: AjouGuideTableViewCell.cellIdentifier)
    }
    
    func setUpConstraints() {
        overView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
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
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.top.equalTo(titleView.snp.bottom).offset(33)
        }
        listBtn.snp.makeConstraints {
            $0.bottom.equalTo(titleView.snp.bottom).inset(22)
            $0.trailing.equalTo(titleView.snp.trailing).inset(20)
            $0.width.equalTo(Constant.width * 20)
            $0.height.equalTo(Constant.height * 17)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(32)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(100)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Objc

    @objc func listBtnTapped() {
        let modalViewController = SideModalViewController()
           modalViewController.didSelectItem = { [weak self] selectedItem in
               self?.subtitleLabel.text = selectedItem
           }
        presentSideModal(modalViewController, animated: true, completion: nil)
    }
}


extension UIViewController {
    func presentSideModal(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        viewControllerToPresent.modalPresentationStyle = .custom
        viewControllerToPresent.transitioningDelegate = self
        
        self.present(viewControllerToPresent, animated: flag) {
            completion?()
        }
        
        viewControllerToPresent.view.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        UIView.animate(withDuration: 0.3) {
        viewControllerToPresent.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        }
    }
}

extension UIViewController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideModalTransitionAnimator(isPresenting: true)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideModalTransitionAnimator(isPresenting: false)
    }
}

class SideModalTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let isPresenting: Bool

    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        if isPresenting {
            guard let toView = transitionContext.view(forKey: .to) else {
                transitionContext.completeTransition(false)
                return
            }

            containerView.addSubview(toView)

            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height

            toView.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)

            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toView.frame = CGRect(x: screenWidth * 0.5, y: 0, width: screenWidth, height: screenHeight)
            }) { (finished) in
                transitionContext.completeTransition(finished)
            }
        } else {
            guard let fromView = transitionContext.view(forKey: .from) else {
                transitionContext.completeTransition(false)
                return
            }

            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromView.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }) { (finished) in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(finished)
            }
        }
    }
}


extension AjouGuideViewController: UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AjouGuideTableViewCell.cellIdentifier) as? AjouGuideTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.nameLabel.text = items[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedItem = items[indexPath.row]
            print("Selected item: \(selectedItem)")
        
        let detailGuideViewController = DetailGuideViewController()
        detailGuideViewController.titleLabel.text = subtitleLabel.text
           navigationController?.pushViewController(detailGuideViewController, animated: true)
        }

}

