//
//  CompletedTableViewCell.swift
//  Gamification
//
//  Created by SKY on 21/01/21.
//  Copyright © 2021 SIXDEE. All rights reserved.
//

import UIKit

class CompletedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var playedAgoLabel: UILabel!
    @IBOutlet weak var gameChalengeLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
