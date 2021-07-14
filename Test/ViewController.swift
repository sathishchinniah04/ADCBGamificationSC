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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup() {
        self.msisdnTextField.text = "9902390324"
        self.gameIdTxtFld.text = "51"
        self.gameNameButton.setTitle("SpinNWin", for: .normal)
    }
    
    
    
    @IBAction func gameNameAction() {
        presentAlert(withTitle: "Title", message: "Message")
    }
    
    @IBAction func openGameAction() {
        Game.open(controller: self, msisdn: self.msisdnTextField.text!, language: "EN", gameType: self.gameNameButton.titleLabel!.text!, gameId: gameIdTxtFld.text!)
    }
    
    @IBAction func openGameListButtonAction() {
        DispatchQueue.main.async {
            Game.openGameList(controller: self, msisdn: self.msisdnTextField.text!, language: "EN")
        }
    }
    
    func presentAlert(withTitle title: String, message : String) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let OKAction = UIAlertAction(title: "OK", style: .default) { action in
          print("You've pressed OK Button")
      }
      let predict = UIAlertAction(title: "PredictNWin", style: .default) { action in
          self.gameNameButton.setTitle("PredictNWin", for: .normal)
      }
      let spin = UIAlertAction(title: "SpinNWin", style: .default) { action in
          self.gameNameButton.setTitle("SpinNWin", for: .normal)
      }
      let refer = UIAlertAction(title: "ReferNWin", style: .default) { action in
          self.gameNameButton.setTitle("ReferNWin", for: .normal)
      }
        alertController.addAction(OKAction)
        alertController.addAction(predict)
        alertController.addAction(spin)
        alertController.addAction(refer)
      self.present(alertController, animated: true, completion: nil)
    }
}

