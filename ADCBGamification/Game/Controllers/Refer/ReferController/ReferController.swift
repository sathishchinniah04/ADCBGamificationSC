//
//  ReferController.swift
//  ADCBGamification
//
//  Created by SKY on 09/07/21.
//

import UIKit

class ReferController: UIViewController, ReferDateDelegate {
    
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var shareReferalLabel: UILabel!
    @IBOutlet weak var referCodeView: UIView!
    @IBOutlet weak var referCodeLabel: UILabel!
    @IBOutlet weak var shareButton: NeumorphicButton!
    @IBOutlet weak var chooseContactButton: NeumorphicButton!
    //@IBOutlet weak var chooseContactButton: ReferContactButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var bgCloudImage: UIImageView!
    //var referSuccessView = ReferSuccessPopupHelper()
    var referCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                self.referCodeLabel.text = data.referralCode
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
        self.openActivityController(text: "Hey! check out the referral code and use this while registering. *\(referCode)*")
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
    
    func referAction() {
        self.dismiss(animated: true) {
            CallBack.shared.handle?(.homeAction)
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
        self.present(cont, animated: true, completion: nil)
    }
    
}
