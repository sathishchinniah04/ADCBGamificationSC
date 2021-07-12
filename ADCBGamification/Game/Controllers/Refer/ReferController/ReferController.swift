//
//  ReferController.swift
//  ADCBGamification
//
//  Created by SKY on 09/07/21.
//

import UIKit

class ReferController: UIViewController {
    
    @IBOutlet weak var referCodeView: UIView!
    @IBOutlet weak var referCodeLabel: UILabel!
    @IBOutlet weak var shareButton: NeumorphicButton!
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var chooseContactButton: ReferContactButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDottedLine()
        self.neumorphicButtonSetup()
        getReferCode()
        buttonUserInteraction(enable: false)
    }
    
    func buttonUserInteraction(enable: Bool) {
        DispatchQueue.main.async {
            self.inviteButton.isUserInteractionEnabled = enable
            self.shareButton.isUserInteractionEnabled = enable
        }
    }
    
    func getReferCode() {
        referCodeLabel.text = "Loading"
        ReferViewModel.getReferalCode { (data) in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.referCodeLabel.text = data.referralCode
                self.buttonUserInteraction(enable: true)
            }
        }
    }
    
    func addDottedLine() {
        DispatchQueue.main.async {
            self.referCodeView.addDottedLine()
            
            self.chooseContactButton.populateView(complition: self.chooseContactButtonTapped(action:), textAction: nil)
            
        }
    }
    
    func neumorphicButtonSetup() {
        DispatchQueue.main.async {
            self.shareButton.setButtonImage(name: "Refershare")
            self.shareButton.populateView(complition: self.referButtonHandle(action:))
            self.shareButton.buttonState(isPressed: true)
            //self.shareButton.button.setImage(UIImage(named: "Refershare"), for: .normal)
        }
    }
    
    func referButtonHandle(action: NeumorphicButtonAction) {
        print("Tapped refer")
        self.openActivityController(text: "share this text")
    }
    
    func chooseContactButtonTapped(action: ReferContactButtonAction) {
        switch action {
        case .chooseContact:
            self.openContactList()
        default:
            break
        }
    }
    
    func openContactList() {
        let cont = UIStoryboard(name: "Refer", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "ContactListController") as! ContactListController
        cont.handle = {(name, ph) in
            self.chooseContactButton.titleLabel.text = name
            self.chooseContactButton.textField.text = ph
        }
        self.present(cont, animated: true, completion: nil)
    }
    
}
