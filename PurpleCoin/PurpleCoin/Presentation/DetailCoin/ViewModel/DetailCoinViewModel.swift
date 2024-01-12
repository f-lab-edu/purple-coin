//
//  DetailCoinViewModel.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2024/01/12.
//

import UIKit

final class DetailCoinViewModel {
    var marketData: MarketData?
    var orderBookData: OrderBook?
    
    func getMarketData(marketCode: String,  completion: @escaping (Result<[MarketData], Error>) -> Void) {
        APIService().getMarketData(marketCodes: marketCode) { result in
            switch result {
            case .success(let data):
                self.marketData = data[0]
                completion(result)
            case .failure(let err):
                print(err)
                self.marketData = nil
                completion(result)
            }
        }
    }
    
    func getOrderBookData(marketCode: String, completion: @escaping (Result<[OrderBook], Error>) -> Void) {
        APIService().getOrderBookDataa(marketCodes: marketCode, completion: { result in
            switch result {
            case .success(let data):
                self.orderBookData = data[0]
                completion(result)
            case .failure(_):
                completion(result)
            }
        })
    }
}
