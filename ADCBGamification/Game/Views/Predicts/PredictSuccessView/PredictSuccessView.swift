//
//  PredictSuccessView.swift
//  ADCBGamification
//
//  Created by SKY on 11/07/21.
//

import UIKit

class PredictSuccessView: UIView {
    @IBOutlet weak var containerView: UIView!
    
    static func loadXib() -> PredictSuccessView {
        UINib(nibName: "PredictSuccessView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! PredictSuccessView
    }
        
    func populateView() {
        cornerRadius()
    }
    
    func cornerRadius() {
        containerView.addShadow(cornerRadius: 10, shadowRadius: 4, opacity: 0.4, color: UIColor.black)
    }

}
