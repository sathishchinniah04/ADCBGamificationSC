//
//  SpinFailView.swift
//  ADCBGamification
//
//  Created by SKY on 22/07/21.
//

import UIKit

class SpinFailView: UIView {
    
    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var goToLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var homePageButton: UIButton!
    
    var handle:((SpinFailViewAction)->Void)?
    
    static func loadXib() -> SpinFailView {
        return UINib(nibName: "SpinFailView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! SpinFailView
    }
    
    func populateView(action:((SpinFailViewAction)->Void)?) {
        self.handle = action
        appearanceSetup()
    }
    
    func appearanceSetup() {
        self.titleLable.text = "Oh no!".localized()
        self.goToLabel.text = "Go To".localized()
        self.messageLabel.text = "Better luck next time!".localized()
        self.titleHeaderLabel.text = "simply".localized()
        self.subTitleLabel.text = "life".localized()
        if let attributedTitle = self.homePageButton.attributedTitle(for: .normal) {
            let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
            mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: "Homepage".localized())
            self.homePageButton.setAttributedTitle(mutableAttributedTitle, for: .normal)
        }
        
        containerView.addShadow(cornerRadius: 20, shadowRadius: 3, opacity: 0.5, color: UIColor.black)
        bounceAnimation(imageView)

    }
    
    @IBAction func homePageButtonAction() {
        handle?(.gamePage)
    }
}


