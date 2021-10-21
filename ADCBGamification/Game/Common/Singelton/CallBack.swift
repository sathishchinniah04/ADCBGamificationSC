//
//  CallBack.swift
//  ADCBGamification
//
//  Created by SKY on 19/07/21.
//

import Foundation
enum CallBackAction {
    case back
    case homeAction
    case knowMoreAction
    case spinReward
    case gamePlayed(IndexPath)
    case dismissed
}
class CallBack {
    static let shared = CallBack()
    var handle:((CallBackAction)->Void)?
    private init() { }
    func callBacKAction(complition: ((CallBackAction)->Void)?) {
        self.handle = complition
    }
}
