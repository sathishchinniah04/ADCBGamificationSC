//
//  SpinOffers.swift
//  ADCBGamification
//
//  Created by SKY on 08/07/21.
//

import Foundation
class SpinOffers: Decodable {
    var timestamp: String?
    var respCode: String?
    var respDesc: String?
    var offers: [Offers]?
}

class Offers: Decodable {
    var rewardId: String?
    var rewardTitle: String?
    var defaultReward: Bool?
}
