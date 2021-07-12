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
    @IBOutlet weak var firstTeamCharLabel: UILabel!
    @IBOutlet weak var secondTeamCharLabel: UILabel!
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
    
    func extraPopulation(time: String) {
        
    }
    
    func populateView(index: Int, info: EventsList?) {
        DispatchQueue.main.async {
            self.appearenceSetup()
            self.labelSetup(index: index, info: info)
            self.getChars(index: index, info: info)
        }
    }
    
    func getChars(index: Int, info: EventsList?) {
        guard let inf = info else { return }
        let nameFArr = inf.opponentASynonym?.components(separatedBy: " ")
        guard let fArr = nameFArr else { return }
        if fArr.isEmpty{return}
        
        if fArr.count>=2 {
            let fc = fArr[0].first?.description ?? ""
            let sc = fArr[1].first?.description ?? ""
            firstTeamCharLabel.text = fc + " " + sc
            
        } else {
            let fc = fArr[0].first?.description ?? ""
            firstTeamCharLabel.text = fc
        }
        
        let nameSArr = inf.opponentBSynonym?.components(separatedBy: " ")
        guard let fSrr = nameSArr else { return }
        if fSrr.isEmpty{return}
        
        if fSrr.count>=2 {
            let fc = fSrr[0].first?.description ?? ""
            let sc = fSrr[1].first?.description ?? ""
            secondTeamCharLabel.text = fc + " " + sc
            
        } else {
            let fc = fSrr[0].first?.description ?? ""
            secondTeamCharLabel.text = fc
        }
    }
    
    
    
    func labelSetup(index: Int, info: EventsList?) {
        guard let inf = info else { return }
        //leagueNameLabel.text = inf.
       // guard let events = inf else { return }
       // imageSetup(info: inf)
        leagueNameLabel.text = Constants.leagueName
        firstTeamNameLabel.text = inf.opponentASynonym
        secondTeamNameLabel.text = inf.opponentBSynonym
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
