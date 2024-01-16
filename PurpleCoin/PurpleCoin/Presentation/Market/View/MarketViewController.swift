//
//  MarketViewController.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2023/12/22.
//

import UIKit

final class MarketViewController: UIViewController {
    
    let marketView = MarketView()
    let viewModel = MarketViewModel()
    
    override func loadView() {
        view = marketView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        viewModel.getKRWMarketData { err in
            if err == nil {
                self.marketView.coinTableView.reloadData()
            } else {
                
            }
        }
    }
    
    func setTableView() {
        marketView.coinTableView.register(CoinTableViewCell.self, forCellReuseIdentifier: "cell")
        marketView.coinTableView.delegate = self
        marketView.coinTableView.dataSource = self
    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 * ScreenFigure.VRatioValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.marketData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CoinTableViewCell(style: CoinTableViewCell.CellStyle.default, reuseIdentifier: "cell")
        guard let marketDatas = viewModel.marketData,
              let marketCodes = viewModel.allMarketCode
        else {
            return UITableViewCell()
        }
        let marketData = marketDatas[indexPath.row]
        let formattedData = formattData()
        cell.krwCoinNameLabel.text = formattedData.krwCoinName
        cell.englishCoinNameLabel.text = formattedData.englishCoinName
        cell.currentPriceLabel.text = formattedData.currentPrice
        cell.dtdPercentageLabel.text = formattedData.dtdPercentage
        cell.dtdPriceLabel.text = formattedData.dtdPrice
        cell.transactionPriceLabel.text = formattedData.transactionPrice
        setColorForPriceLabels(with: marketData.change)
        cell.cellTapAction = {
            cellTapAction(index: indexPath.row)
        }
        return cell
        
        // 전일대비 색상 변경
        func setColorForPriceLabels(with state: String) {
            var color = UIColor()
            switch state {
            case "EVEN":
                color = .white
            case "RISE":
                color = PurpleCoinColor.red
            case "FALL":
                color = PurpleCoinColor.blue
            default:
                break
            }
            [cell.currentPriceLabel, cell.dtdPriceLabel, cell.dtdPercentageLabel].forEach {
                $0.textColor = color
            }
        }
        
        // 데이터 포멧
        func formattData() -> (krwCoinName: String, englishCoinName: String, currentPrice: String, dtdPercentage: String, dtdPrice: String, transactionPrice: String) {
            return (
                krwCoinName: marketCodes.first {$0.market == marketData.market}?.koreanName ?? "??",
                englishCoinName: Formatter.convertEngCoinName(marketData.market),
                currentPrice: Formatter.formatNumberWithCustomRules(for: marketData.tradePrice),
                dtdPercentage: Formatter.truncateToTwoDecimals(for: marketData.signedChangeRate * 100) + "%",
                dtdPrice: Formatter.formatNumberWithCustomRules(for: marketData.signedChangePrice),
                transactionPrice: Formatter.formatToMillionUnit(for: marketData.accTradePrice24h)
            )
        }
        
        func cellTapAction(index: Int) {
            let vc = DetailCoinViewController(krwName: formattedData.krwCoinName, marketCode: marketData.market)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
