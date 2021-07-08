//
//  GameListTableViewCell.swift
//  ADCBGamification
//
//  Created by SKY on 07/07/21.
//

import UIKit

class GameListTableViewCell: UITableViewCell {
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameStatusLabel: UILabel!
    @IBOutlet weak var gameIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateView(game: Games) {
        DispatchQueue.main.async {
            self.gameNameLabel.text = "\(game.gameType) == \(game.gameTitle)"
            self.gameStatusLabel.text = game.executionStatus
            self.gameIdLabel.text = "Game id = \(game.gameId ?? "")"
            print("\n")
            print("game active \(game.executionStatus)")
            print("game is \(game.gameId)")
            print("\n")
            self.gameStatusLabel.textColor = game.executionStatus == "Active" ? UIColor.green : UIColor.red
        }
        
    }
    
}
