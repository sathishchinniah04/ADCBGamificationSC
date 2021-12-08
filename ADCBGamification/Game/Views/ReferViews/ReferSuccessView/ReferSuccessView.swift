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
    case gamePage
}

class ReferSuccessView: UIView {
    
    @IBOutlet weak var rewardButton: UIButton!
    @IBOutlet weak var knowMoreButton: UIButton!
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var gamesButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var goToLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bgCloudImage: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    var referalStatus : ReferralStatus?
    @IBOutlet weak var referHeaderImage: UIImageView!
    @IBOutlet weak var lottiReferralAnimationView: AnimationView!
    @IBOutlet weak var goTYoText: UIStackView!
    
    @IBOutlet weak var subMessageLbl: UILabel!
    
    var txtMessage: String?
    private var referralAnimationView: AnimationView?
    var handle:((ReferSuccessViewAction)->Void)?
    
    static func loadXib() -> ReferSuccessView {
        return UINib(nibName: "ReferSuccessView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! ReferSuccessView
    }
    
    func populateView(info: SpinAssignReward?, status: ReferralStatus, action:((ReferSuccessViewAction)->Void)?) {
        self.handle = action
        appearanceSetup()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        setupLabel(info: info, status: status)
    }
    
    func animationSetUp() {
        referralAnimationView = .init(name: "tick_back_animation")
        referralAnimationView!.frame = lottiReferralAnimationView.bounds
        referralAnimationView!.contentMode = .scaleAspectFit
        referralAnimationView!.loopMode = .loop
        lottiReferralAnimationView.addSubview(referralAnimationView!)
        self.referralAnimationView?.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.referralAnimationView?.stop()
            self.lottiReferralAnimationView.isHidden = true
        }
    }
    
    func setupFontFamily() {
        logoImageView.image = UIImage(named: (StoreManager.shared.language == "AR") ? "Logo_Arabic" : "Logo", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        
        headerLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 20.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        descLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        goToLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
    }
    
    
    func setupLabel(info: SpinAssignReward?, status: ReferralStatus?) {
        setupFontFamily()
        goToLabel.text = "Go To".localized()
        subMessageLbl.text = "x".localized()
        let fontDict: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? UIFont(name: "Tajawal-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5) : UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5),
            NSAttributedString.Key.underlineStyle : 0,
            NSAttributedString.Key.foregroundColor :  UIColor(hexString: "#222165")
            
        ]
        let rewardAttString = NSMutableAttributedString()
        rewardAttString.append(NSAttributedString(string: "Refer a friend".localized(), attributes: fontDict))
        self.rewardButton.setAttributedTitle(rewardAttString, for: .normal)
        
        let rewardLine = UIView()
        rewardLine.translatesAutoresizingMaskIntoConstraints = false
        rewardLine.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1294117647, blue: 0.3960784314, alpha: 1)
        self.rewardButton.addSubview(rewardLine)
        self.rewardButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", metrics: nil, views: ["line":rewardLine]))
        self.rewardButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(1)]-(\(+4))-|", metrics: nil, views: ["line":rewardLine]))
        
        
        let homeAttString = NSMutableAttributedString()
        homeAttString.append(NSAttributedString(string: "Homepage".localized(), attributes: fontDict))
        self.homePageButton.setAttributedTitle(homeAttString, for: .normal)
        
        let homeLine = UIView()
        homeLine.translatesAutoresizingMaskIntoConstraints = false
        homeLine.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1294117647, blue: 0.3960784314, alpha: 1)
        self.homePageButton.addSubview(homeLine)
        self.homePageButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", metrics: nil, views: ["line":homeLine]))
        self.homePageButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(1)]-(\(+4))-|", metrics: nil, views: ["line":homeLine]))
        
        
        
        let gamesAttString = NSMutableAttributedString()
        gamesAttString.append(NSAttributedString(string: "Games".localized(), attributes: fontDict))
        self.gamesButton.setAttributedTitle(gamesAttString, for: .normal)
        
        let gameLine = UIView()
        gameLine.translatesAutoresizingMaskIntoConstraints = false
        gameLine.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1294117647, blue: 0.3960784314, alpha: 1)
        self.gamesButton.addSubview(gameLine)
        self.gamesButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", metrics: nil, views: ["line":gameLine]))
        self.gamesButton.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(1)]-(\(+4))-|", metrics: nil, views: ["line":gameLine]))
        
        
        if status == .failure {
            self.subMessageLbl.isHidden = true
            self.headerLabel.text = "Something went wrong".localized()
            self.headerLabel.textColor = #colorLiteral(red: 0.6196078431, green: 0.09803921569, blue: 0.08235294118, alpha: 1)
            self.descLabel.text = "Your invite was not sent. Please try again".localized()
            self.referHeaderImage.image = UIImage(named: "referFail", in: Bundle(for: ReferSuccessView.self), compatibleWith: nil)

        } else if status == .success  {
            self.animationSetUp()
            self.subMessageLbl.isHidden = false
            self.headerLabel.text = "Successful".localized()
            self.headerLabel.textColor = #colorLiteral(red: 0.1333333333, green: 0.1294117647, blue: 0.3960784314, alpha: 1)
            self.descLabel.text = "The invite has been sent successfully.".localized()
            self.referHeaderImage.image = UIImage(named: "inviteTick", in: Bundle(for: ReferSuccessView.self), compatibleWith: nil)

        }
    }
    
    func appearanceSetup() {
        containerView.addShadow(cornerRadius: 20, shadowRadius: 3, opacity: 0.5, color: UIColor.black)
    }
    
    @IBAction func reFerAgainButtonAction() {
        handle?(.referAgain)
    }
    
    @IBAction func gameButtonAction() {
        handle?(.gamePage)
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
