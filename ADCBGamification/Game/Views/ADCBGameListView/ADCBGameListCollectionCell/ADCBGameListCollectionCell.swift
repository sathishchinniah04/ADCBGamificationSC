//
//  ADCBGameListCollectionCell.swift
//  ADCBGamification
//
//  Created by SKY on 13/07/21.
//

import UIKit

class ADCBGameListCollectionCell: UICollectionViewCell {
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gameLogoImageView: UIImageView!
    var timer: Timer?
    var game: Games?
    //var spinFailView = SpinSuccessViewHelper()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        spinFailView.loadScreen { (done) in
//            self.spinFailView.animateAndRemove()
//        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.startTimer()
    }
    
    func populateView(game: Games?, index: Int) {
        self.game = game
        guard let game = game else { return }
        self.startTimer()
        setImage(game: game)
        setLabel(game: game)
        cellColor(index: index)
    }
    
    func cellColor(index: Int) {
        self.containerView.addShadow(cornerRadius: 10, shadowRadius: 2, opacity: 0.4, color: UIColor.black)
        self.containerView.backgroundColor = UIColor.white
    }
    
    func setImage(game: Games) {
        var gameNameImg: String = ""
        if game.gameType == "SpinNWin" {
            gameNameImg = "SpinList"
            
        } else if game.gameType == "PredictNWin" {
            gameNameImg = "PredictList"
        } else if game.gameType == "ReferNWin" {
            gameNameImg = "Invite"
            
        } else {
            gameNameImg = ""
        }
        gameLogoImageView.image = UIImage(named: gameNameImg, in: Bundle(for: Self.self), compatibleWith: nil)
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
        self.gameLabel.text = game.gameTitle
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
        let date = game.executionPeriod?.startDateTime ?? ""
        hourMinteAlignmentCheck(date: date, value: "Available in")
    }
    
    func onActive(game: Games) {
        let date = game.executionPeriod?.endDateTime ?? ""
        hourMinteAlignmentCheck(date: date, value: "Expires in")
    }
    
    func hourMinteAlignmentCheck(date: String, value: String) {
        DispatchQueue.main.async {
            self.timeLabel.text = value + " \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).0)h  \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).1)min \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).2)sec"
        }
    }
}
