//
//  SpinViewOfferVM.swift
//  ADCBGamification
//
//  Created by SKY on 08/07/21.
//

import Foundation

class SpinViewOfferVM {
    
    static var networkManager = NetworkManager()
    
    static func getOffers(gameId: String, complition:((SpinOffers)->Void)?) {
        let urlStr = Constants.spinGetSpinOffer+"/\(gameId)/1/viewOffers"
        guard let url = URL(string: urlStr) else { return }
        var urlReq = URLRequest(url: url)
        urlReq.setValue(Utility.getRandonNo(), forHTTPHeaderField: "X_CORRELATION_ID")
        urlReq.setValue(StoreManager.shared.msisdn, forHTTPHeaderField: "customerId")
        urlReq.setValue(StoreManager.shared.language, forHTTPHeaderField: "language")
        networkManager.getRequest(struct: SpinOffers.self, url: urlStr, urlReq: urlReq) { (data, error) in
            if let dat = data {
                complition?(dat)
            }
            print("Error is \(String(describing: error))")
        }
    }
    
    static func assignReward(gameId: String, complition:((SpinAssignReward)->Void)?) {
        let myDict: Dictionary = [
            "requestId": Utility.getRandonNo(),
            "timestamp": Utility.getTimeStamp(),
                "keyword": "executeEvent",
            "queryParams": [
                ["key": StoreManager.shared.msisdn, "keyType": "CUSTOMER_ID"],
                ["key": StoreManager.shared.language, "keyType": "LANG"],
                ["key": StoreManager.shared.msisdn, "keyType": "MSISDN"],
                ["key": "AssignReward", "keyType": "Activity"],
                ["key": "1", "keyType": "MILESTONE"],
                ["key": gameId, "keyType": "Game"]
            ]
        ] as [String : Any]
        
        let urlStr = Constants.spinAssignReward
        networkManager.postRequest(struct: SpinAssignReward.self, url: urlStr, requestData: myDict) { (data, error) in
            print("Data is \(String(describing: data))")
            print("error is \(String(describing: error))")
            if let data = data {
                complition?(data)
            }
        }
    }
}
