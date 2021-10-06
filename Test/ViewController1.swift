//
//  ViewController1.swift
//  Test
//
//  Created by Sathish Kumar on 05/10/21.
//

import UIKit
import ADCBGamification

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.main.async {
//            Game.openGameList(controller: self, msisdn: "971222200021", language: "EN", complition: self.callBackHander(action:))
//        }
        
        Game.open(controller: self, msisdn: "123", language: "EN", gameType: "ReferNWin", complition: callBackHander(action:))

    }

    func callBackHander(action: GameAction) {
        switch action {
        case .backButton:
            print("Back button tapped")
        case .homeAction:
            print("Home Action Callback")
        case .spinReward:
            print("spinReward button tapped")
        case .dismissed:
            print("controller get dismissed")
        
        default:
            print("default")
        }
    }
}
