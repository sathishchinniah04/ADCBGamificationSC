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
    @IBOutlet weak var gameLanguageButton: UIButton! {
        didSet {
            self.gameLanguageButton.setTitle("EN", for: .normal)
            self.gameLanguageButton.layer.cornerRadius = 5.0
            self.gameLanguageButton.layer.borderWidth = 0.5
            self.gameLanguageButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var openGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    func initialSetup() {
        // new change 
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
    
    @IBAction func gameLanguageAction() {
        presentAlert(withTitle: "", message: "Please select your language.", forLanguage: true)
    }
    
    @IBAction func openGameAction() {
        
        Game.open(controller: self, msisdn: self.msisdnTextField.text!, language: self.gameLanguageButton.titleLabel!.text!, gameType: self.gameNameButton.titleLabel!.text!, gameId: gameIdTxtFld.text!, complition: callBackHander(action:))
    }
    
    func callBackHander(action: GameAction) {
        switch action {
        case .backButton:
            print("Back button tapped")
        case .homeAction:
            print("Close button tapped")
        case .spinReward:
            print("spinReward button tapped")
        
        default:
            print("default")
        }
    }
    
    @IBAction func openGameListButtonAction() {
        DispatchQueue.main.async {
            Game.openGameList(controller: self, msisdn: self.msisdnTextField.text!, language: self.gameLanguageButton.titleLabel!.text!, complition: self.callBackHander(action:))
            
        }
    }
    
    func presentAlert(withTitle title: String, message : String, forLanguage: Bool = false) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let predict = UIAlertAction(title: forLanguage ? "EN" : "PredictNWin", style: .default) { action in
            if forLanguage {
                self.gameLanguageButton.setTitle(forLanguage ? "EN" : "PredictNWin", for: .normal)
            } else {
                self.gameNameButton.setTitle(forLanguage ? "EN" : "PredictNWin", for: .normal)
            }
            
            
        }
        let spin = UIAlertAction(title: forLanguage ? "AR" : "SpinNWin", style: .default) { action in
            if forLanguage {
                self.gameLanguageButton.setTitle(forLanguage ? "AR" : "SpinNWin", for: .normal)
            } else {
                self.gameNameButton.setTitle(forLanguage ? "AR" : "SpinNWin", for: .normal)
            }
            
        }
        
        let refer = UIAlertAction(title: forLanguage ? "" : "ReferNWin", style: .default) { action in
            if forLanguage {
                self.gameLanguageButton.setTitle(forLanguage ? "" : "ReferNWin", for: .normal)
            } else {
                self.gameNameButton.setTitle(forLanguage ? "" : "ReferNWin", for: .normal)
            }
            
        }
        
        alertController.addAction(spin)
        alertController.addAction(predict)
        
        if !forLanguage {
            alertController.addAction(refer)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

