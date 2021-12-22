//
//  KnowMoreView.swift
//  ADCBGamification
//
//  Created by SKY on 19/07/21.
//

import UIKit

enum KnowMoreViewAction {
    case knowmore
}

class KnowMoreView: UIView {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleMainLbl: UILabel!
    @IBOutlet weak var validityLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var knowmoreBtb: UIButton!
    
    var handle:((KnowMoreViewAction)->Void)?
    var handler: (()->Void)?
    static func loadXib() -> KnowMoreView {
        return UINib(nibName: "KnowMoreView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! KnowMoreView
    }
    
    func populateView(info: SpinAssignReward?, action:((KnowMoreViewAction)->Void)?) {
        self.handle = action
        appearenceSetup()
        labelSetup(info: info)
        setupFontFamily()
    }
    
    func setupFontFamily() {
        
        titleLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        titleMainLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        subTitleLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Light" : "OpenSans-Light")
        
        validityLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Light" : "OpenSans-Light")
        
        knowmoreBtb.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
    }
    
    func labelSetup(info: SpinAssignReward?) {
        
        titleLabel.text = info?.responseObject?.first?.displayDetails?.first?.name ?? ""
       
        if let timeVal = info?.responseObject?.first?.expiryDate {
            //12 p.m. 30 september 2030 - for arbic
            if (StoreManager.shared.language == GameLanguage.AR.rawValue) {
                let date = Utility.convertDateWithFormatForPredicNWin(inputDate: timeVal, currFormat: "yyyy-MM-dd", expFormat: "hh a d MMM yyyy")
                validityLabel.text = "Valid till".localized() + " " + date
            } else {
                let date = Utility.convertDateWithFormatForPredicNWin(inputDate: timeVal, currFormat: "yyyy-MM-dd", expFormat: "ha d MMM yyyy")
                validityLabel.text = "Valid till".localized() + " " + date
            }

        } else {
            validityLabel.isHidden = true
        }
        
        
        if let desc = info?.responseObject?.first?.displayDetails?.first?.description {
            subTitleLabel.text = desc
        } else {
            subTitleLabel.isHidden = true
        }
        
        if let imageUrls = info?.responseObject?.first?.displayDetails?.first?.imageList?.first?.name {
            if let url = URL(string: imageUrls) {
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                    imageView.image = UIImage(data: imageData)
                    imageView.layer.masksToBounds = true
                    imageView.layer.cornerRadius = imageView.frame.width / 2
                    imageView.contentMode = .scaleToFill
                  
                }
            }
        }

        
        let fontDict: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? UIFont(name: "Tajawal-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5) : UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5),
            NSAttributedString.Key.underlineStyle : 0,
            NSAttributedString.Key.foregroundColor :  UIColor(hexString: "#222165")
            
        ]
        let rewardAttString = NSMutableAttributedString()
        rewardAttString.append(NSAttributedString(string: "Know more".localized(), attributes: fontDict))
        self.knowmoreBtb.setAttributedTitle(rewardAttString, for: .normal)
        
        let rewardLine = UIView()
        rewardLine.translatesAutoresizingMaskIntoConstraints = false
        rewardLine.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1294117647, blue: 0.3960784314, alpha: 1)
        self.knowmoreBtb.addSubview(rewardLine)
        self.knowmoreBtb.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", metrics: nil, views: ["line":rewardLine]))
        self.knowmoreBtb.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(1)]-(\(+4))-|", metrics: nil, views: ["line":rewardLine]))

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
    
    @IBAction func knowmoreBtnAction(_ sender: Any) {
        defer {
            handle?(.knowmore)
        }
        handler?()
       
    }
    
}
