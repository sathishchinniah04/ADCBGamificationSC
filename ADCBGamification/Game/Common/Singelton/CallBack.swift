//
//  CallBack.swift
//  ADCBGamification
//
//  Created by SKY on 19/07/21.
//

import Foundation
enum CallBackAction {
    case back
    case close
    case spinReward
    case gamePlayed(IndexPath)
}
class CallBack {
    static let shared = CallBack()
    var handle:((CallBackAction)->Void)?
    private init() { }
    func callBacKAction(complition: ((CallBackAction)->Void)?) {
        self.handle = complition
    }
}
