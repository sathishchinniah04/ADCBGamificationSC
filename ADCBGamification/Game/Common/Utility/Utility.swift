//
//  Utility.swift
//  ADCBGamification
//
//  Created by SKY on 07/07/21.
//

import UIKit

class Utility {
    
    private static let APPLE_LANGUAGE_KEY = "AppleLanguages1"

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
    
    static func errorHandler(target: UIViewController, error: GameError?) {
        switch error {
        case .noActiveGames:
            target.view.showAlert(message: "No Active Games Available") { (done) in
                target.dismiss(animated: true, completion: nil)
            }
        case .noGames:
            target.view.showAlert(message: "No Games Available") { (done) in
                target.dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    static func isRTL() -> Bool {
        //let lang = UserDefaults.standard.value(forKey: APPLE_LANGUAGE_KEY) as? String ?? "ar"
        return StoreManager.shared.language == "en" ? false : true
    }
    
    static func showAlert(target: UIViewController? = nil, singelBtn: Bool = true,ok: String = "Ok", cancel: String = "Cancel",title: String = "Alert",message: String, complition:((AlertAction)->Void)?) {
        DispatchQueue.main.async {
            
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ok, style: .default, handler: { (action) in
            complition?(.ok)
        }))
        if !singelBtn {
            alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: { (action) in
            complition?(.cancel)
            }))
        }
            let rootView = UIApplication.shared.windows.first?.rootViewController
            if let tar = target {
                tar.present(alert, animated: true, completion: nil)
            } else {
                rootView?.present(alert, animated: true, completion: nil)
            }
        }
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
    
    
    static func convertStringIntoDateTimeInterval(date: String) ->  TimeInterval? {
        let isoDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from:isoDate) {
            let timeInterval = date.timeIntervalSinceNow
            return timeInterval
        } else {
            return nil
        }
    }
    
    
    static func convertDateFormat(inputDate: String) -> String {
//on 18 Aug 2021
         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "dd MMM yyyy"

         return convertDateFormatter.string(from: oldDate!)
    }
    
    
    static func convertDateWithFormat(inputDate: String, currFormat: String, expFormat: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = currFormat

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = expFormat

         return convertDateFormatter.string(from: oldDate!)
    }
    
    static func convertStringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: date) ?? Date()
    }
        
        static func secondsToHoursMinutesSeconds (seconds : Int) -> (String, String, String) {
            return (String(format: "%02d",seconds / 3600), String(format: "%02d", (seconds % 3600) / 60), String(format: "%02d", (seconds % 3600) % 60))
        }
    
    static func findDateDiff(time1Str: String, time2Str: String) -> String {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "hh:mm a"

        guard let time1 = timeformatter.date(from: time1Str),
            let time2 = timeformatter.date(from: time2Str) else { return "" }

        //You can directly use from here if you have two dates

        let interval = time2.timeIntervalSince(time1)
        let hour = interval / 3600;
        let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
        let intervalInt = Int(interval)
        return "\(intervalInt < 0 ? "-" : "+") \(Int(hour)) Hours \(Int(minute)) Minutes"
    }
    

}
