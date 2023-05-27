//
//  SideModalViewController.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/27.
//

import UIKit

class SideModalViewController: UIViewController {
    // MARK: - Properties

     // 선택한 셀의 인덱스를 저장할 변수

    let items = ["Ajou Campus Life", "Accademic Affairs", "Student Portal", "Immigration Guide", "Life in Korea", "Appendix"]
    let cell = modalTableViewCell()
    let tableView = UITableView()
    let ajouGuide = AjouGuideViewController()
    var overlayView: UIView!
    
    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo-small")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        overlayView = UIView(frame: view.bounds)
        view.addSubview(overlayView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(overlayTapped))
                overlayView.addGestureRecognizer(tapGesture)
        setUpView()
        setUpConstraints()
    }
    
    // MARK: - Helper

    func setUpView() {
        [logoImageView, tableView].forEach {
            view.addSubview($0)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(modalTableViewCell.self, forCellReuseIdentifier: modalTableViewCell.cellIdentifier)
    }
    
    func setUpConstraints() {
        logoImageView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.centerX).multipliedBy(0.43)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.width.equalTo(Constant.width * 31)
            $0.height.equalTo(Constant.height * 33)
            
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(64)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(250)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(15)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).dividedBy(2).inset(15)
        }
    }
    
    func modalAnimation(){
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }) { (completed) in
            if completed {
                self.ajouGuide.blurView.effect = nil
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    // MARK: - objc
    
    @objc func overlayTapped() {
            // 오버레이 뷰를 터치했을 때 모달을 닫고 원래 화면으로 돌아가도록 애니메이션 적용
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }) { (completed) in
                if completed {
                    self.ajouGuide.blurView.effect = nil
                    self.dismiss(animated: false, completion: nil)
                }
            }
        }
    
}
var selectedCellIndex: IndexPath?

extension SideModalViewController: UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: modalTableViewCell.cellIdentifier) as? modalTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.nameLabel.text = items[indexPath.row]
                
        if indexPath == selectedCellIndex {
                    cell.baseView.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
                    cell.nameLabel.textColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
                } else {
                    cell.baseView.backgroundColor = .white
                    cell.nameLabel.textColor = UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1)
                }
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 48
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCellIndex = indexPath
        self.tableView.reloadData()

        if let cell = tableView.cellForRow(at: indexPath) as? modalTableViewCell {
            cell.baseView.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1) // 원하는 색상으로 변경
            cell.nameLabel.textColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1) // 원하는 색상으로 변경

        }
        
            let selectedItem = items[indexPath.row]
            print("Selected item: \(selectedItem)")
            modalAnimation()
        }
    
}
