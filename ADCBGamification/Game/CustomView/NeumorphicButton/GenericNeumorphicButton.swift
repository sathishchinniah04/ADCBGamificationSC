//
//  CustomNeumorphicButton.swift
//  ADCBGamification
//
//  Created by SKY on 26/07/21.
//

import UIKit

@IBDesignable class GenericNeumorphicButton: UIView {
    @IBOutlet weak var firstContainerView: UIView!
    @IBOutlet weak var secondContainerView: UIView!
    @IBOutlet weak var button: UIButton!
    var tapHandler:(()->Void)?
    @IBInspectable var btnColor: UIColor? = UIColor.specialBtnColor() {
        didSet {
            secondContainerView.backgroundColor = btnColor
        }
    }
    
    @IBInspectable var topOffSetColor: UIColor? = UIColor.white {
        didSet {
            shadowSetup()
        }
    }
    
    @IBInspectable var topOffSet: CGSize = CGSize(width: -6, height: -6) {
        didSet {
            shadowSetup()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 10 {
        didSet {
            shadowSetup()
        }
    }
    
    @IBInspectable var botttomOffSet: CGSize = CGSize(width: 6, height: 6) {
        didSet {
            shadowSetup()
        }
    }
    
    @IBInspectable var bottomOffSetColor: UIColor? = UIColor.specialBtnColor().withAlphaComponent(0.33) {
        didSet {
            shadowSetup()
        }
    }
    
    
    
    var view: UIView?
    func loadXib() -> UIView {
        return UINib(nibName: "GenericNeumorphicButton", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! UIView
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
        shadowSetup()
        appearenceSetup()
    }
    
    func appearenceSetup() {
        secondContainerView.backgroundColor = btnColor
    }
    
    func setupButtonName(name: String) {
        button.setTitle(name, for: .normal)
    }
    
    func shadowSetup() {
        firstContainerView.addCustomShadow(cornerRadius: shadowRadius, shadowRadius: 6, opacity: 1, color: bottomOffSetColor!, offSet: botttomOffSet)
        secondContainerView.addCustomShadow(cornerRadius: shadowRadius, shadowRadius: 6, opacity: 1, color: topOffSetColor!, offSet: topOffSet)
    }
    
    @IBAction func buttonTapped() {
        self.tapHandler?()
    }
}
