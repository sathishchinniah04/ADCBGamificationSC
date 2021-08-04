//
//  TermsView.swift
//  Gamification
//
//  Created by SKY on 19/06/21.
//

import UIKit

class TermsView: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var checkContainerView: UIView!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var titleTopLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var continueButton: NeumorphicButton!
    var isSelected: Bool = false
    var darkLayer: CALayer?
    var lightLayer: CALayer?
    
    static func loadXib() ->TermsView {
        return UINib(nibName: "TermsView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! TermsView
    }
    
    func populateView(complition:(()->Void)?) {
        
        setupButton()
        //setupLabel()
        self.containerView.addShadow(cornerRadius: 10, shadowRadius: 5, opacity: 0.5)
        continueButton.populateView { (action) in
            switch action {
                case .tapped:
                    complition?()
             default:
                break
            }
        }
        //addBlurrEffect()
        initialState()
    }
    func initialState() {
        self.darkLayer?.removeFromSuperlayer()
        self.lightLayer?.removeFromSuperlayer()
        self.darkLayer = CALayer()
        self.lightLayer = CALayer()
        self.continueButton.disabledState()
        let name = "termsCheck"
        checkImageView.image =   isSelected ?  UIImage(named: name, in: Bundle(for: Self.self), compatibleWith: nil) : nil
        checkContainerView.addNeumorphicEffect(darkLayer: self.darkLayer, lightLayer: self.lightLayer,isPressed: false)
        if #available(iOS 13.0, *) {
            self.blurrEffect(alfa: 0.97)
        } else {
            // Fallback on earlier versions
        }
    }
    
    func addBlurrEffect() {
    
        checkContainerView.backgroundColor = .clear
        self.darkLayer = CALayer()
        self.lightLayer = CALayer()
        DispatchQueue.main.async {
            self.checkContainerView.addInnerShadowView(lightShadow: self.lightLayer, darkShadow: self.darkLayer)//addNeumorphicEffect(darkLayer: self.darkLayer, lightLayer: self.lightLayer, isPressed: false)
        }
        
    }
    func setupLabel() {
        
        titleTopLabel.text = "Terms & Conditions"
        subtitleLabel.text = "Once app is installed by the invitee, You will recieve points."
        
        titleTopLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        subtitleLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        agreeButton.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        
        
    }
    
    func setupButton() {
        continueButton.setButtonTitle(title: "Continue",titleColor: UIColor.blue)
        continueButton.setButtonFont(fSize: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fName: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
        continueButton.populateView { (action) in
            print("Neumorphic effect tapped \(action)")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        
        if touch?.view == containerView {
            print("Containerview tapped")
        }else {
            print("Outside tapped")
        }
    }
    
    @IBAction func iAgreeTapped(_ sender: UIButton) {
        isSelected.toggle()
        let name = "termsCheck"
        self.darkLayer?.removeFromSuperlayer()
        self.lightLayer?.removeFromSuperlayer()
        self.darkLayer = CALayer()
        self.lightLayer = CALayer()
        if isSelected {
            checkContainerView.addInnerShadowView(lightShadow: self.lightLayer, darkShadow: self.darkLayer,backColor: isSelected ? UIColor.yellow : UIColor.white)
        } else {
            checkContainerView.addNeumorphicEffect(darkLayer: self.darkLayer, lightLayer: self.lightLayer,isPressed: false)
        }
        checkImageView.image =   isSelected ?  UIImage(named: name, in: Bundle(for: Self.self), compatibleWith: nil) : nil
        isSelected ? self.continueButton.enabledState() : self.continueButton.disabledState()
        self.continueButton.isUserInteractionEnabled = isSelected
    }
}
