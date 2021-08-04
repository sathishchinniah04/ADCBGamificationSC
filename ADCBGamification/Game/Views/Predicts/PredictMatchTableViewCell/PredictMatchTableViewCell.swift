//
//  PredictMatchTableViewCell.swift
//  ADCBGamification
//
//  Created by SKY on 05/07/21.
//

import UIKit
enum PredictMatchTableViewCellAction {
    case tapped(_ qNo: Int,_ indexPath : Int)
}

class PredictMatchTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var predictTeamContainerView: UIView!
    @IBOutlet weak var spacerView: UIView!
    @IBOutlet weak var predictTeamView: PredictTeamView!
    @IBOutlet weak var questionView: QuestionView!
    var handle:((PredictMatchTableViewCellAction)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateView(index: Int, info: EventsList?, complition: ((PredictMatchTableViewCellAction)->Void)?) {
        self.handle = complition
        self.questionView.populateView(index: index, eventsList: info) {(qNo,index1) in
            self.handle?(.tapped(qNo, index1))
        }
        
        self.hideUnwantedObject()
        DispatchQueue.main.async {
            self.appearenceSetup()
            self.setupForFirstIndex(index: index)
            self.predictTeamView.populateView(index: index, info: info)
        }
    }
    
    func appearenceSetup() {
        predictTeamContainerView.addShadow(cornerRadius: 10, shadowRadius: 6, opacity: 0.09)
        titleLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 20.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
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
