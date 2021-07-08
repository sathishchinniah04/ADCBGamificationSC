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
    
        
        static func convertStringIntoDate(date: String) -> Int{
            let isoDate = date
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = dateFormatter.date(from:isoDate) {
                let timeInterval = date.timeIntervalSinceNow
                let myInt = Int(timeInterval)
                return myInt
            } else {
                return 2
            }
        }
        
        static func secondsToHoursMinutesSeconds (seconds : Int) -> (String, String, String) {
            return (String(format: "%02d",seconds / 3600), String(format: "%02d", (seconds % 3600) / 60), String(format: "%02d", (seconds % 3600) % 60))
        }
}
