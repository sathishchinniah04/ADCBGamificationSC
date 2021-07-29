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
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var handle:((SpinSuccessViewAction)->Void)?
    
    static func loadXib() -> SpinSuccessView {
        return UINib(nibName: "SpinSuccessView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! SpinSuccessView
    }
    
    func populateView(info: SpinAssignReward?,action:((SpinSuccessViewAction)->Void)?) {
        self.handle = action
        appearanceSetup()
        setupLabel(info: info)
    }
    
    func setupLabel(info: SpinAssignReward?) {
        self.descLabel.text = info?.responseObject?.first?.displayDetails?.first?.name ?? ""
    }
    
    func appearanceSetup() {
        
        containerView.addShadow(cornerRadius: 20, shadowRadius: 3, opacity: 0.5, color: UIColor.black)
        let hover = CABasicAnimation(keyPath: "position")
        hover.isAdditive = true
        hover.fromValue = NSValue(cgPoint: CGPoint.zero)
        hover.toValue = NSValue(cgPoint: CGPoint(x: 0.0, y: -20.0))
        hover.autoreverses = true
        hover.duration = 1.0
        hover.speed = 1.5
        hover.repeatCount = Float.infinity
        imageView.layer.add(hover, forKey: "hoverAnimation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.imageView.layer.removeAllAnimations()
        }
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
