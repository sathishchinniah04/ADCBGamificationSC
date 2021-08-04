//
//  NeumorphicButton.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit
enum NeumorphicButtonAction {
    case tapped
}
@IBDesignable class NeumorphicButton: UIView {
    @IBOutlet weak var button: UIButton!
    var darkLayer: CALayer?
    var lightLayer: CALayer?
    var isTapped: Bool = false
    private var handle:((NeumorphicButtonAction)->Void)?
    var isInnerState: Bool = false
    var buttonImgName: String?
    var buttonName: String?
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
    
    func loadNib() -> UIView {
        return UINib(nibName: "NeumorphicButton", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
     private func initialSetup() {
         let view = loadNib()
         view.frame = bounds
         view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
         addSubview(view)
        button.backgroundColor = UIColor.newmorphicColor()
        self.layer.cornerRadius = 10
        button.layer.cornerRadius = 10.0
            self.buttonState(isPressed: true)
     }
    
    func disabledState() {
        DispatchQueue.main.async {
            self.darkLayer?.removeFromSuperlayer()
            self.lightLayer?.removeFromSuperlayer()
            self.button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            self.button.isUserInteractionEnabled = false
        }
    }
    
    func populateView(complition:((NeumorphicButtonAction)->Void)?) {
        self.handle = complition
    }
    
    func setButtonTitle(title: String, titleColor: UIColor = .gray) {
        self.buttonName = title
        
        self.button.setTitle(title, for: .normal)
        self.button.setTitleColor(titleColor, for: .normal)
        self.button.setImage(nil, for: .normal)
    }
    
    func setButtonFont(fSize: Double, fName: String) {
        self.button.setSizeFont(sizeFont: fSize, fontFamily: fName)
    }
    func setButtonImage(name: String) {
        self.buttonImgName = name
        let img = UIImage(named: name, in: Bundle(for: Self.self), compatibleWith: nil)
        self.button.setImage(img, for: .normal)
        self.button.setTitle(nil, for: .normal)
    }
    
    func enabledState() {
        self.darkLayer?.removeFromSuperlayer()
        self.lightLayer?.removeFromSuperlayer()
        DispatchQueue.main.async {
            self.button.isUserInteractionEnabled = true
            self.darkLayer = CALayer()
            self.lightLayer = CALayer()
                self.button.addNeumorphicBtnStyle(darkLayer: self.darkLayer, lightLayer: self.lightLayer,cornerRadius: 10,isPressed: false)
        }
    }
    
    func buttonState(isPressed: Bool) {
        self.darkLayer?.removeFromSuperlayer()
        self.lightLayer?.removeFromSuperlayer()
        DispatchQueue.main.async {
            self.darkLayer = CALayer()
            self.lightLayer = CALayer()
            if isPressed {
                self.button.addNeumorphicBtnStyle(darkLayer: self.darkLayer, lightLayer: self.lightLayer,cornerRadius: 10,isPressed: false)
            } else {
                self.button.addInnerShadowBtn(lightShadow: self.lightLayer, darkShadow: self.darkLayer, cornerRadius: 10)
            }
        }
        if let img = self.buttonImgName {
            self.setButtonImage(name: img)
        }
        if let name = self.buttonName {
            self.setButtonTitle(title: name)
        }
    }
    
    @IBAction func buttonAction() {
       // buttonState(isPressed: self.isTapped)
        if isInnerState {
            buttonState(isPressed: self.isTapped)
        } else {
            buttonState(isPressed: true)
        }
        
        self.isTapped.toggle()
        self.handle?(.tapped)
    }
}
