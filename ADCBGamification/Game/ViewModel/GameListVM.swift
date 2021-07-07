//
//  GameListVM.swift
//  ADCBGamification
//
//  Created by SKY on 07/07/21.
//

import Foundation

class GameListVM {
    
   static func getGameList(url: String) {
        
        let myDict: Dictionary = [
            "requestId": Utility.getRandonNo(),
            "timestamp": Utility.getTimeStamp(),
                "keyword": "ListGames",
            "queryParams": [["key": StoreManager.shared.msisdn, "keyType": "CUSTOMER_ID"],["key": StoreManager.shared.language, "keyType": "LANG"]]
        ] as [String : Any]
        
        NetworkManager.postRequest(struct: GameList.self, url: url, request: myDict) { (data, error) -> Void? in
            print("data \(data)")
        }
    }
}
