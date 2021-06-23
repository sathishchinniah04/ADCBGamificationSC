//
//  NeumorphicTextField.swift
//  Gamification
//
//  Created by SKY on 13/06/21.
//

import UIKit
enum ImageType: String {
    case verified = "verified"
    case unVerified = "unVerified"
}

enum TextFieldType {
    case name
    case email
    case contact
}
enum NeumorphicTextFieldAction {
    case endEditing
}

@IBDesignable class NeumorphicTextField: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var checkImageView: UIImageView!
    var lightLayer: CALayer?
    var darkLayer: CALayer?
    var type: TextFieldType = .name
    var isValid: Bool = false
    var placeHolder: String = ""
    var titleText: String = ""
    private var handle:((NeumorphicTextFieldAction)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    //    @IBInspectable var placeholder: String = "No name" {
    //        didSet{
    //            textField.placeholder = placeholder
    //        }
    //    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initialSetup()
    }
    
    func loadNib() -> UIView {
        return UINib(nibName: "NeumorphicTextField", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    private func initialSetup() {
        let view = loadNib()
        view.frame = bounds
        textField.delegate = self
        titleLabel.isHidden = true
        self.checkImageView.isHidden = true
        
        self.containerView.backgroundColor = UIColor.white//newmorphicColor()
        self.containerView.layer.cornerRadius = 10.0
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        addSubview(view)
    }
    
    func textFieldInitialSetup(title: String, placeHolder: String, type: TextFieldType, complition: ((NeumorphicTextFieldAction)->Void)?) {
        self.handle = complition
        self.placeHolder = placeHolder
        self.titleText = title
        self.textField.placeholder = placeHolder
        self.titleLabel.text = title
        
        self.type = type
        if type == .contact {
            textField.keyboardType = .phonePad
        } else if type == .email {
            textField.keyboardType = .emailAddress
        }
    }
    
    func setImage(name: ImageType?) {
        DispatchQueue.main.async {
            if let val = name {
                self.checkImageView.isHidden = false
                self.isValid = true
                self.checkImageView.image = UIImage(named: val.rawValue, in: Bundle(for: NeumorphicTextField.self), compatibleWith: nil)
            } else {
                self.checkImageView.isHidden = true
                self.checkImageView.image = nil
                self.isValid = false
            }
            
        }
    }
    
    func setTitle(title: String) {
        DispatchQueue.main.async {
            self.titleLabel.isHidden = false
            self.titleLabel.text = title
        }
        
    }
    
    
    func changeAppearenceOnEdit(text: String) {
        
        DispatchQueue.main.async {
            if text.count >= 2 {
                self.setImage(name: .unVerified)
                self.isValid = false
            } else {
                self.setImage(name: nil)
                self.isValid = true
            }
            print("char \(text)")
            print("char count \(text.count)")
        }
    }
    func changeAppearenceAfterEdit(text: String) {
        if text.isEmpty {
            self.titleLabel.isHidden = true
            self.textField.placeholder = self.placeHolder
            self.lightLayer?.removeFromSuperlayer()
            self.darkLayer?.removeFromSuperlayer()
            self.containerView.backgroundColor = UIColor.white
        }
        if type == .email {
            if text.isValidEmail() {
                self.setImage(name: .verified)
                self.isValid = true
            } else if text.count >= 2 {
                self.setImage(name: .unVerified)
                self.isValid = false
            }
        } else if type == .contact {
            if text.isValidPhone() {
                self.setImage(name: .verified)
                self.isValid = true
            } else {
                self.isValid = false
            }
        } else {
            DispatchQueue.main.async {
                if text.count >= 3 {
                    self.setImage(name: .verified)
                    self.isValid = true
                } else {
                    self.isValid = false
                }
            }
        }
    }
}
extension NeumorphicTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField.placeholder = ""
        self.lightLayer?.removeFromSuperlayer()
        self.darkLayer?.removeFromSuperlayer()
        DispatchQueue.main.async {
            self.setTitle(title: self.titleText)
            self.containerView.backgroundColor = UIColor.newmorphicColor()
            self.lightLayer = CALayer()
            self.darkLayer = CALayer()
            self.containerView.addInnerShadowView(lightShadow: self.lightLayer, darkShadow: self.darkLayer,cornerRadius: 10)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
                   let textRange = Range(range, in: text) {
                   let updatedText = text.replacingCharacters(in: textRange,
                                                               with: string)
            self.changeAppearenceOnEdit(text: updatedText)
        }
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        changeAppearenceAfterEdit(text: textField.text!)
        handle?(.endEditing)
    }
}
