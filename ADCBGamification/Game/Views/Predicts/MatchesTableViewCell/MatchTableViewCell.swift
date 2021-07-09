//
//  MatchTableViewCell.swift
//  ADCBGamification
//
//  Created by SKY on 05/07/21.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var predictTeamView: PredictTeamView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateCell(index: Int, info: EventsList?) {
        DispatchQueue.main.async {
            self.neumorphicDesign()
            self.predictTeamView.populateView(index: index, info: info)
        }
    }
    
    func neumorphicDesign() {
        self.mainContainerView.addShadow(cornerRadius: 10, shadowRadius: 4, opacity: 0.3, color: UIColor.black)
    }
    
}
