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
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var resendButton: NeumorphicButton!
    private var handle:((HistoryTableViewCellAction)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
