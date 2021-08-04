//
//  HistoryTableViewCell.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit
enum HistoryTableViewCellAction {
    case update
    case resend
}
class HistoryTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var statusHeaderLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var emailIdLbl: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var resendButton: NeumorphicButton!
    private var handle:((HistoryTableViewCellAction)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFontFamily()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupFontFamily() {
        
        statusLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        statusHeaderLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        nameLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        phoneNumberLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        emailIdLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
  
    }
    
    func populateView(index: Int, complition: ((HistoryTableViewCellAction)->Void)?) {
        containerView.backgroundColor = UIColor.newmorphicColor()
        self.resendButton.alpha = 1.0
        if index%2 == 0 {
            resendButton.isHidden = true
        } else {
            resendButton.isHidden = false
        }
        buttonSetup()
        self.handle = complition
    }
    
    func buttonSetup() {
        resendButton.setButtonTitle(title: "Resend",titleColor: UIColor.blue)
        resendButton.setButtonFont(fSize: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fName: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
        resendButton.populateView(complition: buttonHandler(action:))
    }
    
    func buttonHandler(action: NeumorphicButtonAction) {
        print("resend tapped")
        self.handle?(.resend)
        UIView.animate(withDuration: 0.1) {
            self.resendButton.alpha = 0.0
            self.resendButton.isHidden = true
        }
        
    }
}
