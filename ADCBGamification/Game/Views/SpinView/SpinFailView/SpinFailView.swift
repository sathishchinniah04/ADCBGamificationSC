//
//  SpinFailView.swift
//  ADCBGamification
//
//  Created by SKY on 22/07/21.
//

import UIKit

class SpinFailView: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var handle:((SpinFailViewAction)->Void)?
    
    static func loadXib() -> SpinFailView {
        return UINib(nibName: "SpinFailView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! SpinFailView
    }
    
    func populateView(action:((SpinFailViewAction)->Void)?) {
        self.handle = action
        appearanceSetup()
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
    
    @IBAction func homePageButtonAction() {
        handle?(.gamePage)
    }
}
