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
        bounceAnimation(imageView)

    }
    
    @IBAction func homePageButtonAction() {
        handle?(.gamePage)
    }
}


