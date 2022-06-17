//
//  Result.swift
//  ADCBGamification
//
//  Created by SKY on 07/07/21.
//

import Foundation
class GameList: Decodable {
    var requestId: String
    var timestamp: String
    var respCode: String
    var respDesc: String
    var responseDetail: GameListResponseDetail?
}

class GameListResponseDetail: Decodable {
    var games:[Games]?
}

class Games: Decodable {
    let gameId: String?
    let gameTitle: String
    let gameType: String
    let gameStatus: String?
    let executionStatus: String?
    let currentTime: String?
    
    let milestonesAvailable: Bool?
    let leaderboardAvailable: Bool?
    let optinRequired: Bool?
    let timeToComplete: Float?
    let tncRequired: Bool?
    let achievementId: String?
    let tncStatus: String?
    let validityPeriod: ValidityPeriod?
    let executionPeriod: ExecutionPeriod?
    let displayDetails: DisplayDetails?
    let attributeList: AttributeList?
    let costOfGame: CostOfGame?
    let frequency:[Frequency]
    
}
class ValidityPeriod: Decodable {
    var startDateTime: String?
    var endDateTime: String?
}

class ExecutionPeriod: Decodable {
    var startDateTime: String?
    var endDateTime: String?
}

class DisplayDetails: Decodable {
    var name: String?
    var description: String?
    var synonym: String?
    var tncFile: String?
    var language: String?
    var imageList: [ImageList]?
    var displayMessage:String?
}

class ImageList: Decodable {
    var name: String?
    var idtype: String?
}

class AttributeList: Decodable {
    var name: String?
    var idtype: String?
}

class CostOfGame: Decodable {
    var cost: Float? = 0.0
    let costType: String?
}

class Frequency: Decodable {
    var frequencyValue: String?
    var frequencyType: String?
}
