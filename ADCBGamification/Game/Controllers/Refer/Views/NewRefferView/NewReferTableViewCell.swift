//
//  NewReferTableViewCell.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit
enum NewReferTableViewCellAction {
    case refer
    case sendButton
}
class NewReferTableViewCell: UITableViewCell {
    @IBOutlet weak var nameTextField: NeumorphicTextField!
    @IBOutlet weak var emailTextField: NeumorphicTextField!
    @IBOutlet weak var contactTextField: NeumorphicTextField!
    @IBOutlet weak var referButton: NeumorphicButton!
    @IBOutlet weak var sendButton: NeumorphicButton!
    private var handle:((NewReferTableViewCellAction)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldSetup() {
        
        nameTextField.textFieldInitialSetup(title: "Name", placeHolder: "Name", type: .name,complition: textFieldHandle(action:))
        contactTextField.textFieldInitialSetup(title: "Mobile Number", placeHolder: "Mobile Number", type: .contact,complition: textFieldHandle(action:))
        emailTextField.textFieldInitialSetup(title: "Email Address", placeHolder: "Email Address", type: .email,complition: textFieldHandle(action:))
    }
    
    func buttonSetup() {
        
        referButton.populateView(complition: referButtonHandle(action:))
        //handle = referButtonHandle(action:)
        referButton.setButtonImage(name: "share")
        sendButton.populateView(complition: sendButtonHandle(action:))
        //handle = sendButtonHandle(action:)
        sendButton.disabledState()
        sendButton.setButtonTitle(title: "Send Referral")
    }
    
    func textFieldHandle(action: NeumorphicTextFieldAction) {
        if nameTextField.isValid && contactTextField.isValid && emailTextField.isValid {
            sendButton.enabledState()
        } else {
            sendButton.disabledState()
        }
    }
    
    func sendButtonHandle(action: NeumorphicButtonAction) {
        if nameTextField.isValid && contactTextField.isValid && emailTextField.isValid {
                   handle?(.sendButton)
        } else {
       
       }
    }
    
    func populateView(complition:((NewReferTableViewCellAction)->Void)?) {
        textFieldSetup()
        buttonSetup()
        self.handle = complition
    }
    
    func referButtonHandle(action: NeumorphicButtonAction) {
        print("Tapped refer")
        handle?(.refer)
    }
    
//    @IBAction func sendButtonAction() {
//        if nameTextField.isValid && contactTextField.isValid && emailTextField.isValid {
//            handle?(.sendButton)
//        } else {
//
//        }
//    }
    
}
