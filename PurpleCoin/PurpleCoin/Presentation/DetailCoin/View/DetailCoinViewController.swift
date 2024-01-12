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
        detailCoinView.orderBookTableView.reloadData()
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrderBookTableViewCell(style: OrderBookTableViewCell.CellStyle.default, reuseIdentifier: "cell")
        return cell
    }
}
