//
//  Constants.swift
//  ADCBGamification
//
//  Created by SKY on 07/07/21.
//

import Foundation

class Constants {
    
    private static let baseUrl = StoreManager.shared.gameUrl
    static let listGameUrl = "\(baseUrl)Gamification-1.0/Gamification/listGames"
    //static let spinGetSpinOffer = "\(baseUrl)Gamification-1.0/Gamification/gameEngine/executeGame"
    static let spinAssignReward = "\(baseUrl)Gamification-1.0/Gamification/executeEvent"
    
    
    
    
    
    static let spinGetSpinOffer = "http://cvm-game.20.74.146.216.nip.io/Gamification-1.0/Gamification/gameEngine/executeGame"
    //static let spinAssignReward = "http://cvm-game.20.74.146.216.nip.io/Gamification-1.0/Gamification/executeEvent"
}
