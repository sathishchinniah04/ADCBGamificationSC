//
//  ExpireView.swift
//  Gamification
//
//  Created by SKY on 19/06/21.
//

import UIKit

class ExpireView: UIView {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameNameSubTitleLabel: UILabel!
    @IBOutlet weak var expireLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
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
            button.isHidden = hidePlayButton
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
        button.addCustomShadow(cornerRadius: 10, shadowRadius: 4, opacity: 0.3, color: UIColor.blue, offSet: CGSize(width: 4, height: 4))
        button.isHidden = hidePlayButton
        containerStackView.spacing = mainStackSpace
        secondStackView.spacing = secondStackSpace
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
    }
    
    func labelSetup(game: Games) {
        gameNameLabel.text = game.gameTitle
        gameNameSubTitleLabel.text = game.gameType ?? ""
        descLabel.text = game.displayDetails?.description ?? ""
    }
    
    func checkGameStatus(game: Games) {
        if game.executionStatus == "Active" {
            onActive(game: game)
        } else {
            onLock(game: game)
        }
    }
    
    func onLock(game: Games) {
        button.alpha = 0.15
        button.isUserInteractionEnabled = false
        let date = game.executionPeriod?.startDateTime ?? ""
        hourMinteAlignmentCheck(date: date, value: "Available in")
    }
    
    func onActive(game: Games) {
        button.alpha = 1.0
        button.isUserInteractionEnabled = true
        let date = game.executionPeriod?.endDateTime ?? ""
        hourMinteAlignmentCheck(date: date, value: "Expires in")
    }
    
    func hourMinteAlignmentCheck(date: String, value: String) {
        DispatchQueue.main.async {
            self.expireLabel.text = value + " \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).0)h  \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).1)min \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).2)sec"
        }
    }
    
    func setupButtonName(name: String) {
        button.setTitle(name, for: .normal)
    }
    
    func setupLabel() {
        gameNameLabel.text = "Refer & Win"
        expireLabel.text = "Expire is 02h 33mins"
    }
    
    @IBAction func playButtonAction() {
        if isShowTerms {
            termsView.show {
                print("fsdfsdfdss")
                self.handler?()
            }
        } else {
            self.handler?()
        }
    }
    
}
