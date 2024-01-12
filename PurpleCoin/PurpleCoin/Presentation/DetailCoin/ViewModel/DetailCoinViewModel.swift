//
//  DetailCoinViewModel.swift
//  PurpleCoin
//
//  Created by notegg_003 on 2024/01/12.
//

import UIKit

final class DetailCoinViewModel {
    var marketData: MarketData?
    
    func getMarketData(marketCode: String,  completion: @escaping (Result<[MarketData], Error>) -> Void) {
        APIService().getMarketData(marketCodes: marketCode) { result in
            switch result {
            case .success(let data):
                self.marketData = data[0]
                completion(result)
            case .failure(_):
                self.marketData = nil
                completion(result)
            }
        }
    }
}
