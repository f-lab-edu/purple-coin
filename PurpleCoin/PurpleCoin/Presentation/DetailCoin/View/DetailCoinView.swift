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
        static let priceLabelFont = PurpleCoinFont.font(type: .regular, size: 16)
        static let defaultFont = PurpleCoinFont.font(type: .regular, size: 12)
    }
    
    private enum Metric {
        static let backButtonSize = CGSize(width: 30 * ScreenFigure.VRatioValue, height: 30 * ScreenFigure.VRatioValue)
        static let intrestButtonSize = CGSize(width: 20 * ScreenFigure.VRatioValue, height: 20 * ScreenFigure.VRatioValue)
    }
    
    //MARK: topSection
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = PurpleCoinColor.pointColor
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
    
    //MARK: coinInformationSection
    let coinInformationView: UIView = {
        let view = UIView()
        view.backgroundColor = PurpleCoinColor.pointColor
        return view
    }()
    let coinPriceLabel: UILabel = {
        let label = UILabel()
        label.font = Font.priceLabelFont
        return label
    }()
    let coinDTDLabel: UILabel = {
        let label = UILabel()
        label.font = Font.priceLabelFont
        return label
    }()
    
    //MARK: chartSection
    let chartView: UIView = {
        let view = UIView()
        return view
    }()
    
    //MARK: orderBookSection
    let orderBookTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = PurpleCoinColor.darkPointColor
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
        tableView.bounces = false
        return tableView
    }()
    
    //MARK: orderSection
//    let orderView: UIView = {
//        let view = UIView()
//        return view
//    }()
//    let orderTitleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "매수/매도"
//        label.font = Font.defaultFont
//        return label
//    }()
//    let designatedButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("지정", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = Font.defaultFont
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 1
//        return button
//    }()
//    let marketButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("시장", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = Font.defaultFont
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 1
//        return button
//    }()
//    let reserveButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("예약", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = Font.defaultFont
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 1
//        return button
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Layout
extension DetailCoinView {
    func setLayout() {
        setTopView()
        setCoinInformationView()
        [topView, coinInformationView, chartView, orderBookTableView].forEach {
            addSubview($0)
        }
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(ScreenFigure.topViewHeight())
        }
        coinInformationView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        chartView.snp.makeConstraints {
            $0.top.equalTo(coinInformationView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        orderBookTableView.snp.makeConstraints {
            $0.height.equalTo(300 * ScreenFigure.VRatioValue)
            $0.bottom.left.right.equalToSuperview()
        }
    }
    
    func setTopView() {
        [backButton, topTitleLabel, interestButton].forEach {
            topView.addSubview($0)
        }
        backButton.snp.makeConstraints {
            $0.centerY.equalTo(topTitleLabel)
            $0.left.equalToSuperview().inset(7 * ScreenFigure.HRatioValue)
            $0.size.equalTo(Metric.backButtonSize)
        }
        topTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(62 - ScreenFigure.notchHeight())
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(25 * ScreenFigure.VRatioValue)
        }
        interestButton.snp.makeConstraints {
            $0.centerY.equalTo(topTitleLabel)
            $0.right.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
            $0.size.equalTo(Metric.intrestButtonSize)
        }
    }
    
    func setCoinInformationView() {
        [coinPriceLabel, coinDTDLabel].forEach {
            coinInformationView.addSubview($0)
        }
        coinPriceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10 * ScreenFigure.VRatioValue)
            $0.left.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
        }
        coinDTDLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(12 * ScreenFigure.HRatioValue)
            $0.top.equalTo(coinPriceLabel.snp.bottom).offset(4 * ScreenFigure.VRatioValue)
            $0.bottom.equalToSuperview().inset(10 * ScreenFigure.VRatioValue)
        }
    }
}

//MARK: SetAttributes
extension DetailCoinView {
    func setAttributes(krwName: String, marketData: MarketData?) {
        guard let marketData = marketData else {
            return
        }
        let formattedData = formattData()
        topTitleLabel.text = krwName
        coinPriceLabel.text = formattedData.currentPrice
        var arrow = ""
        var color = UIColor.white
        switch marketData.change {
        case "EVEN":
            break
        case "RISE":
            arrow = "▲"
            color = PurpleCoinColor.red
        case "FALL":
            arrow = "▼"
            color = PurpleCoinColor.blue
        default:
            break
        }
        coinDTDLabel.text = "\(formattedData.dtdPercent) \(arrow)\(formattedData.dtdPrice)"
        coinPriceLabel.textColor = color
        coinDTDLabel.textColor = color
        
        func formattData() -> (currentPrice: String, dtdPercent: String, dtdPrice: String) {
            return (
                currentPrice: Formatter.formatNumberWithCustomRules(for: marketData.tradePrice),
                dtdPercent: Formatter.truncateToTwoDecimals(for: marketData.signedChangeRate * 100) + "%",
                dtdPrice: Formatter.formatNumberWithCustomRules(for: marketData.signedChangePrice)
            )
        }
    }
}
