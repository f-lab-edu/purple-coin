//
//  API.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/08.
//

import Foundation
import Moya

/// OAuth 인증 API 설정
enum API {
    // 전체 마켓 코드 가져오기
    case getAllMarketCode
    case getMarketInfo(marketCodes: String)
}

extension API: TargetType {
    
    var baseURL: URL {
        return URL(string: NetworkConfig.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getAllMarketCode:
            return "/market/all"
        case .getMarketInfo:
            return "/ticker"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllMarketCode,
             .getMarketInfo:
            return .get
        }
    }
    
    var task: Moya.Task {
        let parameter: [String: Any] = self.parameter ?? [:]
        switch self {
        case .getMarketInfo:
            return .requestParameters(parameters: parameter, encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/x-www-form-urlencoded"]
    }
    
    var parameter: [String: Any]? {
        switch self {
        case .getMarketInfo(marketCodes: let market):
            return [
                "markets": market
            ]
        default:
            return nil
        }
    }
}
