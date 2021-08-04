//
//  GameListTableViewCell.swift
//  ADCBGamification
//
//  Created by SKY on 07/07/21.
//

import UIKit

class GameListTableViewCell: UITableViewCell {
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameIdLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var gameTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupFontFamily() {
        
        gameNameLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        gameIdLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  13.0 : 13.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-SemiBold" : "OpenSans-SemiBold")
        
        gameTypeLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  13.0 : 13.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        playButton.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Light" : "OpenSans-Light")
        
       
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateView(game: Games) {
        DispatchQueue.main.async {
            self.gameTypeLabel.text = "\(game.gameTitle)"
            self.gameNameLabel.text = "\(game.gameType)"
            self.gameIdLabel.text = "Game id \(game.gameId ?? "0")"
            self.playButton.backgroundColor = game.executionStatus == "Active" ? UIColor.green : UIColor.red
            self.appearenceSetup(game: game)
        }
    }
    
    func appearenceSetup(game: Games) {
        self.contentView.alpha = game.executionStatus == "Active" ? 1.0 : 0.70
    }
    
}
