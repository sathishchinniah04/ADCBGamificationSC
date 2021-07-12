//
//  ReferCode.swift
//  ADCBGamification
//
//  Created by SKY on 12/07/21.
//

import Foundation
class ReferCode: Decodable {
    var referralCode: String?
    var validTill: String?
    var rewardMessage: String?
    var respCode: String?
    var respDesc: String?
    var requestId: String?
    var timestamp: String?
}
