//
//  PredictSuccessView.swift
//  ADCBGamification
//
//  Created by SKY on 11/07/21.
//

import UIKit
enum PredictSuccessViewAction {
    case share
    case homePage
}
class PredictSuccessView: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var shareButton: NeumorphicButton!
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var bgCloudImage: UIImageView!
    
    let blueColor = UIColor(red: 34.0/256.0, green: 33.0/256.0, blue: 101.0/256.0, alpha: 1.0)
    
    var handle:((PredictSuccessViewAction)->Void)?
    
    static func loadXib() -> PredictSuccessView {
        UINib(nibName: "PredictSuccessView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! PredictSuccessView
    }
        
    func populateView(complition: ((PredictSuccessViewAction)->Void)?) {
        self.handle = complition
        cornerRadius()
        neumorphicEffect()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
    }
    
    func neumorphicEffect() {
        shareButton.populateView(complition: shareButtonActionHandler(action:))
        shareButton.buttonState(isPressed: true)
        shareButton.setButtonTitle(title: "Share")
        shareButton.button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        shareButton.button.setTitleColor(blueColor, for: .normal)
    }
    
    func shareButtonActionHandler(action: NeumorphicButtonAction) {
        handle?(.share)
    }
    
    func cornerRadius() {
        containerView.addShadow(cornerRadius: 10, shadowRadius: 4, opacity: 0.4, color: UIColor.black)
    }
    
    @IBAction func homepageButtonAction() {
        handle?(.homePage)
    }
}
