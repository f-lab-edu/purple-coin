//
//  Formatter.swift
//  PurpleCoin
//
//  Created by 강재혁 on 2024/01/09.
//

import Foundation

class Formatter {
    
    // 숫자 포맷 999999.0 -> 999,999
    static func formatNumberWithCustomRules(for number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let absoluteValue = abs(number)
        let isInteger = number.truncatingRemainder(dividingBy: 1) == 0
        
        if isInteger && absoluteValue >= 100 { //세자리 수 이상인 정수 -> 그대로 표현
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
        } else if isInteger && absoluteValue < 10 {//세자리 수 이하인 정수 -> 소수2자리 붙여서 표현
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            if let formattedString = formatter.string(from: NSNumber(value: number)) {
                return formattedString
            }
        } else {
            if String(number).split(separator: ".").last?.count ?? 0 <= 1 { // 실수인데 소수점이 한자리인 경우 -> 소수점 두자리로 표현
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
}
