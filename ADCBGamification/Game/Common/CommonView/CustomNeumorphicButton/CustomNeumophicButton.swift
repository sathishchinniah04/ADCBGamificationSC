//
//  CustomNeumophicButton.swift
//  ADCBGamification
//
//  Created by SKY on 06/07/21.
//

import UIKit

class CustomNeumophicButton: UIView {
    var view: UIView?
    var darkL: CALayer?
    var lightL: CALayer?
    @IBOutlet weak var btnContainerView: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var button: UIButton!
    var handler: (()->Void)?
    func loadXib() ->UIView {
        return UINib(nibName: "CustomNeumophicButton", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! UIView
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
        DispatchQueue.main.async {
           // self.unSelectedState()
        }
    }
    
    func selectedState() {
        darkL?.removeFromSuperlayer()
        lightL?.removeFromSuperlayer()
        darkL = nil
        lightL = nil
//        darkL = CALayer()
//        lightL = CALayer()
        button.backgroundColor = .clear
      //  self.bgImage.image = UIImage(named: "pnwQuesSelec", in: Bundle(for: CustomNeumophicButton.self), compatibleWith: nil)
        
////        button.customShadow(lightSha: lightL!, cornerRadius: 5, backColor: UIColor.customYellowColor(), shadowColor: UIColor.white, shadowRadius: 2,opacity: 0.3, dx: 0, dy: 0)
////        button.customShadow(lightSha: darkL!, cornerRadius: 5, backColor: UIColor.customYellowColor(), shadowColor: UIColor.black,shadowRadius: 1, opacity: 0.8,dx: -1, dy: -1)
////        button.addCustomShadow(cornerRadius: 5, shadowRadius: 2, opacity: 0.5, color: UIColor.clear, offset: CGSize(width: 2, height: 2))
        
    }
    
    func unSelectedState() {
        darkL?.removeFromSuperlayer()
        lightL?.removeFromSuperlayer()
        darkL = nil
        lightL = nil
        button.backgroundColor = .clear
      //  self.bgImage.image = UIImage(named: "pnwQuesDisab", in: Bundle(for: CustomNeumophicButton.self), compatibleWith: nil)
       // button.layer.cornerRadius = 5
        
       // button.addCustomShadow(cornerRadius: 5, shadowRadius: 2, opacity: 0.2, color: UIColor.black, offset: CGSize(width: 2, height: 2))
    }
    
    @IBAction func buttonTapped() {
            //selectedState()
        self.handler?()
    }
    
}
