//
//  ReferViewModel.swift
//  ADCBGamification
//
//  Created by SKY on 12/07/21.
//

import Foundation
class ReferViewModel {
    static func getReferalCode(complition:((ReferCode)->Void)?) {
        let service = "activation"
        let urlStr = Constants.getReferCodeUrl+service
        guard let url = URL(string: urlStr) else { return }
        var urlReq = URLRequest(url: url)
        urlReq.setValue(Utility.getRandonNo(), forHTTPHeaderField: "requestId")
        urlReq.setValue(StoreManager.shared.msisdn, forHTTPHeaderField: "customerId")
        urlReq.setValue(StoreManager.shared.language, forHTTPHeaderField: "language")
        NetworkManager.getRequest(struct: ReferCode.self, url: urlStr, urlReq: urlReq) { (data, error) in
            if let dat = data {
                complition?(dat)
            }
            print("data \(data)")
            print("error \(error)")
        }
    }
    
    static func recordRefer(referCode: String, bParty: String ,complition:((ReferCode)->Void)?) {
        let service = "activation/notifications"
        let urlStr = Constants.recordReferUrl+service
        guard let url = URL(string: urlStr) else { return }
        var urlReq = URLRequest(url: url)
        urlReq.setValue(Utility.getRandonNo(), forHTTPHeaderField: "requestId")
        urlReq.setValue(StoreManager.shared.msisdn, forHTTPHeaderField: "customerId")
        urlReq.setValue(StoreManager.shared.language, forHTTPHeaderField: "language")
        //urlReq.setValue(bParty, forHTTPHeaderField: "msisdn")
        //urlReq.setValue(referCode, forHTTPHeaderField: "referralCode")
    
        let dict = ["phoneNumber": bParty,"name":""]
        
        NetworkManager.postRequest(struct: ReferCode.self, url: urlStr, urlReq: urlReq, requestData: dict) { (data, error) in
            if let dat = data {
                print("data is \(dat)")
                complition?(dat)
            }
        }
        
        //urlReq.setValue(bParty, forHTTPHeaderField: "msisdn")
        //urlReq.setValue(referCode, forHTTPHeaderField: "referralCode")
//        NetworkManager.postRequest(struct: ReferCode.self, url: urlStr, urlReq: urlReq) { (data , error) in
//            if let dat = data {
//                print("data is \(dat)")
//                complition?(dat)
//            }
//            print("Error is \(error)")
//        }
    }
    
    static func notifyToUser() {
        let service = "activation"
        let urlStr = Constants.sendNotificationUrl+"\(service)/notifications"
        guard let url = URL(string: urlStr) else { return }
        var urlReq = URLRequest(url: url)
        urlReq.setValue(Utility.getRandonNo(), forHTTPHeaderField: "requestId")
        urlReq.setValue(StoreManager.shared.msisdn, forHTTPHeaderField: "customerId")
        urlReq.setValue(StoreManager.shared.language, forHTTPHeaderField: "language")
        NetworkManager.postRequest(struct: ReferNotification.self, url: urlStr, urlReq: urlReq) { (data, error) in
            if let da = data {
                print("data is \(da)")
            }
            print("Error is \(error)")
        }
    }
    
    static func checkSimpleLifeUser(number: String , complition:((String)->Void)?) {
        
        let service = "getCustomerProfile"
        
        let urlStr = Constants.simpleLiferUserCheck + service
        
        guard let url = URL(string: urlStr) else { return }
        
        var urlReq = URLRequest(url: url)
        
        urlReq.setValue(Utility.getRandonNo(), forHTTPHeaderField: "X-CORELATION-ID")
        
        urlReq.setValue(number, forHTTPHeaderField: "msisdn")
 
    
       // let dict = ["phoneNumber": bParty,"name":""]
        
        NetworkManager.getRequest(struct: SimpleLifeUser.self, url: urlStr) { (data, error) in
            
            print("Error is \(String(describing: error))")
            if error == nil {
                complition?("")
            } else {
                complition?("")
            }
        }

    }
    
//    static func getRecordHistory(referCode: String, complition:((ReferCode)->Void)?) {
//
//
//    }
}
