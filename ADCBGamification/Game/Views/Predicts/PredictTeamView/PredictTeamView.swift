//
//  PredictTeamView.swift
//  ADCBGamification
//
//  Created by SKY on 05/07/21.
//

import UIKit

class PredictTeamView: UIView {
    var view: UIView?
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var firstTeamNameLabel: UILabel!
    @IBOutlet weak var firstTeamCharLabel: UILabel!
    @IBOutlet weak var secondTeamCharLabel: UILabel!
    @IBOutlet weak var secondTeamNameLabel: UILabel!
    @IBOutlet weak var firstTeamImageView: UIImageView!
    @IBOutlet weak var secondTeamImageView: UIImageView!
    @IBOutlet weak var firstTeamImageContainerView: UIView!
    @IBOutlet weak var secondTeamImageContainerView: UIView!
    
    func loadXib() -> UIView {
        return UINib(nibName: "PredictTeamView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initialSetup()
        setupFontFamily()
    }
    
    func initialSetup() {
        view = loadXib()
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view!)
    }
    
    func setupFontFamily() {
        
        leagueNameLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
        
        timeLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  10.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Light" : "OpenSans-Light")
        
        
        firstTeamNameLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  12.0 : 12.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        firstTeamCharLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-ExtraBold" : "OpenSans-ExtraBold")
        
        
        secondTeamNameLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  12.0 : 12.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        secondTeamCharLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-ExtraBold" : "OpenSans-ExtraBold")
    }
    
    func extraPopulation(time: String) {
        
    }
    
    func populateView(index: Int, info: EventsList?) {
        DispatchQueue.main.async {
            //self.appearenceSetup()
            self.labelSetup(index: index, info: info)
            //self.getChars(index: index, info: info)
        }
    }
    
    func getChars(index: Int, info: EventsList?) {
        guard let inf = info else { return }
        let nameFArr = inf.opponentASynonym?.components(separatedBy: " ")
        guard let fArr = nameFArr else { return }
        if fArr.isEmpty{return}
        
        if fArr.count>=2 {
            let fc = fArr[0].first?.description ?? ""
            let sc = fArr[1].first?.description ?? ""
            firstTeamCharLabel.text = fc + " " + sc
            
        } else {
            let fc = fArr[0].first?.description ?? ""
            firstTeamCharLabel.text = fc
        }
        
        let nameSArr = inf.opponentBSynonym?.components(separatedBy: " ")
        guard let fSrr = nameSArr else { return }
        if fSrr.isEmpty{return}
        
        if fSrr.count>=2 {
            let fc = fSrr[0].first?.description ?? ""
            let sc = fSrr[1].first?.description ?? ""
            secondTeamCharLabel.text = fc + " " + sc
            
        } else {
            let fc = fSrr[0].first?.description ?? ""
            secondTeamCharLabel.text = fc
        }
    }
    
    func labelSetup(index: Int, info: EventsList?) {
        guard let inf = info else { return }
        //leagueNameLabel.text = inf.
       // guard let events = inf else { return }
       // imageSetup(info: inf)
        //inf.opponentASynonym  inf.opponentBSynonym
        leagueNameLabel.text = Constants.leagueName
        firstTeamNameLabel.text = inf.OpponentA
        secondTeamNameLabel.text = inf.OpponentB
        
        firstTeamCharLabel.text = inf.opponentASynonym
        secondTeamCharLabel.text = inf.opponentBSynonym
        
        let currMatachDate = Utility.convertDateWithFormat(inputDate: inf.MatchDate ?? "", currFormat: "yyyy-MM-dd", expFormat: "yyyy-MM-dd HH:mm:ss")
        
        let numberOfDays = Calendar.current.dateComponents([.day], from: Date(), to: Utility.convertStringToDate(date: currMatachDate )).day ?? 0
        hourMinteAlignmentCheck(date: inf.MatchDate ?? "", value: numberOfDays)
    }
    
    
    
    func hourMinteAlignmentCheck(date: String, value: Int) {
        
        //let matchDate = Utility.convertStringToDate(date: date)
        
        let currMatachDate = Utility.convertDateWithFormat(inputDate: date, currFormat: "yyyy-MM-dd", expFormat: "yyyy-MM-dd HH:mm:ss")
        
        let matchDate = Utility.convertStringToDate(date: currMatachDate)
        
//        if matchDate < Date() {
//            self.timeLabel.text = "Expired on".localized() + " \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).0) " + "hr".localized() + " \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).1) " + "min".localized()
//        } else {
        
            DispatchQueue.main.async {
                
                var daysCount = ""
                
                if value == 0 {
                    daysCount = "Today".localized()
                } else if value > 1 {
                    daysCount = "\(value)" + "day(s)".localized()
                } else {
                    daysCount = "\(value)" + "day".localized()
                }
             
                let expDate = Utility.convertStringToDate(date: date)
                
                let calendar = Calendar.current

                let currentDateComp = calendar.dateComponents([.hour, .minute], from: Date())
                
                let expDateComp = calendar.dateComponents([.hour, .minute], from: expDate)
                
                var hours =  Int(currentDateComp.hour ?? 0) - Int(expDateComp.hour ?? 0)
            
                let min = Int(currentDateComp.minute ?? 0) - Int(expDateComp.minute ?? 0)
                
                if (hours == 0 && min == 0 ) {
                    hours = 12
                }
                
                if matchDate < Date() {
                    self.timeLabel.text = "Expired on".localized() + " \(abs(expDateComp.hour ?? 0))" + "hr".localized() + " \(abs(expDateComp.minute ?? 0))" + "mins".localized()
                } else {
                    if value == 0 {
                        self.timeLabel.text = "Today, Starts in".localized() + " \(abs(hours))" + "hr".localized() + " \(abs(min))" + "mins".localized()

                    } else {
                        self.timeLabel.text = "Starts in".localized() + " \(daysCount)" + " \(abs(hours))" + "hr".localized() + " \(abs(min))" + "mins".localized()

                    }
                }



                //self.timeLabel.text = daysCount + " \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).0) " + "hr".localized() + " \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).1) " + "min".localized()
            }
        //}

        //\(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).2)sec"
    }
    
    func imageSetup(info: EventsList) {
        firstTeamImageView.image = UIImage(named: info.imageCardOppenentA ?? "")
        secondTeamImageView.image = UIImage(named: info.imageCardOppenentB ?? "")
        //imageCardOppenentA
    }
    
    func appearenceSetup() {
        firstTeamImageContainerView.layer.cornerRadius = firstTeamImageContainerView.frame.height/2
        secondTeamImageContainerView.layer.cornerRadius = secondTeamImageContainerView.frame.height/2
        firstTeamImageContainerView.layer.borderWidth = 3
        firstTeamImageContainerView.layer.borderColor = UIColor.white.cgColor
        secondTeamImageContainerView.layer.borderWidth = 3
        secondTeamImageContainerView.layer.borderColor = UIColor.white.cgColor
        self.firstTeamImageView.addImgShadow(cornerRadius: firstTeamImageView.frame.height/2,shadowRadius: 4, opacity: 0.3)
        self.secondTeamImageView.addImgShadow(cornerRadius: firstTeamImageView.frame.height/2, shadowRadius: 4, opacity: 0.5)
        firstTeamImageContainerView.addShadow(cornerRadius: firstTeamImageContainerView.frame.height/2,shadowRadius: 4, opacity: 0.3)
        secondTeamImageContainerView.addShadow(cornerRadius: secondTeamImageContainerView.frame.height/2,shadowRadius: 4, opacity: 0.3)
    }
}
