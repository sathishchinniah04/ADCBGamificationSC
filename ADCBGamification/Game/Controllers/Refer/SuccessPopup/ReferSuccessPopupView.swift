//
//  ReferSuccessPopupView.swift
//  Gamification
//
//  Created by SKY on 19/06/21.
//

import UIKit

class ReferSuccessPopupView: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var successImageView: UIImageView!
    @IBOutlet weak var titleTopLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var responceMessageLabel: UILabel!
    @IBOutlet weak var continueButton: NeumorphicButton!
    var handle:(()->Void)?
    static func loadXib() ->ReferSuccessPopupView {
        return UINib(nibName: "ReferSuccessPopupView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! ReferSuccessPopupView
    }
    
    func populateView(complition:(()->Void)?) {
        setupButton()
        setupLabel()
        self.containerView.addShadow(cornerRadius: 10, shadowRadius: 5, opacity: 0.5)
        self.handle = complition
    }
    
    func setupLabel() {
        titleTopLabel.text = "Successful"
        responceMessageLabel.text = "Invite refferal has been sent succesfully"
        informationLabel.text = "Once app is installed by the invitee, You will recieve points."
    }
    
    func setupButton() {
        continueButton.setButtonTitle(title: "Continue",titleColor: UIColor.blue)
        continueButton.populateView { (action) in
            self.handle?()
        }
    }
    
}
