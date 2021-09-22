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
    var referralMessage: String?
    var emailSubject: String?
}


class SimpleLifeUser: Decodable {
    var status: Int?
    var error: String?
    var message: String?
    var timestamp: String?
    var path: String?
    var errorCode: String?
    var errorDescription: String?
    var errorMessage: String?
    
}
