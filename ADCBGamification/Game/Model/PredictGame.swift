//
//  PredictGame.swift
//  ADCBGamification
//
//  Created by SKY on 09/07/21.
//

import Foundation
class PredictGame: Decodable {
    
    var requestId: String?
    var timestamp: String?
    var respCode: String?
    var respDesc: String?
    var predictionList: [PredictList]?
}

class PredictList: Decodable {
    var category: String?
    var tournaments: [Tournaments]?
}

class Tournaments: Decodable {
    var tournamentName: String?
    var tournamentImage: String?
    var eventList: [EventsList]?
}
class EventsList: Decodable {
    var eventid: Float?
    var numberOfquestions: Float?
    var imageCard: String?
    var predictionActivationTime: String?
    var predictionLockingTime: String?
    var OpponentA: String?
    var opponentASynonym: String?
    var opponentBSynonym: String?
    var OpponentB: String?
    var imageCardOppenentA: String?
    var imageCardOppenentB: String?
    var MatchDate: String?
    var questionList:[QuestionList]?
    
}

class QuestionList: Decodable {
    
    var question: String?
    var questionId: Int?
    var imageCard: String?
    var predOptions:[PredOption]?
    
}

class PredOption: Decodable {
    var id: Int?
    var text: String?
    var image: String?
    var predictedPercentage: Float?
    lazy var isSelected: Bool = {
        return false
    }()
}
