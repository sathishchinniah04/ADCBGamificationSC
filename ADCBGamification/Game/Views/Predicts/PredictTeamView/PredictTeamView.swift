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
    }
    
    func initialSetup() {
        view = loadXib()
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view!)
    }
    
    func populateView(index: Int, info: Tournaments?) {
        DispatchQueue.main.async {
            self.appearenceSetup()
            self.labelSetup(index: index, info: info)
        }
    }
    
    func labelSetup(index: Int, info: Tournaments?) {
        guard let inf = info else { return }
        leagueNameLabel.text = inf.tournamentName
        guard let events = inf.eventList?.first else { return }
        imageSetup(info: events)
        firstTeamNameLabel.text = events.OpponentA
        secondTeamNameLabel.text = events.OpponentB
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
