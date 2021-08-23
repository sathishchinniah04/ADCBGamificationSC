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
    @IBOutlet weak var bgCloudImage: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    var handle:((SpinFailViewAction)->Void)?
    
    static func loadXib() -> SpinFailView {
        return UINib(nibName: "SpinFailView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! SpinFailView
    }
    
    func populateView(action:((SpinFailViewAction)->Void)?) {
        self.handle = action
        appearanceSetup()
        checkLeftToRight()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
    }
    
    func appearanceSetup() {
        self.titleHeaderLabel.isHidden = true
        self.subTitleLabel.isHidden = true
        
        logoImageView.image = UIImage(named: (StoreManager.shared.language == "AR") ? "Logo_Arabic" : "Logo", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        
        setupFontFamily()
        self.titleLable.text = "Oh no!".localized()
        self.goToLabel.text = "Go To".localized()
        self.messageLabel.text = "Better luck next time!".localized()
        //self.titleHeaderLabel.text = "simply".localized()
        //self.subTitleLabel.text = "life".localized()
        
        
        let fontDict: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? UIFont(name: "Tajawal-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5) : UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5),
            NSAttributedString.Key.underlineStyle : 1,
            NSAttributedString.Key.foregroundColor :  UIColor(hexString: "#222165")
            
        ]
        let homeAttString = NSMutableAttributedString()
        homeAttString.append(NSAttributedString(string: "Homepage".localized(), attributes: fontDict))
        self.homePageButton.setAttributedTitle(homeAttString, for: .normal)
    
       /* if let attributedTitle = self.homePageButton.attributedTitle(for: .normal) {
            let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
            mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: "Homepage".localized())
            self.homePageButton.setAttributedTitle(mutableAttributedTitle, for: .normal)
        } */
        
        containerView.addShadow(cornerRadius: 20, shadowRadius: 3, opacity: 0.5, color: UIColor.black)
        bounceAnimation(imageView)

    }
    
    
    func setupFontFamily() {
        
        titleLable.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 20.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        messageLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        goToLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
    }
    @IBAction func gameBtnTap(_ sender: Any) {
        handle?(.gamePage)
    }
    
    @IBAction func homePageButtonAction() {
        handle?(.homePage)

    }
}


