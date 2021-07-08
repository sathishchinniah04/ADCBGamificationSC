//
//  SpinSuccessView.swift
//  ADCBGamification
//
//  Created by SKY on 08/07/21.
//

import UIKit
enum SpinSuccessViewAction {
    case rewardTapped
    case knowMoreTapped
    case homePageTapped
    case spinAgainTapped
}

class SpinSuccessView: UIView {
    @IBOutlet weak var rewardButton: UIButton!
    @IBOutlet weak var knowMoreButton: UIButton!
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var spinAgainButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var handle:((SpinSuccessViewAction)->Void)?
    
    static func loadXib() -> SpinSuccessView {
        return UINib(nibName: "SpinSuccessView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! SpinSuccessView
    }
    
    func populateView(action:((SpinSuccessViewAction)->Void)?) {
        self.handle = action
        appearanceSetup()
    }
    
    func appearanceSetup() {
        containerView.addShadow(cornerRadius: 20, shadowRadius: 3, opacity: 0.5, color: UIColor.black)
    }
    
    @IBAction func rewardButtonAction() {
        handle?(.rewardTapped)
    }
    
    @IBAction func knowMoreButtonAction() {
        handle?(.knowMoreTapped)
    }
    
    @IBAction func homePageButtonAction() {
        handle?(.homePageTapped)
    }
    
    @IBAction func spinAgainButtonAction() {
        handle?(.spinAgainTapped)
    }
    
}
