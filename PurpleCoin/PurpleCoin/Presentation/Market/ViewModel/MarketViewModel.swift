//
//  MarketViewModel.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/08.
//

import Foundation

final class MarketViewModel {
    var marketData: [MarketData]?
    var allMarketCode: [MarketCode]?

    func getMarketData(completion: @escaping(() -> Void)) {
        getKRWMarketData { result in
            switch result {
            case .success(let data):
                self.marketData = data
                completion()
            case .failure(let error):
                completion()
            }
        }
    }
    func getAllMarketCode(completion: @escaping ((Bool) -> Void)) {
        APIService().getAllMarketCode { result in
            switch result {
            case .success(let data):
                self.allMarketCode = data
                completion(true)
            case .failure(let failure):
                completion(false)
            }
        }
    }
}

extension MarketViewModel {
    
    // KRW 코인 정보 가져오기
    func getKRWMarketData(completion: @escaping (Result<[MarketData], Error>) -> Void) {
        APIService().getAllMarketCode { result in
            switch result {
            case.success(let data):
                let marketCodes = self.sortingMarketCode(markets: data)
                APIService().getMarketData(marketCodes: marketCodes, completion: completion)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //KRW 코인 가져오기
    func sortingMarketCode(markets: [MarketCode]) -> String{
        let KRWMarkets = markets.filter { market in
            market.market.contains("KRW-")
        }.map { $0.market }.joined(separator: ", ")
        return KRWMarkets
    }
}
