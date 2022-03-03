//
//  CustomContactCell.swift
//  ADCBGamification
//
//  Created by SKY on 10/07/21.
//

import UIKit

class CustomContactCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var initialCharLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var verifyBtn: UIButton!
    var verifyBtnAction : (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupFontFamily()
    }
    
    func setupFontFamily() {

        contactNameLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        contactLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  12.0 : 12.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        verifyBtn.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        let fontDict: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? UIFont(name: "Tajawal-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5) : UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5),
            NSAttributedString.Key.underlineStyle : 0,
            NSAttributedString.Key.foregroundColor :  UIColor(hexString: "#222165")
            
        ]
        let homeAttString = NSMutableAttributedString()
        homeAttString.append(NSAttributedString(string: "Verify".localized(), attributes: fontDict))
        self.verifyBtn.setAttributedTitle(homeAttString, for: .normal)
        
        let homeLine = UIView()
        homeLine.translatesAutoresizingMaskIntoConstraints = false
        homeLine.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1294117647, blue: 0.3960784314, alpha: 1)
        self.verifyBtn.addSubview(homeLine)
        self.verifyBtn.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", metrics: nil, views: ["line":homeLine]))
        self.verifyBtn.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(1)]-(\(+4))-|", metrics: nil, views: ["line":homeLine]))

    }

    func populateView(info: FetchedContact) {
        cornerSetup()
        
        if info.unknowContact == true {
            verifyBtn.isHidden = false
            initialCharLabel.isHidden = true
            userImageView.isHidden = false
            imageContainerView.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        } else {
            verifyBtn.isHidden = true
            initialCharLabel.isHidden = false
            imageContainerView.backgroundColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0, alpha: 1)
        }
        
        labelSetup(info: info)
        setupImage(info: info)
    }
    
    func labelSetup(info: FetchedContact) {
        DispatchQueue.main.async {
            self.contactNameLabel.text = info.firstName+" "+info.lastName
            self.contactLabel.text = info.telephone
            let fistC = info.firstName.first?.description ?? ""
            let secC = info.lastName.first?.description ?? ""
            self.initialCharLabel.text = fistC+secC
        }
    }
    
    func setupImage(info: FetchedContact) {
        DispatchQueue.main.async {
            if let imgD = info.image {
                self.userImageView.image = UIImage(data: imgD)
                self.userImageView.isHidden = false
            } else {
                if (info.unknowContact == true) {
                    self.userImageView.isHidden = false
                } else {
                    self.userImageView.isHidden = true
                }
            }
        }
    }
    
    @IBAction func verifyBtnTap(_ sender: Any) {
        verifyBtnAction!()
    }
    
    func cornerSetup() {
        DispatchQueue.main.async {
            
        }
    }
    
}
