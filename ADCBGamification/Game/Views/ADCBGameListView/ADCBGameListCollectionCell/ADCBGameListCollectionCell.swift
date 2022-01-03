//
//  ADCBGameListCollectionCell.swift
//  ADCBGamification
//
//  Created by SKY on 13/07/21.
//

import UIKit

enum GameStatus: String, CaseIterable {
    case Active, InActive
}

class ADCBGameListCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var expireInLabel: UILabel!
    @IBOutlet weak var lockDayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    //@IBOutlet weak var logoContainerView: UIImageView!
    @IBOutlet weak var gameLogoImageView: UIImageView!
    @IBOutlet weak var crownBtn: UIButton!
    var timer: Timer?
    var game: Games?
    var crownAction : (() -> Void)? = nil

    //var spinFailView = SpinSuccessViewHelper()
    override func awakeFromNib() {
        super.awakeFromNib()
        crownBtn.isHidden = true
        setupFontFamily()
        //
        // Initialization code
        //        spinFailView.loadScreen { (done) in
        //            self.spinFailView.animateAndRemove()
        //        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.startTimer()
    }
    
    func setupFontFamily() {
        lockDayLabel.text = "Unlocks Tomorrow".localized()
        gameLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        expireInLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  13.0 : 13.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        timeLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  13.0 : 13.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        lockDayLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  13.0 : 13.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")

    }
    
    func populateView(game: Games?, index: Int) {
        self.game = game
        guard let game = game else { return }
        self.startTimer()
        if game.executionStatus?.lowercased() != GameStatus.Active.rawValue.lowercased() {
           disableCell()
        }
        setImage(game: game)
        setLabel(game: game)
        cellColor(index: index)
        cornerRadiusSetup()
//        self.expireInLabel.isHidden = false
//        self.timeLabel.isHidden = false
        lockDayLabel.isHidden = true
    }
    
    func disableCell() {
        DispatchQueue.main.async {
            self.lockDayLabel.isHidden = false
            //self.gameLogoImageView.backgroundColor = TTUtils.uiColor(from: 0xE0E0E0)
            self.containerView.backgroundColor = TTUtils.uiColor(from: 0xEAEAEA)
            self.isUserInteractionEnabled = false
            self.gameLabel.textColor = UIColor.gray
            self.expireInLabel.isHidden = true
            self.timeLabel.isHidden = true
        }
    }
    
    func cornerRadiusSetup() {
        DispatchQueue.main.async {
            self.gameLogoImageView.layer.cornerRadius = self.gameLogoImageView.frame.height/2
            
        }
    }
    
    func cellColor(index: Int) {
        self.containerView.addShadow(cornerRadius: 10, shadowRadius: 3, opacity: 0.1, color: UIColor.black)
        self.containerView.backgroundColor = UIColor.white
    }
    
    func setImage(game: Games) {
        var gameNameImg: String = ""
        
        if game.executionStatus == "Active" {
            if game.gameType == "SpinNWin" {
                gameNameImg = (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "SpinListArabic" : "SpinList"
            } else if game.gameType == "PredictNWin" {
                gameNameImg = (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "PredictListArabic" : "PredictList"
            } else if game.gameType == "ReferNWin" {
                gameNameImg = (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "InviteArabic" : "Invite"
                
            } else {
                gameNameImg = ""
            }
        } else {
//            if game.gameType == "SpinNWin" {
//                gameNameImg = (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "spin-disable-Arabic" : "spin-disable"
//            } else if game.gameType == "PredictNWin" {
//                gameNameImg = (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "predict-disable-Arabic" : "predict-disable"
//            } else if game.gameType == "ReferNWin" {
//                gameNameImg = (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "refer-disable-Arabic" : "refer-disable"
//
//            } else {
//                gameNameImg = ""
//            }
            
            if game.gameType == "SpinNWin" {
                gameNameImg = (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "SpinListArabic" : "SpinList"
            } else if game.gameType == "PredictNWin" {
                gameNameImg = (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "PredictListArabic" : "PredictList"
            } else if game.gameType == "ReferNWin" {
                gameNameImg = (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "InviteArabic" : "Invite"
                
            } else {
                gameNameImg = ""
            }
        }
        

        

        
        
        if game.executionStatus?.lowercased() != GameStatus.Active.rawValue.lowercased() {
            gameLogoImageView.image = UIImage(named: gameNameImg, in: Bundle(for: Self.self), compatibleWith: nil)
                //?.changeInactiveImageColor
        } else {
            gameLogoImageView.image = UIImage(named: gameNameImg, in: Bundle(for: Self.self), compatibleWith: nil)
        }

    }
    
    func startTimer() {
        self.stopTimer()
        DispatchQueue.main.async {
            self.stopTimer()
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func updateTime() {
        guard let game = game else { return }
        //print("running")
        self.setLabel(game: game)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    func setLabel(game: Games) {
        
        if game.gameType == "ReferNWin" {
            self.timeLabel.isHidden = true
            self.expireInLabel.isHidden = true
        }
        
        self.gameLabel.text = game.displayDetails?.name
        //        CustomTimer.shared.startTimer {
        //            self.checkGameStatus(game: game)
        //        }
        self.checkGameStatus(game: game)
    }
    
    func checkGameStatus(game: Games) {
        if game.executionStatus == "Active" {
            onActive(game: game)
        } else {
            onLock(game: game)
        }
    }
    
    func onLock(game: Games) {
        
        let date = game.executionPeriod?.endDateTime ?? ""
        expireInLabel.text = "Expires in".localized()
        let numberOfDays = Calendar.current.dateComponents([.day], from: Date(), to: Utility.convertStringToDate(date: date)).day ?? 0
        hourMinteAlignmentCheck(date: date, value: numberOfDays)
    }
    
    func onActive(game: Games) {

        let date = game.validityPeriod?.endDateTime ?? ""
        expireInLabel.text = "Expires in".localized()
        let numberOfDays = Calendar.current.dateComponents([.day], from: Date(), to: Utility.convertStringToDate(date: date)).day ?? 0
        hourMinteAlignmentCheck(date: date, value: numberOfDays)
    }
    
    func hourMinteAlignmentCheck(date: String, value: Int) {
        
        DispatchQueue.main.async {
            
            var daysCount = ""
            
            if value == 0 {
                daysCount = "Today".localized()
            } else if value > 1 {
                if (StoreManager.shared.language == GameLanguage.AR.rawValue) {
                    daysCount = "\(value) " + "day(s)".localized()
                } else {
                    daysCount = "\(value)" + "day(s)".localized()
                }
                
            } else {
                daysCount = "\(value) " + "day(s)".localized()
            }
            
            
            let expDate = Utility.convertStringToDate(date: date)
            
            let calendar = Calendar.current

            let currentDateComp = calendar.dateComponents([.hour, .minute], from: Date())
            let expDateComp = calendar.dateComponents([.hour, .minute], from: expDate)

            var hours =  Int(expDateComp.hour ?? 0) - Int(currentDateComp.hour ?? 0)
        
            var min = Int(expDateComp.minute ?? 0) - Int(currentDateComp.minute ?? 0)
            
            var currentMinutes = ""
            var currentHours = ""
            
            if min <= 9 {
                currentMinutes = "0" + "\(abs(min))"
            } else {
                currentMinutes = "\(abs(min))"
            }
            
            if hours <= 9 {
                currentHours = "0" + "\(abs(hours))"
            } else {
                currentHours = "\(abs(hours))"
            }

            if (StoreManager.shared.language == GameLanguage.AR.rawValue) {
                
                if !self.lockDayLabel.isHidden {
                    
                    if value == 0 {
                        self.lockDayLabel.text = "Unlocks Today".localized()
                    } else if value == 1 { // Tomorrow
                        self.lockDayLabel.text = "Unlocks Tomorrow".localized()
                    } else if value <= 30 {
                        self.lockDayLabel.text = "Unlocks in".localized() + " \(daysCount)"
                    } else {
                        let remainingDays = (value - 31)
                        
                        if remainingDays == 0 {
                            self.lockDayLabel.text = "Unlocks in".localized() + " " + "1".localized() + "month(s)".localized()
                        } else {
                            self.lockDayLabel.text = "Unlocks in".localized() + " " + "1".localized() + "month(s)".localized() + "\(remainingDays)" + "days(s)".localized()
                        }
                    }

                }
                self.timeLabel.text = daysCount + " \(currentHours) " + "hr".localized() + " \(currentMinutes) " + "mins".localized()
            } else {
                
                if !self.lockDayLabel.isHidden {
                    
                    if value == 0 {
                        self.lockDayLabel.text = "Unlocks Today".localized()
                    } else if value == 1 { // Tomorrow
                        self.lockDayLabel.text = "Unlocks Tomorrow".localized()
                    } else if value <= 30 {
                        self.lockDayLabel.text = "Unlocks in " + daysCount
                    } else {
                        let remainingDays = (value - 31)
                        
                        if remainingDays == 0 {
                            self.lockDayLabel.text = "Unlocks in " + "1 month(s)"
                        } else {
                            self.lockDayLabel.text = "Unlocks in " + "1 month(s)" + "\(remainingDays)" + "days(s)"
                        }
                    }

                }
                self.timeLabel.text = daysCount + " \(currentHours)" + "hr".localized() + " \(currentMinutes)" + "mins".localized()
            }
            
           
            
        }
        //\(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).2)sec"
    }
    
    func timeString(time: TimeInterval) -> String {
         let hour = Int(time) / 3600
         let minute = Int(time) / 60 % 60
         let second = Int(time) % 60

         // return formated string
         return String(format: "%02i:%02i:%02i", hour, minute, second)
     }
    
    @IBAction func crownBtnAction(_ sender: Any) {
        //self.crownAction!()
    }
    
}

extension TimeInterval{

        func stringFromTimeInterval() -> String {

            let time = NSInteger(self)

            let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
            let seconds = time % 60
            let minutes = (time / 60) % 60
            let hours = (time / 3600)

            return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)

        }
    }
