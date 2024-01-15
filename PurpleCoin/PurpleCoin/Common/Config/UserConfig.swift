//
//  UserConfig.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/15.
//

import Foundation

import Foundation

class UserConfig {
    static let shared = UserConfig()
    let userDefaults = UserDefaults()
    var intrestedCoins: [String] {
        get {
            let savedData = userDefaults.stringArray(forKey: "intrestedCoins") ?? []
            return savedData
        }
        set {
            userDefaults.set(newValue, forKey: "intrestedCoins")
            userDefaults.synchronize()
        }
    }
}
