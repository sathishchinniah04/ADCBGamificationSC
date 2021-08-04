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
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var referIdLbl: UILabel!
    @IBOutlet weak var referralCodeLbl: UILabel!
    @IBOutlet weak var addFriednLbl: UILabel!
    
    
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
        
        nameTextField.titleLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        contactTextField.titleLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        emailTextField.titleLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
    }
    
    func setupFontFamily() {
        
        titleLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  17.0 : 17.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        subTitleLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  17.0 : 17.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        referIdLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  17.0 : 17.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        referralCodeLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  15.0 : 15.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        addFriednLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  17.0 : 17.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
    }
    
    
    
    func buttonSetup() {
        
        referButton.populateView(complition: referButtonHandle(action:))
        //handle = referButtonHandle(action:)
        referButton.setButtonImage(name: "share")
        referButton.setButtonFont(fSize: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fName: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
        sendButton.populateView(complition: sendButtonHandle(action:))
        //handle = sendButtonHandle(action:)
        sendButton.disabledState()
        sendButton.setButtonTitle(title: "Send Referral")
        sendButton.setButtonFont(fSize: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fName: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
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
