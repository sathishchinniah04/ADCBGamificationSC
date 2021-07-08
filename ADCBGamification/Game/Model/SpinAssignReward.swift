//
//  SpinAssignReward.swift
//  ADCBGamification
//
//  Created by SKY on 08/07/21.
//

import Foundation
class SpinAssignReward: Decodable {
    var requestId: String?
    var timestamp: String?
    var respCode: String?
    var respDesc: String?
    var responseObject: [SpinrespObj]?
}

class SpinrespObj: Decodable{
    var achievmentId: String?
    var achievementType: String?
    var expiryDate: String?
    var achievmentStatus: String?
    var productId: String?
    var chancesRemaining: String?
    var displayDetails: [DisplayDetails]?
}

