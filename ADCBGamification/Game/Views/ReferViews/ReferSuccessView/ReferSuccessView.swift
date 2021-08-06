//
//  ReferSuccessView.swift
//  ADCBGamification
//
//  Created by SKY on 08/07/21.
//

import UIKit
enum ReferSuccessViewAction {
    case referAgain
    case homePageTapped
}

class ReferSuccessView: UIView {
    
    @IBOutlet weak var rewardButton: UIButton!
    @IBOutlet weak var knowMoreButton: UIButton!
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var spinAgainButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var goToLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bgCloudImage: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    var handle:((ReferSuccessViewAction)->Void)?
    
    static func loadXib() -> ReferSuccessView {
        return UINib(nibName: "ReferSuccessView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! ReferSuccessView
    }
    
    func populateView(info: SpinAssignReward?,action:((ReferSuccessViewAction)->Void)?) {
        self.handle = action
        appearanceSetup()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
       // setupLabel(info: info)
    }
    
    func setupFontFamily() {
        
        logoImageView.image = UIImage(named: (StoreManager.shared.language == "AR") ? "Logo_Arabic" : "Logo", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        
        headerLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 20.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        descLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        goToLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
    }
    
    
    func setupLabel(info: SpinAssignReward?) {
        setupFontFamily()
        self.descLabel.text = info?.responseObject?.first?.displayDetails?.first?.name ?? ""
        
        let fontDict: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? UIFont(name: "Tajawal-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5) : UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5),
            NSAttributedString.Key.underlineStyle : 1,
            NSAttributedString.Key.foregroundColor :  UIColor(hexString: "#222165")
            
        ]
        let rewardAttString = NSMutableAttributedString()
        rewardAttString.append(NSAttributedString(string: "Refer Again".localized(), attributes: fontDict))
        self.rewardButton.setAttributedTitle(rewardAttString, for: .normal)
        
        
        let homeAttString = NSMutableAttributedString()
        homeAttString.append(NSAttributedString(string: "Homepage".localized(), attributes: fontDict))
        self.homePageButton.setAttributedTitle(homeAttString, for: .normal)
    }
    
    func appearanceSetup() {
        containerView.addShadow(cornerRadius: 20, shadowRadius: 3, opacity: 0.5, color: UIColor.black)
    }
    
    @IBAction func reFerAgainButtonAction() {
        handle?(.referAgain)
    }
    
    @IBAction func rewardButtonAction() {
        //handle?(.rewardTapped)
    }
    
    @IBAction func knowMoreButtonAction() {
        //handle?(.knowMoreTapped)
    }
    
    @IBAction func homePageButtonAction() {
        handle?(.homePageTapped)
    }
    
    @IBAction func spinAgainButtonAction() {
        //handle?(.spinAgainTapped)
    }
    
}
