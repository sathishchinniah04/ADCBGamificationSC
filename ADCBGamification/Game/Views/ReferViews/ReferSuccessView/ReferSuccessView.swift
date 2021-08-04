//
//  ReferSuccessView.swift
//  ADCBGamification
//
//  Created by SKY on 08/07/21.
//

import UIKit
enum ReferSuccessViewAction {
    case referAgain
    case homePageTapped
}

class ReferSuccessView: UIView {
    @IBOutlet weak var rewardButton: UIButton!
    @IBOutlet weak var knowMoreButton: UIButton!
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var spinAgainButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bgCloudImage: UIImageView!
    
    var handle:((ReferSuccessViewAction)->Void)?
    
    static func loadXib() -> ReferSuccessView {
        return UINib(nibName: "ReferSuccessView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! ReferSuccessView
    }
    
    func populateView(info: SpinAssignReward?,action:((ReferSuccessViewAction)->Void)?) {
        self.handle = action
        appearanceSetup()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
       // setupLabel(info: info)
    }
    
    func setupLabel(info: SpinAssignReward?) {
        self.descLabel.text = info?.responseObject?.first?.displayDetails?.first?.name ?? ""
    }
    
    func appearanceSetup() {
        containerView.addShadow(cornerRadius: 20, shadowRadius: 3, opacity: 0.5, color: UIColor.black)
    }
    
    @IBAction func reFerAgainButtonAction() {
        handle?(.referAgain)
    }
    
    @IBAction func rewardButtonAction() {
        //handle?(.rewardTapped)
    }
    
    @IBAction func knowMoreButtonAction() {
        //handle?(.knowMoreTapped)
    }
    
    @IBAction func homePageButtonAction() {
        handle?(.homePageTapped)
    }
    
    @IBAction func spinAgainButtonAction() {
        //handle?(.spinAgainTapped)
    }
    
}
