//
//  Formatter.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/09.
//

import Foundation

final class Formatter {
    
    //소수점 두자리 끊기
    static func truncateToTwoDecimals(for number: Double) -> String {
        let truncatedString = String(format: "%.2f", number)
        return truncatedString
    }
    
    // 가격표시 포멧
    static func formatNumberWithCustomRules(for number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let absoluteValue = abs(number)
        let isInteger = number.truncatingRemainder(dividingBy: 1) == 0
        let isLargeInteger = absoluteValue >= 100
        let isSmallInteger = absoluteValue < 10
        let isOneDecimal = String(number).split(separator: ".").last?.count ?? 0 <= 1
        
        if isInteger {
            if isLargeInteger { // 3자리 수 이상인 정수 -> 그대로 표현
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 0
            } else if isSmallInteger { // 1자리 수 정수-> 뒤에 소수점(.00) 붙여서 표현
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
            }
        } else {
            if isOneDecimal { // 실수인데 소수점이 한자리인 경우 -> 소수점 두자리로 표현
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
            } else { // 실수인데 소수점이 두자리이상인 경우 -> 그대로 표현
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = Int.max
            }
        }
        
        if let formattedString = formatter.string(from: NSNumber(value: number)) {
            return formattedString
        } else {
            return "\(number)" // 포맷팅 실패 시, 기본 문자열 반환
        }
    }
    
    //백만 단위 포멧
    static func formatToMillionUnit(for number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let million = 1000000
        let dividedNumber = Int(Double(number) / Double(million))
        let formattedNumber = formatter.string(from: NSNumber(value: dividedNumber)) ?? "\(number)"
        
        return "\(formattedNumber)백만"
    }
    
    // KRW-CoinName ->  CoinName/KRW
    static func convertEngCoinName(_ name: String) -> String{
        let components = name.components(separatedBy: "-")
        if components.count == 2 {
            let convertedName = "\(components[1])/\(components[0])"
            return convertedName
        } else {
            return name
        }
    }
}
