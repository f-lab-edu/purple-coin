//
//  DetailCoinViewController.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2023/12/22.
//

import UIKit

class DetailCoinViewController: UIViewController {
    
    let detailCoinView = DetailCoinView()
    let viewModel = DetailCoinViewModel()
    var marketCode: String
    var krwName: String
    
    override func loadView() {
        super.loadView()
        view = detailCoinView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMarketData(marketCode: marketCode) { [self] _ in
            detailCoinView.setAttributes(krwName: krwName, marketData: viewModel.marketData)
            viewModel.getOrderBookData(marketCode: marketCode) { [self] _ in
                detailCoinView.orderBookTableView.reloadData()
            }
        }
        bindAction()
        setTableView()
    }
    
    init(krwName: String, marketCode: String) {
        self.krwName = krwName
        self.marketCode = marketCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTableView() {
        detailCoinView.orderBookTableView.register(OrderBookTableViewCell.self, forCellReuseIdentifier: "cell")
        detailCoinView.orderBookTableView.delegate = self
        detailCoinView.orderBookTableView.dataSource = self
    }
}

//MARK: BindAciton
extension DetailCoinViewController {
    func bindAction() {
        detailCoinView.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        detailCoinView.interestButton.addTarget(self, action: #selector(interestButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func interestButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
}

extension DetailCoinViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 * ScreenFigure.VRatioValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orderBookData?.orderbookUnits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrderBookTableViewCell(style: OrderBookTableViewCell.CellStyle.default, reuseIdentifier: "cell")
        guard let marketData = viewModel.marketData,
              let orderBookData = viewModel.orderBookData
        else {
            return UITableViewCell()
        }
        let orderBookUnit = orderBookData.orderbookUnits[indexPath.row]
        let formattedData = formattData()
        cell.priceLabel.text = formattedData.askPrice
        cell.amountLabel.text = formattedData.askSize
        cell.barView.snp.makeConstraints {
            $0.width.equalTo(ScreenFigure.bounds.width * orderBookUnit.askSize/orderBookData.totalAskSize)
        }
        setCellAttributes()
        return cell
        
        func formattData() -> (askPrice: String, dtdPercentage: String, askSize: String) {
            return (
                askPrice: Formatter.formatNumberWithCustomRules(for: orderBookUnit.askPrice),
                dtdPercentage: "%",
                askSize: Formatter.formatNumberWithCustomRules(for: orderBookUnit.askSize)
            )
        }
        
        func setCellAttributes() {
            var bgColor = UIColor.clear
            var labelColor = UIColor.clear
            var barColor = UIColor.clear
            if marketData.openingPrice < orderBookUnit.askPrice {
                bgColor = UIColor(red: 0.145, green: 0.067, blue: 0.227, alpha: 1)
                labelColor = PurpleCoinColor.blue
                barColor = .blue
            } else if marketData.openingPrice == orderBookUnit.askPrice {
                bgColor = UIColor(red: 0.145, green: 0.067, blue: 0.227, alpha: 1)
                labelColor = .white
                barColor = .blue
            } else if marketData.openingPrice > orderBookUnit.askPrice {
                bgColor = UIColor(red: 0.369, green: 0.043, blue: 0.02, alpha: 1)
                labelColor = PurpleCoinColor.red
                barColor = .red
            }
            cell.backgroundColor = bgColor
            cell.priceLabel.textColor = labelColor
            cell.percentageLabel.textColor = labelColor
            cell.barView.backgroundColor = barColor
        }
    }
    
}
