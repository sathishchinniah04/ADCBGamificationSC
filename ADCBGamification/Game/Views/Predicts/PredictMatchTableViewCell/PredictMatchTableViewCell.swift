//
//  PredictMatchTableViewCell.swift
//  ADCBGamification
//
//  Created by SKY on 05/07/21.
//

import UIKit

class PredictMatchTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var predictTeamView: PredictTeamView!
    @IBOutlet weak var questionView: QuestionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateView(index: Int) {
        self.questionView.populateView()
        DispatchQueue.main.async {
            self.setupForFirstIndex(index: index)
            self.predictTeamView.populateView()
            self.hideUnwantedObject()
            
        }
    }
    
    func hideUnwantedObject() {
        predictTeamView.leagueNameLabel.isHidden = true
        predictTeamView.timeLabel.isHidden = true
    }
    
    func setupForFirstIndex(index: Int) {
        if index == 0 {
            self.predictTeamView.isHidden = false
            self.titleLabel.isHidden = false
        } else {
            self.predictTeamView.isHidden = true
            self.titleLabel.isHidden = true
        }
    }
    
}
