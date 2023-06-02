//
//  TextCollectionViewCell.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/31.
//

import SnapKit
import Then
import UIKit

class TextCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "TextCollectionViewCell"
    
    let textView = UITextView().then {
        $0.isEditable = false
        $0.font = UIFont(name: "Urbanist-SemiBold", size: 14)
        $0.showsVerticalScrollIndicator = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        self.contentView.addSubview(textView)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.2  // Adjust the line spacing as desired
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "Urbanist-SemiBold", size: 14)!,
                .paragraphStyle: paragraphStyle
            ]
            textView.typingAttributes = attributes
    }
    
    func setUpConstraint() {
        textView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
        }
    }
}
