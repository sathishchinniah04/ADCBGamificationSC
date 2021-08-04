//
//  PredictSuccessView.swift
//  ADCBGamification
//
//  Created by SKY on 11/07/21.
//

import UIKit
enum PredictSuccessViewAction {
    case share
    case homePage
}
class PredictSuccessView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var shareButton: NeumorphicButton!
    
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var bgCloudImage: UIImageView!
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var goToLbl: UILabel!
    
    
    let blueColor = UIColor(red: 34.0/256.0, green: 33.0/256.0, blue: 101.0/256.0, alpha: 1.0)
    
    var handle:((PredictSuccessViewAction)->Void)?
    
    static func loadXib() -> PredictSuccessView {
        UINib(nibName: "PredictSuccessView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! PredictSuccessView
    }
        
    func populateView(complition: ((PredictSuccessViewAction)->Void)?) {
        self.handle = complition
        cornerRadius()
        neumorphicEffect()
        setupFontFamily()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
    }
    
    func setupFontFamily() {
        
        headerLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 20.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        messageLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        goToLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        let fontDict: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? UIFont(name: "Tajawal-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5) : UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5),
            NSAttributedString.Key.underlineStyle : 1,
            NSAttributedString.Key.foregroundColor :  UIColor(hexString: "#222165")
            
        ]
        let rewardAttString = NSMutableAttributedString()
        rewardAttString.append(NSAttributedString(string: "Game page".localized(), attributes: fontDict))
        self.homePageButton.setAttributedTitle(rewardAttString, for: .normal)
  
    }
    
    func neumorphicEffect() {
        shareButton.populateView(complition: shareButtonActionHandler(action:))
        shareButton.buttonState(isPressed: true)
        shareButton.setButtonTitle(title: "Share")
        shareButton.setButtonFont(fSize: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fName: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
                                  
        shareButton.button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        shareButton.button.setTitleColor(blueColor, for: .normal)
    }
    
    func shareButtonActionHandler(action: NeumorphicButtonAction) {
        handle?(.share)
    }
    
    func cornerRadius() {
        containerView.addShadow(cornerRadius: 10, shadowRadius: 4, opacity: 0.4, color: UIColor.black)
    }
    
    @IBAction func homepageButtonAction() {
        handle?(.homePage)
    }
}
