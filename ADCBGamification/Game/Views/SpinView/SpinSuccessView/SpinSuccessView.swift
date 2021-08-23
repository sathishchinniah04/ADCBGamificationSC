//
//  SpinSuccessView.swift
//  ADCBGamification
//
//  Created by SKY on 08/07/21.
//

import UIKit
enum SpinSuccessViewAction {
    case rewardTapped
    case knowMoreTapped
    case homePageTapped
    case spinAgainTapped
    case gameTapped
}

class SpinSuccessView: UIView {
    
    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var goToLabel: UILabel!
    @IBOutlet weak var rewardButton: UIButton!
    @IBOutlet weak var knowMoreButton: UIButton!
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var spinAgainButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bgCloudImage: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    var handle:((SpinSuccessViewAction)->Void)?
    
    static func loadXib() -> SpinSuccessView {
        return UINib(nibName: "SpinSuccessView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! SpinSuccessView
    }
    
    func populateView(info: SpinAssignReward?,action:((SpinSuccessViewAction)->Void)?) {
        self.handle = action
        appearanceSetup()
        setupLabel(info: info)
        checkLeftToRight()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
    }
    
    func setupFontFamily() {
        
        titleLable.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 20.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        descLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        goToLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
    }
    
    func setupLabel(info: SpinAssignReward?) {
        
        logoImageView.image = UIImage(named: (StoreManager.shared.language == "AR") ? "Logo_Arabic" : "Logo", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        
        titleHeaderLabel.isHidden = true
        subTitleLabel.isHidden = true
        setupFontFamily()
        self.titleLable.text = "Hurray!".localized()
        self.goToLabel.text = "Go To".localized()
        //self.titleHeaderLabel.text = "simply".localized()
        //self.subTitleLabel.text = "life".localized()

        let fontDict: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? UIFont(name: "Tajawal-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5) : UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5),
            NSAttributedString.Key.underlineStyle : 1,
            NSAttributedString.Key.foregroundColor :  UIColor(hexString: "#222165")
            
        ]
        let rewardAttString = NSMutableAttributedString()
        rewardAttString.append(NSAttributedString(string: "Rewards".localized(), attributes: fontDict))
        self.rewardButton.setAttributedTitle(rewardAttString, for: .normal)
        
        
        let homeAttString = NSMutableAttributedString()
        homeAttString.append(NSAttributedString(string: "Homepage".localized(), attributes: fontDict))
        self.homePageButton.setAttributedTitle(homeAttString, for: .normal)
        
        let spinAttString = NSMutableAttributedString()
        spinAttString.append(NSAttributedString(string: "Spin Again".localized(), attributes: fontDict))
        self.spinAgainButton.setAttributedTitle(spinAttString, for: .normal)

  
        
      /*  if let rewardsAttributedTitle = self.rewardButton.attributedTitle(for: .normal) {
            let mutableAttributedTitle = NSMutableAttributedString(attributedString: rewardsAttributedTitle)
            mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: "Rewards".localized())
            self.rewardButton.setAttributedTitle(mutableAttributedTitle, for: .normal)
        }
        
        if let homeAttributedTitle = self.rewardButton.attributedTitle(for: .normal) {
            let mutableAttributedTitle = NSMutableAttributedString(attributedString: homeAttributedTitle)
            mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: "Homepage".localized())
            self.homePageButton.setAttributedTitle(mutableAttributedTitle, for: .normal)
        }
        
        if let spinAttributedTitle = self.rewardButton.attributedTitle(for: .normal) {
            let mutableAttributedTitle = NSMutableAttributedString(attributedString: spinAttributedTitle)
            mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: "Spin Again".localized())
            self.spinAgainButton.setAttributedTitle(mutableAttributedTitle, for: .normal)
        } */
        
        //self.rewardButton.setTitle("Rewards".localized(), for: .normal)
        //self.homePageButton.setTitle("Homepage".localized(), for: .normal)
        self.spinAgainButton.setTitle("Spin Again".localized(), for: .normal)
        
        self.descLabel.text = info?.responseObject?.first?.displayDetails?.first?.name ?? ""
    }
    
    func appearanceSetup() {
        
        containerView.addShadow(cornerRadius: 20, shadowRadius: 3, opacity: 0.5, color: UIColor.black)
        bounceAnimation(imageView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.handle?(.knowMoreTapped)
        }
    }
    
   /* @IBAction func rewardButtonAction() {
        handle?(.rewardTapped)
    } */
    
    @IBAction func gameBtnTap() {
        handle?(.gameTapped)
    }
    
    @IBAction func knowMoreButtonAction() {
        handle?(.knowMoreTapped)
    }
    
    @IBAction func homePageButtonAction() {
        //handle?(.homePageTapped)
        
        
    }
    
    @IBAction func spinAgainButtonAction() {
        handle?(.spinAgainTapped)
    }
    
}
