//
//  AjouCampusMapViewController.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/07.
//

import UIKit
import SnapKit
import Then

class AjouCampusMapView: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let data = mapText

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = textCollectionView.frame.height
        return CGSize(width: 230, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextCollectionViewCell", for: indexPath) as? TextCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.textView.text = data[indexPath.item]
                return cell
    }
    
    let titleLabel = UILabel().then {
        $0.text = "Ajou Campus Map"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 20)
    }

    var imageView = UIImageView().then {
        $0.image = UIImage(named: "map")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let textCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .horizontal
            layout.sectionInset = .zero
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: "TextCollectionViewCell")
            collectionView.backgroundColor = .clear
            collectionView.showsHorizontalScrollIndicator = false
            return collectionView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textCollectionView.delegate = self
        textCollectionView.dataSource = self
        textCollectionView.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: "TextCollectionViewCell")
        setUpView()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    func setUpView() {
        [titleLabel, imageView, textCollectionView].forEach {
            addSubview($0)
        }
    }

    func setUpConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        textCollectionView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.height.equalTo(Constant.height * 350)
            $0.bottom.equalToSuperview().inset(38)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
