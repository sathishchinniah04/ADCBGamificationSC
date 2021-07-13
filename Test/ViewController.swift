//
//  ViewController.swift
//  Test
//
//  Created by SKY on 23/06/21.
//

import UIKit
import ADCBGamification
class ViewController: UIViewController {
    @IBOutlet weak var msisdnTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.msisdnTextField.text = "9902390324"
        DispatchQueue.main.async {
            Game.openGameList(controller: self, msisdn: "9902390324", language: "EN")
            
            //Game.open(controller: self, msisdn: "9902390324", language: "EN", gameType: "PredictNWin", gameId: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func openGameButtonAction() {
        DispatchQueue.main.async {
            Game.openGameList(controller: self, msisdn: self.msisdnTextField.text!, language: "EN")
            //Game.openGameList(controller: self, msisdn: "9902390324", language: "EN")
            //Game.loadGame(controller: self, msisdn: "9902390324", language: "EN", gameType: "PredictNWin",gameId: nil)
        }
    }

}

