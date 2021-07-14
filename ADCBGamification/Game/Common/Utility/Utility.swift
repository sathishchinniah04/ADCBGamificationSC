//
//  Utility.swift
//  ADCBGamification
//
//  Created by SKY on 07/07/21.
//

import UIKit

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
        
        static func secondsToHoursMinutesSeconds (seconds : Int) -> (String, String, String) {
            return (String(format: "%02d",seconds / 3600), String(format: "%02d", (seconds % 3600) / 60), String(format: "%02d", (seconds % 3600) % 60))
        }
}
