//
//  ReferContactButton.swift
//  ADCBGamification
//
//  Created by SKY on 10/07/21.
//

import UIKit
enum ReferContactButtonAction {
    case chooseContact
    
}
@IBDesignable class ReferContactButton: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var chooseContact: UIButton!
    @IBOutlet weak var dummyButton: UIButton!
    var darkLayer: CALayer?
    var lightLayer: CALayer?
    @IBInspectable var title: String? = "Mobile Number" {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable var placeHolder: String? = "Mobile Number" {
        didSet {
            textField.placeholder = placeHolder
        }
    }
    
    var view: UIView?
    private var handle: ((ReferContactButtonAction)->Void)?
    func loadXib() -> UIView {
        return UINib(nibName: "ReferContactButton", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! UIView
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
        view?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view!)
        titleLabel.isHidden = true
        titleLabel.text = title
        textField.placeholder = placeHolder
    }
    
    func buttonState(isPressed: Bool) {
        self.darkLayer?.removeFromSuperlayer()
        self.lightLayer?.removeFromSuperlayer()
        DispatchQueue.main.async {
            self.darkLayer = CALayer()
            self.lightLayer = CALayer()
            if isPressed {
                self.dummyButton.addNeumorphicBtnStyle(darkLayer: self.darkLayer, lightLayer: self.lightLayer,cornerRadius: 10,isPressed: false)
            } else {
                self.dummyButton.addInnerShadowBtn(lightShadow: self.lightLayer, darkShadow: self.darkLayer, cornerRadius: 10)
            }
        }
    }
    
    
    func populateView(complition:((ReferContactButtonAction)->Void)?) {
        self.handle = complition
    }
    
    @IBAction func cheooseContactTapped() {
        DispatchQueue.main.async {
            self.chooseContact.isHidden = true
            self.titleLabel.isHidden = false
        }
        self.handle?(.chooseContact)
    }
}
