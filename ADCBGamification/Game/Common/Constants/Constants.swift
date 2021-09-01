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
    static let predictgameDetail = "\(baseUrl)Gamification-1.0/Gamification/gameEngine/predictionGameDetails/"
    static let getReferCodeUrl = "\(baseUrl)Gamification-1.0/Gamification/gameManagement/game/referral/"
    static let recordReferUrl = "\(baseUrl)Gamification-1.0/Gamification/gameManagement/game/referral/"
    static let sendNotificationUrl = "\(baseUrl)Gamification-1.0/Gamification/gameManagement/game/referral/"
    
   // https://gameuat.intclstl.com/Gamification-1.0/Gamification/1/1/getCustomerProfile
    
    static let simpleLiferUserCheck = "\(baseUrl)Gamification-1.0/Gamification/1/1/"
    
    
   // URL: http://10.0.0.95:9082/LMS-1.0/LMS/{tenant}/{version}/getCustomerProfile
   // Sample URL: http://10.0.0.95:9082/LMS-1.0/LMS/1/1/getCustomerProfile
    
    
    //http://cvm-game.20.74.146.216.nip.io/Gamification-1.0/Gamification/gameManagement/game/referral/activation/notifications
    
    static let spinGetSpinOffer = "\(baseUrl)Gamification-1.0/Gamification/gameEngine/executeGame"
    static var referMessage = ""
    
    static var leagueName:String = ""
    //static let spinAssignReward = "http://cvm-game.20.74.146.216.nip.io/Gamification-1.0/Gamification/executeEvent"
}
