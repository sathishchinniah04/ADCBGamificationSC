//
//  Utility.swift
//  ADCBGamification
//
//  Created by SKY on 07/07/21.
//

import Foundation

class Utility {
    static func getRandonNo() -> String {
        return String("\(UUID())")
    }
    static func getTimeStamp()-> String {
        let d = Date()
        let df = DateFormatter()
        df.dateFormat = "YYMMDDHHmmss"
        let timeStamp = df.string(from: d)
        return "\(timeStamp)"
    }
}
