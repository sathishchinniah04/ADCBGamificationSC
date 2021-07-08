//
//  ViewController.swift
//  Test
//
//  Created by SKY on 23/06/21.
//

import UIKit
import ADCBGamification
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            Game.openGameList(controller: self, msisdn: "9902390324", language: "EN")
            //Game.open(controller: self, msisdn: "9902390324", language: "EN", gameType: "PredictNWin", gameId: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openGameButtonAction() {
        DispatchQueue.main.async {
            Game.openGameList(controller: self, msisdn: "9902390324", language: "EN")
            //Game.loadGame(controller: self, msisdn: "9902390324", language: "EN", gameType: "PredictNWin",gameId: nil)
        }
    }

}

