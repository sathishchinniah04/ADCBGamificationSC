//
//  GameListVM.swift
//  ADCBGamification
//
//  Created by SKY on 07/07/21.
//

import Foundation

class GameListVM {
    static var activeGames = [Games]()
    static var allGames = [Games]()
    
    static var networkManager = NetworkManager()
    
    static func getGame(url: String, gameType: String, gameid: String?,complition:(()->Void)? = nil) {
        
        let searchQuerry: [[String: String]]!
        
        if let gid = gameid {
            if gid.isEmpty {
                searchQuerry = [["filterOn": "GameType",
                                 "filterValue": gameType]]
            } else {
                searchQuerry = [["filterOn": "GameId",
                             "filterValue": gid]]
            }
        } else {
            searchQuerry = [["filterOn": "GameType",
                             "filterValue": gameType]]
        }
        
        let myDict: Dictionary = [
            "requestId": Utility.getRandonNo(),
            "timestamp": Utility.getTimeStamp(),
                "keyword": "ListGames",
            "searchFilter": searchQuerry as Any,
            "queryParams": [["key": StoreManager.shared.msisdn, "keyType": "CUSTOMER_ID"],["key": StoreManager.shared.language, "keyType": "LANG"]]
        ] as [String : Any]
        
        networkManager.postRequest(struct: GameList.self, url: url, requestData: myDict) { (data, error) in
            print("data \(String(describing: data))")
            if let data = data {
                getActiveGames(list: data, complition: complition)
            } else {
                print("error is \(String(describing: error))")
            }
        }
    }
    
    static func getGameList(url: String, complition:(()->Void)? = nil) {
        
        let myDict: Dictionary = [
            "requestId": Utility.getRandonNo(),
            "timestamp": Utility.getTimeStamp(),
                "keyword": "ListGames",
            //"searchFilter": searchQuerry as Any,
            "queryParams": [["key": StoreManager.shared.msisdn, "keyType": "CUSTOMER_ID"],["key": StoreManager.shared.language, "keyType": "LANG"]]
        ] as [String : Any]
        
        networkManager.postRequest(struct: GameList.self, url: url, requestData: myDict) { (data, error) in
            print("data \(String(describing: data))")
            if let data = data {
                getActiveGames(list: data, complition: complition)
            } else {
                print("error is \(String(describing: error))")
            }
        }
    }
    
    static func getActiveGames(list: GameList, complition:(()->Void)?) {
        allGames = list.responseDetail?.games ?? [Games]()
        activeGames = list.responseDetail?.games?.filter({$0.executionStatus == "Active"}) ?? [Games]()
        complition?()
        print("total active Games \(activeGames.count) \n\n Active games \(activeGames)\n\n\n")
        print("total  Games \(allGames.count) \n\n all games \(allGames)\n\n\n")
    }
}
