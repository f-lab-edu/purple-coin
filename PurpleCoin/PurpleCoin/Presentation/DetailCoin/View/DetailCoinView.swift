//
//  DetailCoinView.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2023/12/22.
//

import UIKit

class DetailCoinView: UIView {
    
    private enum Font {
        static let topTitleLabelFont = PurpleCoinFont.font(type: .bold, size: 20)
    }
    
    //MARK: topSection
    let topView: UIView = {
        let view = UIView()
        return view
    }()
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        return button
    }()
    let topTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도지코인"
        label.textColor = .white
        label.font = Font.topTitleLabelFont
        return label
    }()
    let interestButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "star"), for: .normal)
        button.setImage(UIImage(named: "star_filled"), for: .selected)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Layout
extension DetailCoinView {
    func setLayout() {
        
    }
}
