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
    var referSuccessView = ReferSuccessPopupHelper()
    var referCode: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDottedLine()
        self.neumorphicButtonSetup()
        getReferCode()
        buttonUserInteraction(enable: false)
        self.chooseContactButton.buttonState(isPressed: false)
        self.chooseContactButton.chooseContact.isHidden = true
        self.chooseContactButton.textField.keyboardType = .phonePad
        self.chooseContactButton.contactListButton.isHidden = false
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
                self.referCode = data.referralCode ?? ""
                self.buttonUserInteraction(enable: true)
                self.referCodeView.layoutIfNeeded()
            }
        }
    }
    
    func addDottedLine() {
        DispatchQueue.main.async {
            self.referCodeView.addDottedLine()
            
            self.chooseContactButton.populateView(complition: self.chooseContactButtonTapped(action:), textAction: nil)
            
        }
    }
    
    @IBAction func inviteButtonAction() {
        if self.chooseContactButton.textField.text!.isEmpty {
            self.view.showAlert(message: "Please enter mobile number.") { (done) in
                self.openContactList()
            }
        } else {
            var bParty = self.chooseContactButton.textField.text ?? ""
            
            bParty = bParty.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    
            ReferViewModel.recordRefer(referCode: self.referCode, bParty: bParty) { (data) in
                print("data is \(data)")
                if data.respCode == "SC0000" {
                    self.onRecordSuccess(info: data)
                } else {
                    self.onRecordFailure(info: data)
                }
            }
        }
    }
    
    func onRecordSuccess(info: ReferCode) {
        self.referSuccessView.show {
            DispatchQueue.main.async {
                self.referSuccessView.animateAndRemove()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func onRecordFailure(info: ReferCode) {
        DispatchQueue.main.async {
        self.view.showAlert(message: info.respDesc ?? "") { (done) in
            self.navigationController?.popToRootViewController(animated: true)
        }
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
        self.openActivityController(text: "Hey! check out the referral code and use this while registering. *\(referCode)*")
    }
    
    func chooseContactButtonTapped(action: ReferContactButtonAction) {
        switch action {
        case .chooseContact:
            print("button tapped")
        case .contactList:
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