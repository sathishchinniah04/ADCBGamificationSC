//
//  ExpireView.swift
//  Gamification
//
//  Created by SKY on 19/06/21.
//

import UIKit

class ExpireView: UIView {
    
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameNameSubTitleLabel: UILabel!
    @IBOutlet weak var expireLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var genericButton: GenericNeumorphicButton!
    
    
    private var termsView = TermsViewHelper()
    private var handler: (()->Void)?
    private var isShowTerms: Bool = true
    private var game: Games?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    @IBInspectable var mainStackSpace: CGFloat = 50 {
        didSet {
            containerStackView.spacing = mainStackSpace
        }
    }
    
    @IBInspectable var secondStackSpace: CGFloat = 20 {
        didSet {
            secondStackView.spacing = secondStackSpace
        }
    }
    
    @IBInspectable var hidePlayButton: Bool = false {
        didSet {
            genericButton.button.isHidden = hidePlayButton
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initialSetup()
    }
    
    func loadNib() -> UIView {
        return UINib(nibName: "ExpireView", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    private func initialSetup() {
        let view = loadNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        addSubview(view)
        
        containerStackView.spacing = mainStackSpace
        secondStackView.spacing = secondStackSpace
        setupFontFamily()
    }
    
    func setupFontFamily() {
        
        gameNameLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 20.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        gameNameSubTitleLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        descLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-ExtraLight" : "OpenSans-Light")
        
        expireLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Light")
    }
    
    func populateView(isShowTerms: Bool = true, game: Games?, complition: (()->Void)?) {
        self.game = game
        self.isShowTerms = isShowTerms
        self.handler = complition
        setupLabel()
        guard let gam = game else { return }
        CustomTimer.shared.startTimer {
            self.checkGameStatus(game: gam)
        }
        checkGameStatus(game: gam)
        labelSetup(game: gam)
        self.genericButton.tapHandler = {
            if isShowTerms {
                self.termsView.show {
                    print("fsdfsdfdss")
                    self.handler?()
                }
            } else {
                self.handler?()
            }
        }
        
    }
    
    
    func labelSetup(game: Games) {
        gameNameLabel.text = game.displayDetails?.name
        //gameNameSubTitleLabel.text = game.displayDetails?.synonym   //game.gameType
        descLabel.text = game.displayDetails?.description ?? ""
        
        if game.gameType == "PredictNWin" {
            gameNameSubTitleLabel.text = "Play and win exciting rewards!".localized()
        } else if game.gameType == "SpinNWin" {
            expireLabel.text = ""
            gameNameSubTitleLabel.text = "Spin the wheel and win exciting prizes".localized()
       } else if game.gameType == "ReferNWin" {
        gameNameSubTitleLabel.text = "Invite your friends to join Simplylife and earn exciting rewards".localized()
       }
    }
    
    func checkGameStatus(game: Games) {
        if game.executionStatus == "Active" {
            onActive(game: game)
        } else {
            onLock(game: game)
        }
    }
    
    func onLock(game: Games) {
        genericButton.alpha = 0.15
        genericButton.isUserInteractionEnabled = false
        let date = game.executionPeriod?.startDateTime ?? ""
        hourMinteAlignmentCheck(date: date, value: "Available in".localized())
    }
    
    func onActive(game: Games) {
        genericButton.alpha = 1.0
        genericButton.isUserInteractionEnabled = true
        let date = game.executionPeriod?.endDateTime ?? ""
        hourMinteAlignmentCheck(date: date, value: "Expires in".localized())
    }
    
    func hourMinteAlignmentCheck(date: String, value: String) {
        DispatchQueue.main.async {
            if self.game?.gameType != "SpinNWin" {
                self.expireLabel.text = value + " \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).0)" + "h".localized() + "\(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).1)" + "min".localized() + "\(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).2)" + "sec".localized()
            } else {
                self.expireLabel.text = ""
            }
        }
    }
    
    func setupButtonName(name: String) {
        self.genericButton.setupButtonName(name: name)
        self.genericButton.setupButtonFontName(fSize: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fName: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-SemiBold")
    }
    
    func setupLabel() {
        gameNameLabel.text = "Refer & Win".localized()
        if self.game?.gameType != "SpinNWin" {
            expireLabel.text = "Expire on".localized() +  "02" + "h".localized() + "33" + "mins".localized()
        } else {
            expireLabel.text = ""
        }
    }
    
}
