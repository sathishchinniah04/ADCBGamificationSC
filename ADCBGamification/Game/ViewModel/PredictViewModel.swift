//
//  PredictViewModel.swift
//  ADCBGamification
//
//  Created by SKY on 09/07/21.
//

import Foundation

class PredictViewModel {
    static func getPredictDetail(gameId: String, complition:((PredictGame)->Void)?) {
        let urlStr = Constants.predictgameDetail+"\(gameId)/1"
        guard let url = URL(string: urlStr) else {print("Inavlid url getPredictDetail"); return }
        var urlReq = URLRequest(url: url)
        urlReq.setValue(gameId, forHTTPHeaderField: "gameId")
        urlReq.setValue("1", forHTTPHeaderField: "milestoneId")
        urlReq.setValue(Utility.getRandonNo(), forHTTPHeaderField: "requestId")
        urlReq.setValue(StoreManager.shared.msisdn, forHTTPHeaderField: "msisdn")
        urlReq.setValue(StoreManager.shared.msisdn, forHTTPHeaderField: "customerId")
        urlReq.setValue(StoreManager.shared.language, forHTTPHeaderField: "language")
        
        NetworkManager.getRequest(struct: PredictGame.self, url: urlStr, urlReq: urlReq) { (data, error) in
            if let data = data {
                complition?(data)
            } else {
                print("Error found \(error)")
            }
        }
    }
}
