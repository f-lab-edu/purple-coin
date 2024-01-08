//
//  MarketViewController.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2023/12/22.
//

import UIKit

class MarketViewController: UIViewController {
    
    let marketView = MarketView()
    
    override func loadView() {
        view = marketView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        getMarketCode()
    }
    
    func setTableView() {
        marketView.coinTableView.register(CoinTableViewCell.self, forCellReuseIdentifier: "cell")
        marketView.coinTableView.delegate = self
        marketView.coinTableView.dataSource = self
        marketView.coinTableView.reloadData()
    }
    
    func getMarketCode() {
        APIService().getKRWMarketData { result in
            print(result)
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 * ScreenFigure.VRatioValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CoinTableViewCell(style: CoinTableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.cellTapAction = { [weak self] in
            self?.cellTapAction(index: indexPath.row)
        }
        return cell
    }
    
    func cellTapAction(index: Int) {
        let vc = DetailCoinViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
