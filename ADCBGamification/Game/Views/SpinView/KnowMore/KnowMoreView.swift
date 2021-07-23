//
//  KnowMoreView.swift
//  ADCBGamification
//
//  Created by SKY on 19/07/21.
//

import UIKit

class KnowMoreView: UIView {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var infoContainerView: UIView!
    var handler: (()->Void)?
    static func loadXib() -> KnowMoreView {
        return UINib(nibName: "KnowMoreView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! KnowMoreView
    }
    
    func populateView(info: SpinAssignReward?) {
        appearenceSetup()
        labelSetup(info: info)
    }
    
    func labelSetup(info: SpinAssignReward?) {
        titleLabel.text = info?.responseObject?.first?.displayDetails?.first?.name ?? ""
        subTitleLabel.text = info?.responseObject?.first?.displayDetails?.first?.description ?? ""
    }
    
    func appearenceSetup() {
        if #available(iOS 13.0, *) {
            containerView.blurrEffect(alfa: 0.85, blurEffect: UIBlurEffect(style: .systemMaterialDark))
        } else {
            // Fallback on earlier versions
        }
        
        infoContainerView.addShadow(cornerRadius: 20, shadowRadius: 4, opacity: 0.5, color: UIColor.black)
    }
    
    @IBAction func closeButtonAction() {
        handler?()
    }
}
