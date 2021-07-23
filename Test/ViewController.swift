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
    @IBOutlet weak var gameIdTxtFld: UITextField!
    @IBOutlet weak var gameNameButton: UIButton!
    @IBOutlet weak var openGameButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup() {
        self.msisdnTextField.text = "9902390347"
        self.gameIdTxtFld.text = "51"
        self.gameNameButton.setTitle("SpinNWin", for: .normal)
        self.gameNameButton.layer.cornerRadius = 5.0
        self.gameNameButton.layer.borderWidth = 0.5
        self.gameNameButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    
    @IBAction func gameNameAction() {
        presentAlert(withTitle: "", message: "Please select a game name.")
    }
    
    @IBAction func openGameAction() {
        Game.open(controller: self, msisdn: self.msisdnTextField.text!, language: "EN", gameType: self.gameNameButton.titleLabel!.text!, gameId: gameIdTxtFld.text!, complition: callBackHander(action:))
    }
    
    func callBackHander(action: GameAction) {
        switch action {
        case .backButton:
            print("Back button tapped")
        case .closeButton:
            print("Close button tapped")
        case .spinReward:
            print("spinReward button tapped")
        }
    }
    
    @IBAction func openGameListButtonAction() {
        DispatchQueue.main.async {
            Game.openGameList(controller: self, msisdn: self.msisdnTextField.text!, language: "EN", complition: self.callBackHander(action:))
        }
    }
    
    func presentAlert(withTitle title: String, message : String) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      
      let predict = UIAlertAction(title: "PredictNWin", style: .default) { action in
          self.gameNameButton.setTitle("PredictNWin", for: .normal)
      }
      let spin = UIAlertAction(title: "SpinNWin", style: .default) { action in
          self.gameNameButton.setTitle("SpinNWin", for: .normal)
      }
      let refer = UIAlertAction(title: "ReferNWin", style: .default) { action in
          self.gameNameButton.setTitle("ReferNWin", for: .normal)
      }
        alertController.addAction(spin)
        alertController.addAction(predict)
        alertController.addAction(refer)
      self.present(alertController, animated: true, completion: nil)
    }
}

