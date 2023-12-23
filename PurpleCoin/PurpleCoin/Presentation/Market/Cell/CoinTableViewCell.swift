//
//  CoinTableViewCell.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2023/12/24.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    
    private enum Font {
        static let defaultLabelFont = PurpleCoinFont.font(type: .medium, size: 12)
        static let smallLabelFont = PurpleCoinFont.font(type: .medium, size: 10)
    }
    // 코인 이름 - 한국 
    let krwCoinNameLabel: UILabel = {
        let label = UILabel()
        label.text = "도지코인"
        label.textColor = .white
        label.font = Font.defaultLabelFont
        return label
    }()
    // 코인 이름 - 한국
    let englishCoinNameLabel: UILabel = {
        let label = UILabel()
        label.text = "DOGE/KRW"
        label.textColor = PurpleCoinColor.gray
        label.font = Font.smallLabelFont
        return label
    }()
    // 현재가
    let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "135"
        label.textColor = .white
        label.font = Font.defaultLabelFont
        return label
    }()
    // 전일대비 - 퍼센트
    let dtdPercentageLabel: UILabel = {
        let label = UILabel()
        label.text = "11.89"
        label.textColor = .white
        label.font = Font.defaultLabelFont
        return label
    }()
    // 전일대비 - 가격
    let dtdPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "11.89"
        label.textColor = .white
        label.font = Font.smallLabelFont
        return label
    }()
    // 거래대금
    let transactionPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "316,101백만"
        label.textColor = .white
        label.font = Font.defaultLabelFont
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = PurpleCoinColor.darkPointColor
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MAKR: Layout
extension CoinTableViewCell {
    func setLayout() {
        [krwCoinNameLabel, englishCoinNameLabel, currentPriceLabel, dtdPercentageLabel, dtdPriceLabel, transactionPriceLabel].forEach {
            contentView.addSubview($0)
        }
        krwCoinNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10 * ScreenFigure.VRatioValue)
            $0.left.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
        }
        englishCoinNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
            $0.bottom.equalToSuperview().inset(10 * ScreenFigure.VRatioValue)
        }
        currentPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(krwCoinNameLabel)
            $0.right.equalToSuperview().inset(150 * ScreenFigure.HRatioValue)
        }
        dtdPercentageLabel.snp.makeConstraints {
            $0.centerY.equalTo(krwCoinNameLabel)
            $0.right.equalToSuperview().inset(92 * ScreenFigure.HRatioValue)
        }
        dtdPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(englishCoinNameLabel)
            $0.right.equalTo(dtdPercentageLabel)
        }
        transactionPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(krwCoinNameLabel)
            $0.right.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
        }
    }
}
