//
//  HotPlaceViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/22.
//

import UIKit
import Alamofire
import SnapKit
import Then

class HotPlaceViewController: UIViewController, UITextFieldDelegate, HotPlaceHeaderViewDelegate {

    let getPlace = HotPlace()
    var places: [HotPlaceResponse] = []
    let cell = HotPlaceTableViewCell()
    let headerView = HotPlaceHeaderView()
    var likedPlaces: [String] = []
    var countLike: Int = 0
    var height = 0
    var data = [String]()
    var filteredData = [HotPlaceResponse]()
    var filtered = false

    private let titleView = UIView().then {
        $0.backgroundColor = .white
    }

    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo-small")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let titleLabel = UILabel().then {
        $0.text = "Hot Place"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-Bold", size: 20)
    }

    let hotPlaceTableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.showsVerticalScrollIndicator = false
        $0.register(HotPlaceTableViewCell.self, forCellReuseIdentifier: HotPlaceTableViewCell.cellIdentifier)
        $0.backgroundColor = .clear
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(updateCountLike(_:)), name: Notification.Name("CountLikeUpdate"), object: nil)
        headerView.sortByDistanceBtn.addTarget(self, action: #selector(sortByDistanceBtnTapped(_:)), for: .touchUpInside)
        headerView.sortByRankBtn.addTarget(self, action: #selector(sortByRankBtnTapped(_:)), for: .touchUpInside)
        hotPlaceTableView.delegate = self
        hotPlaceTableView.dataSource = self
        headerView.delegate = self
        setUpView()
        setUpConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        headerView.sortByDistanceBtn.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        headerView.sortByDistanceBtn.setTitleColor(UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1), for: .normal)
        headerView.sortByRankBtn.backgroundColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
        headerView.sortByRankBtn.setTitleColor(UIColor.white, for: .normal)

        getPlace.getSortedByLike { places in
            self.places = places
            DispatchQueue.main.async {
                self.hotPlaceTableView.reloadData()
            }
        }

        let memberId = UserDefaults.standard.integer(forKey: "memberId")
            getPlace.getLikedPlace(memberId: memberId) { places in
                self.likedPlaces = places
                self.hotPlaceTableView.reloadData()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        height = Int(headerView.intrinsicContentSize.height)
    }

    func setUpView() {
        [titleView, headerView, hotPlaceTableView].forEach {
            view.addSubview($0)
        }
        [titleLabel, logoImageView].forEach {
            titleView.addSubview($0)
        }
        self.hotPlaceTableView.separatorStyle = .none
        self.hotPlaceTableView.separatorInset = UIEdgeInsets.zero
        self.hotPlaceTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        // MARK: 테이블뷰 헤더 간격 없앰
        if #available(iOS 15.0, *) {
            hotPlaceTableView.sectionHeaderTopPadding = 0
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
        hotPlaceTableView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc func updateCountLike(_ notification: Notification) {
        if let count = notification.object as? Int {
            self.countLike = count
            hotPlaceTableView.reloadData()
        }
    }

    @objc
    func sortByRankBtnTapped(_ sender: UIButton) {
        headerView.sortByDistanceBtn.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        headerView.sortByDistanceBtn.setTitleColor(UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1), for: .normal)
        headerView.sortByRankBtn.backgroundColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
        headerView.sortByRankBtn.setTitleColor(UIColor.white, for: .normal)
        getPlace.getSortedByLike { places in
            self.places = places
            DispatchQueue.main.async {
                self.hotPlaceTableView.reloadData()
            }
        }
    }

    @objc
    func sortByDistanceBtnTapped(_ sender: UIButton) {
        headerView.sortByRankBtn.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        headerView.sortByRankBtn.setTitleColor(UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1), for: .normal)
        headerView.sortByDistanceBtn.backgroundColor = UIColor(red: 0.514, green: 0.329, blue: 1, alpha: 1)
        headerView.sortByDistanceBtn.setTitleColor(UIColor.white, for: .normal)
        getPlace.getSortedByDistance { places in
            self.places = places
            DispatchQueue.main.async {
                self.hotPlaceTableView.reloadData()
            }
        }
    }

    func searchBtnTapped2() {
        headerView.searchTextField.resignFirstResponder() // 검색 버튼을 누를 때 키보드 닫음
        filterData(with: headerView.searchTextField.text)
    }

    func filteredText(_ query: String) {
        filteredData = places.filter { $0.placeName.lowercased().contains(query.lowercased()) }
        hotPlaceTableView.reloadData()
    }

    func searchTextFieldChanged(_ text: String) {
        filterData(with: headerView.searchTextField.text)
    }

    func filterData(with searchText: String?) {
        if let search = searchText, !search.isEmpty {
            filteredData = places.filter { $0.placeName.lowercased().hasPrefix(search.lowercased()) }
        } else {
            filteredData = places
        }
        hotPlaceTableView.reloadData()
    }

    @objc func likeButtonTapped(_ sender: UIButton) {
        let memberId = UserDefaults.standard.integer(forKey: "memberId")
        let place: HotPlaceResponse
        if headerView.searchTextField.text?.isEmpty ?? true {
            place = places[sender.tag]
        } else if !filteredData.isEmpty {
            place = filteredData[sender.tag]
        } else {
            return
        }
        if likedPlaces.contains(place.placeName) {
            getPlace.decreaseLike(placeName: place.placeName, memberId: memberId) { success in
                if success {
                    self.likedPlaces.remove(at: self.likedPlaces.firstIndex(of: place.placeName)!)
                    DispatchQueue.main.async {
                        sender.setImage(UIImage(named: "heart-off"), for: .normal)
                        self.updateLikeCount(placeName: place.placeName, decrease: true)
                    }
                }
            }
        } else {
            getPlace.increaseLike(placeName: place.placeName, memberId: memberId) { success in
                if success {
                    self.likedPlaces.append(place.placeName)
                    DispatchQueue.main.async {
                        sender.setImage(UIImage(named: "heart-on"), for: .normal)
                        self.updateLikeCount(placeName: place.placeName, decrease: false)
                    }
                }
            }
        }
    }

    func updateLikeCount(placeName: String, decrease: Bool) {
        if let placeIndex = places.firstIndex(where: { $0.placeName == placeName }) {
            if decrease {
                places[placeIndex].hitCount -= 1
            } else {
                places[placeIndex].hitCount += 1
            }
            hotPlaceTableView.reloadData()
        }
        if let filteredIndex = filteredData.firstIndex(where: { $0.placeName == placeName }) {
            if decrease {
                filteredData[filteredIndex].hitCount -= 1
            } else {
                filteredData[filteredIndex].hitCount += 1
            }
        }
    }
}

extension HotPlaceViewController: UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if headerView.searchTextField.text?.isEmpty ?? true {
            return places.count // 검색어가 비어있을 때는 모든 데이터를 표시
        } else if !filteredData.isEmpty {
            return filteredData.count // 검색 결과가 있을 때는 필터링된 데이터를 표시
        } else {
            return 1 // 검색 결과가 없을 때는 빈 데이터를 표시하는 셀 1개를 반환
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HotPlaceTableViewCell.cellIdentifier) as? HotPlaceTableViewCell else {
            return UITableViewCell()
        }
        if headerView.searchTextField.text?.isEmpty ?? true {
            // 검색어가 비어있을 때는 모든 데이터를 표시하는 셀 반환
            let place = places[indexPath.row]
            cell.restaurantName = place.placeName
            cell.restaurantNameLabel.text = cell.restaurantName
            cell.kmLabel.text = place.distance
            cell.numberLabel.text = "\(indexPath.row + 1)"
            countLike = place.hitCount
            cell.countHeartLabel.text = "\(countLike)"
            cell.selectedPlace = place.placeName
            cell.cellDelegate = self
            cell.backgroundColor = UIColor.clear
            cell.clipsToBounds = true

            // 좋아요 버튼 처리
            let isLiked = likedPlaces.contains(place.placeName)
            let buttonImage = isLiked ? UIImage(named: "heart-on") : UIImage(named: "heart-off")
            cell.heartBtn.setImage(buttonImage, for: .normal)
            cell.heartBtn.tag = indexPath.row
            cell.heartBtn.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)

            return cell
        } else if filteredData.isEmpty {
            // 검색 결과가 없을 때는 빈 데이터를 표시하는 셀 반환
            let emptyCell = UITableViewCell(style: .default, reuseIdentifier: nil)
            return emptyCell
        } else {
            // 검색 결과가 있을 때는 필터링된 데이터를 표시하는 셀 반환
            let place = filteredData[indexPath.row]
            cell.restaurantName = place.placeName
            cell.restaurantNameLabel.text = cell.restaurantName
            cell.kmLabel.text = place.distance
            cell.numberLabel.text = "\(indexPath.row + 1)"
            countLike = place.hitCount
            cell.countHeartLabel.text = "\(countLike)"
            cell.selectedPlace = place.placeName
            cell.cellDelegate = self
            cell.backgroundColor = UIColor.clear
            cell.clipsToBounds = true

            // 좋아요 버튼 처리
            let isLiked = likedPlaces.contains(place.placeName)
            let buttonImage = isLiked ? UIImage(named: "heart-on") : UIImage(named: "heart-off")
            cell.heartBtn.setImage(buttonImage, for: .normal)
            cell.heartBtn.tag = indexPath.row
            cell.heartBtn.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)

            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        let popUpView = DetailPlaceViewController()
        if headerView.searchTextField.text?.isEmpty ?? true {
            // 검색어가 비어있을 때는 모든 데이터를 표시하는 셀 반환
            let place = places[indexPath.row]
            popUpView.numberLabel.text = "\(indexPath.row + 1)"
            popUpView.restaurantName = place.placeName
            popUpView.distance = place.distance
            popUpView.heartCountLabel.text = "\(place.hitCount)"
            popUpView.navigationUrl = place.directionUrl
            popUpView.roadMapUrl = place.roadViewUrl
            popUpView.modalPresentationStyle = .overFullScreen
            popUpView.modalTransitionStyle = .crossDissolve
            self.present(popUpView, animated: true)
        } else {
            // 검색 결과가 있을 때는 필터링된 데이터를 표시하는 셀 반환
            let place = filteredData[indexPath.row]
            popUpView.numberLabel.text = "\(indexPath.row + 1)"
            popUpView.restaurantName = place.placeName
            popUpView.distance = place.distance
            popUpView.heartCountLabel.text = "\(place.hitCount)"
            popUpView.navigationUrl = place.directionUrl
            popUpView.roadMapUrl = place.roadViewUrl
            popUpView.modalPresentationStyle = .overFullScreen
            popUpView.modalTransitionStyle = .crossDissolve
            self.present(popUpView, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(height)
    }
}
