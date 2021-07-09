//
//  PredictMatchTableViewCell.swift
//  ADCBGamification
//
//  Created by SKY on 05/07/21.
//

import UIKit

class PredictMatchTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var predictTeamContainerView: UIView!
    @IBOutlet weak var spacerView: UIView!
    @IBOutlet weak var predictTeamView: PredictTeamView!
    @IBOutlet weak var questionView: QuestionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateView(index: Int, info: Tournaments?) {
        self.questionView.populateView(index: index, tournament: info)
        self.hideUnwantedObject()
        self.questionView.populateView(index: index, tournament: info)
        DispatchQueue.main.async {
            self.appearenceSetup()
            self.setupForFirstIndex(index: index)
            self.predictTeamView.populateView(index: index, info: info)
        }
    }
    
    func appearenceSetup() {
        predictTeamContainerView.addShadow(cornerRadius: 10, shadowRadius: 6, opacity: 0.09)
    }
    
    func hideUnwantedObject() {
        predictTeamView.leagueNameLabel.isHidden = true
        predictTeamView.timeLabel.isHidden = true
    }
    
    func setupForFirstIndex(index: Int) {
        if index == 0 {
            self.predictTeamView.isHidden = false
            self.titleLabel.isHidden = false
            self.spacerView.isHidden = false
            self.predictTeamContainerView.isHidden = false
        } else {
            self.predictTeamView.isHidden = true
            self.titleLabel.isHidden = true
            self.spacerView.isHidden = true
            self.predictTeamContainerView.isHidden = true
        }
    }
    
}
