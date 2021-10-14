//
//  ReferController.swift
//  ADCBGamification
//
//  Created by SKY on 09/07/21.
//

import UIKit

class ReferController: UIViewController, ReferDateDelegate {
    
    @IBOutlet weak var referArbLblLeftConstraints: NSLayoutConstraint!
   // @IBOutlet weak var referEngLblLeftConstraints: NSLayoutConstraint!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var shareReferalLabel: UILabel!
    @IBOutlet weak var referCodeView: UIView!
    @IBOutlet weak var referCodeLabel: UILabel!
    @IBOutlet weak var referMessageLabel: UILabel!
    @IBOutlet weak var referMessageLabelEnglish: UILabel!
    @IBOutlet weak var shareButton: NeumorphicButton!
    @IBOutlet weak var chooseContactButton: NeumorphicButton!
    //@IBOutlet weak var chooseContactButton: ReferContactButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var bgCloudImage: UIImageView!
    //var referSuccessView = ReferSuccessPopupHelper()
    var referCode: String = ""
    var sharingMessage: String = ""
    var emailSubject = ""
    var myDefaultSize: CGFloat = 112.0
    override func viewDidLoad() {
        super.viewDidLoad()
        //referEngLblLeftConstraints.constant = 112
       // referArbLblLeftConstraints.constant = 180
        //self.setupLabelConstraints()
        self.setupArabicLabelConstraints()
        self.addDottedLine()
        self.neumorphicButtonSetup()
        chooseContactButton.alpha = 0.3
        chooseContactButton.isUserInteractionEnabled = false
        getReferCode()
        checkLeftToRight()
        buttonUserInteraction(enable: false)
        self.chooseContactButton.buttonState(isPressed: true)
        self.chooseContactButton.setButtonTitle(title: "Choose Contact".localized(),titleColor: TTUtils.uiColor(from: 0x222165))
        self.chooseContactButton.populateView { (done) in
            self.chooseContactButton.setButtonTitle(title: "Choose Contact".localized(),titleColor: TTUtils.uiColor(from: 0x222165))
            self.openContactList()
        }
        if StoreManager.shared.language == GameLanguage.EN.rawValue {
            referMessageLabel.isHidden = true
            referMessageLabelEnglish.isHidden = false
        } else {
            referMessageLabel.isHidden = false
            referMessageLabelEnglish.isHidden = true
        }

        
        self.chooseContactButton.setButtonFont(fSize: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fName: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
        
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        orLabel.text = "or".localized()
        shareReferalLabel.text = "Share Your Referral Code".localized()
        
        orLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        shareReferalLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Light" : "OpenSans-Light")
        referCodeLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        let con = self.navigationController
        (con as? CustomNavViewController)?.changeOnlyTitle(title: "Refer & Win".localized())
    }
//
//    func setupLabelConstraints() {
//
//        let device = UIDevice.current.modelName
//        switch device {
//        case "iPhone 11 Pro", "iPhone 11 Pro Max":
//            referEngLblLeftConstraints.constant = 105
//        default:
//            referEngLblLeftConstraints.constant = 112
//        }
//    }
//
    
    func setupArabicLabelConstraints() {
       
        let device = UIDevice.current.modelName
        if (device == "iPhone 8") {
            referArbLblLeftConstraints.constant = 180
        } else  if (device == "iPhone 11 Pro") {
            referArbLblLeftConstraints.constant = 190
        } else {
            referArbLblLeftConstraints.constant = 200
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.referMessageLabel.layoutIfNeeded()
        }
    }
    
    func buttonUserInteraction(enable: Bool) {
        DispatchQueue.main.async {
            self.chooseContactButton.isUserInteractionEnabled = enable
            self.shareButton.isUserInteractionEnabled = enable
        }
    }
    
    func getReferCode() {
        referCodeLabel.text = "Loading"
        ReferViewModel.getReferalCode { (data) in
            DispatchQueue.main.async {
                self.chooseContactButton.alpha = 1.0
                self.chooseContactButton.isUserInteractionEnabled = true
                self.activityIndicatorView.stopAnimating()
                self.emailSubject = data.emailSubject ?? ""
                self.referCodeLabel.text = data.referralCode
                self.referMessageLabel.text = data.rewardMessage
                self.referMessageLabelEnglish.text = data.rewardMessage
                self.sharingMessage = data.referralMessage ?? ""
                self.referCode = data.referralCode ?? ""
                self.buttonUserInteraction(enable: true)
                self.referCodeView.layoutIfNeeded()
            }
        }
    }
    
    func addDottedLine() {
        DispatchQueue.main.async {
            self.referCodeView.addDottedLine()
        }
    }
    
    
    func onRecordSuccess(info: ReferCode) {
//        self.referSuccessView.show {
//            DispatchQueue.main.async {
//                self.referSuccessView.animateAndRemove()
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
    }
    
    func onRecordFailure(info: ReferCode) {
        DispatchQueue.main.async {
        self.view.showAlert(message: info.respDesc ?? "") { (done) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        }
    }
    func neumorphicButtonSetup() {
        DispatchQueue.main.async {
            self.shareButton.setButtonImage(name: "Refershare")
            self.shareButton.populateView(complition: self.referButtonHandle(action:))
            self.shareButton.buttonState(isPressed: true)
            //self.shareButton.button.setImage(UIImage(named: "Refershare"), for: .normal)
        }
    }
    
    func referButtonHandle(action: NeumorphicButtonAction) {
        print("Tapped refer")
        print(sharingMessage)
        self.openActivityController(text: sharingMessage, emailSubj: self.emailSubject)
    }
    
    func chooseContactButtonTapped(action: ReferContactButtonAction) {
        switch action {
        case .chooseContact:
            print("button tapped")
        case .contactList:
            self.openContactList()
        default:
            break
        }
    }
    
    func referAction(isToHomePage: Bool) {
        if isToHomePage{
            self.dismiss(animated: true) {
                CallBack.shared.handle?(.homeAction)
            }
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }

    }
    
    func openContactList() {
        let cont = UIStoryboard(name: "Refer", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "ContactListController") as! ContactListController
        cont.referCode = self.referCode
        cont.delegate = self
        cont.handle = {(name, ph) in
//            self.chooseContactButton.titleLabel.text = name
//            self.chooseContactButton.textField.text = ph
            
        }
        cont.modalPresentationStyle = .overFullScreen
        self.present(cont, animated: true, completion: nil)
    }
    
}

public extension UIDevice {

    /// pares the deveice name as the standard name
    var modelName: String {

        #if targetEnvironment(simulator)
            let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!
        #else
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
        #endif

        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPod9,1":                                 return "iPod touch (7th generation)"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPhone11,2":                              return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPhone12,1":                              return "iPhone 11"
        case "iPhone12,3":                              return "iPhone 11 Pro"
        case "iPhone12,5":                              return "iPhone 11 Pro Max"
        case "iPhone12,8":                              return "iPhone SE (2nd generation)"
        case "iPhone13,1":                              return "iPhone 12 mini"
        case "iPhone13,2":                              return "iPhone 12"
        case "iPhone13,3":                              return "iPhone 12 Pro"
        case "iPhone13,4":                              return "iPhone 12 Pro Max"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad7,5", "iPad7,6":                      return "iPad 6"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
        case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        default:                                        return identifier
        }
    }
}
