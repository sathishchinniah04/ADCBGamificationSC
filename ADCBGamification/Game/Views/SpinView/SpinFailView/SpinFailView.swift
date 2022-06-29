//
//  SpinFailView.swift
//  ADCBGamification
//
//  Created by SKY on 22/07/21.
//

import UIKit
//import AdjustSdk

class SpinFailView: UIView {
    
    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var goToLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var gamePageButton: UIButton!
    @IBOutlet weak var bgCloudImage: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var spinAgainButton: UIButton!
    
    var handle:((SpinFailViewAction)->Void)?
    var gameObjects: Games?
    var responseObj: SpinAssignReward?
    
    static func loadXib() -> SpinFailView {
        return UINib(nibName: "SpinFailView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! SpinFailView
    }
    
    func populateView(info: SpinAssignReward?, action:((SpinFailViewAction)->Void)?, game: Games?) {
        self.handle = action
        self.responseObj = info
        self.gameObjects = game
        appearanceSetup()
        checkLeftToRight()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
    }
    
    func appearanceSetup() {
//        let event = ADJEvent(eventToken: "285ipt")
        //Adjust.trackEvent(event)
        self.titleHeaderLabel.isHidden = true
        self.subTitleLabel.isHidden = true
        
        logoImageView.image = UIImage(named: (StoreManager.shared.language == "AR") ? "Logo_Arabic" : "Logo", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        
        setupFontFamily()
        self.titleLable.text = "Oh no!".localized()
        self.goToLabel.text = "Go To".localized()
        self.messageLabel.text = "Better luck next time!".localized()
        //self.titleHeaderLabel.text = "simply".localized()
        //self.subTitleLabel.text = "life".localized()
        
        
        if (gameObjects?.frequency.first?.frequencyValue == "1" ||  gameObjects?.frequency.first?.frequencyValue == "0" ) {
            spinAgainButton.isHidden = true
        } else {
            if let remainingChance = Int(self.responseObj?.responseObject?.first?.chancesRemaining ?? "0"), remainingChance >= 1 {
                spinAgainButton.isHidden = false
            } else {
                spinAgainButton.isHidden = true
            }
        }
        
        
        let fontDict: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? UIFont(name: "Tajawal-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5) : UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5),
            NSAttributedString.Key.underlineStyle : 0,
            NSAttributedString.Key.foregroundColor :  UIColor(hexString: "#222165")
            
        ]
        let homeAttString = NSMutableAttributedString()
        homeAttString.append(NSAttributedString(string: "Homepage".localized(), attributes: fontDict))
        self.homePageButton.setAttributedTitle(homeAttString, for: .normal)
        
        
        let homeLine = UIView()
        homeLine.translatesAutoresizingMaskIntoConstraints = false
        homeLine.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1294117647, blue: 0.3960784314, alpha: 1)
        self.homePageButton.addSubview(homeLine)
        self.homePageButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", metrics: nil, views: ["line":homeLine]))
        self.homePageButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(1)]-(\(+4))-|", metrics: nil, views: ["line":homeLine]))
        
        
        
        let gameAttString = NSMutableAttributedString()
        gameAttString.append(NSAttributedString(string: "Games".localized(), attributes: fontDict))
        self.gamePageButton.setAttributedTitle(gameAttString, for: .normal)
        
        let gameLine = UIView()
        gameLine.translatesAutoresizingMaskIntoConstraints = false
        gameLine.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1294117647, blue: 0.3960784314, alpha: 1)
        self.gamePageButton.addSubview(gameLine)
        self.gamePageButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", metrics: nil, views: ["line":gameLine]))
        self.gamePageButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(1)]-(\(+4))-|", metrics: nil, views: ["line":gameLine]))
        
        
    
        let spinAttString = NSMutableAttributedString()
        spinAttString.append(NSAttributedString(string: "Spin again".localized(), attributes: fontDict))
        self.spinAgainButton.setAttributedTitle(spinAttString, for: .normal)
        
        let spinLine = UIView()
        spinLine.translatesAutoresizingMaskIntoConstraints = false
        spinLine.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1294117647, blue: 0.3960784314, alpha: 1)
        self.spinAgainButton.addSubview(spinLine)
        self.spinAgainButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", metrics: nil, views: ["line":spinLine]))
        self.spinAgainButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(1)]-(\(+4))-|", metrics: nil, views: ["line":spinLine]))
        
        
        
        
       /* if let attributedTitle = self.homePageButton.attributedTitle(for: .normal) {
            let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
            mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: "Homepage".localized())
            self.homePageButton.setAttributedTitle(mutableAttributedTitle, for: .normal)
        } */
        
        self.spinAgainButton.setTitle("Spin again".localized(), for: .normal)
        
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
    
    @IBAction func spinAgainButtonAction() {
        Constants.referMessage = ""
        handle?(.spinAgainTapped)
    }
}


