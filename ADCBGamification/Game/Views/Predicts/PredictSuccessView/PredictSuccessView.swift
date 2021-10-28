//
//  PredictSuccessView.swift
//  ADCBGamification
//
//  Created by SKY on 11/07/21.
//

import UIKit
enum PredictSuccessViewAction {
    case share
    case homePage
    case gamePage
}
class PredictSuccessView: UIView {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var thumsUpImage: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var shareButton: NeumorphicButton!
    
    @IBOutlet weak var gamePageButton: UIButton!
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var bgCloudImage: UIImageView!
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var goToLbl: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var shareMainView: UIView!
    @IBOutlet weak var shareGameTitleLbl: UILabel!
    @IBOutlet weak var shareContentView: UIView!
    
    @IBOutlet weak var eventInitialLbl: UILabel!
    @IBOutlet weak var eventPlayerOneTitle: UILabel!
    
    @IBOutlet weak var eventTwoInitialLbl: UILabel!
    @IBOutlet weak var eventPlayerTwoTitle: UILabel!
    
    @IBOutlet weak var shareCloudImage: UIImageView!
    
    @IBOutlet weak var shareLogo: UIImageView!
    
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var shareMessageLbl: UILabel!

    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var subContentView: UIView!
    @IBOutlet weak var lottiPredictAnimationView: AnimationView!
    
    var eventDetails: EventsList?
    var shareImage: UIImage?
    var shareCaption = ""
    private var predictAnimationView: AnimationView?
    let blueColor = UIColor(red: 34.0/256.0, green: 33.0/256.0, blue: 101.0/256.0, alpha: 1.0)
    
    var handle:((PredictSuccessViewAction)->Void)?
    
    static func loadXib() -> PredictSuccessView {
        UINib(nibName: "PredictSuccessView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! PredictSuccessView
    }
        
    func animationSetUp() {
        predictAnimationView = .init(name: "tick_back_animation")
        predictAnimationView!.frame = lottiPredictAnimationView.bounds
        predictAnimationView!.contentMode = .scaleAspectFit
        predictAnimationView!.loopMode = .playOnce
        lottiPredictAnimationView.addSubview(predictAnimationView!)
        self.predictAnimationView?.play()
    }
    
    func populateView(eventList :EventsList?, complition: ((PredictSuccessViewAction)->Void)?) {
        self.handle = complition
        self.eventDetails = eventList
        cornerRadius()
        neumorphicEffect()
        setupFontFamily()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        self.shareCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        
    }
    
    func getChars(info: EventsList?) {
        guard let inf = info else { return }
        let nameFArr = inf.opponentASynonym?.components(separatedBy: " ")
        guard let fArr = nameFArr else { return }
        if fArr.isEmpty{return}

        if fArr.count>=2 {
            let fc = fArr[0].first?.description ?? ""
            let sc = fArr[1].first?.description ?? ""
            eventInitialLbl.text = fc + " " + sc

        } else {
            let fc = fArr[0].first?.description ?? ""
            eventInitialLbl.text = fc
        }

        let nameSArr = inf.opponentBSynonym?.components(separatedBy: " ")
        guard let fSrr = nameSArr else { return }
        if fSrr.isEmpty{return}

        if fSrr.count>=2 {
            let fc = fSrr[0].first?.description ?? ""
            let sc = fSrr[1].first?.description ?? ""
            eventTwoInitialLbl.text = fc + " " + sc

        } else {
            let fc = fSrr[0].first?.description ?? ""
            eventTwoInitialLbl.text = fc
        }
    }
    
    func setupFontFamily() {
        self.animationSetUp()
        shareGameTitleLbl.text = "Predict & Win".localized()
        headingLbl.text = "Predict & Win".localized()
        shareMessageLbl.text = "Predict and get rewarded.".localized()
        
        
        shareBtn.setTitle("Share".localized(), for: .normal)
        shareBtn.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-SemiBold" : "OpenSans-SemiBold")
        
        shareMainView.isHidden = true
        subContentView.addShadow(cornerRadius: 20, shadowRadius: 3, opacity: 0.5, color: UIColor.black)
        shareLogo.image = UIImage(named: (StoreManager.shared.language == "AR") ? "Logo_Arabic" : "Logo", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        logoImageView.image = UIImage(named: (StoreManager.shared.language == "AR") ? "Logo_Arabic" : "Logo", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        //titleLbl.text = "simply".localized()
        //subTitleLbl.text = "life".localized()
        headerLbl.text = "Thank you for your participation".localized()
        messageLbl.text = "Winner will be announced shortly and you will receive a notification on the App. Stay tuned, enjoy the game !".localized()
        goToLbl.text = "Go To".localized()
     
      
        eventInitialLbl.text = eventDetails?.opponentASynonym
        eventTwoInitialLbl.text = eventDetails?.opponentBSynonym
        
        eventPlayerOneTitle.text = eventDetails?.OpponentA
        eventPlayerTwoTitle.text = eventDetails?.OpponentB
        
        
      //  self.getChars(info: eventDetails)
        
        eventPlayerOneTitle.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  10.0 : 10.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-SemiBold" : "OpenSans-SemiBold")
        
        
        eventPlayerTwoTitle.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  10.0 : 10.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-SemiBold" : "OpenSans-SemiBold")
        
        eventInitialLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  13.0 : 13.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        
        eventTwoInitialLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  13.0 : 13.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        headingLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  13.0 : 13.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        shareMessageLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  12.0 : 12.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        
        shareGameTitleLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  30.0 : 30.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        headerLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 20.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        messageLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        goToLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        let fontDict: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? UIFont(name: "Tajawal-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5) : UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5),
            NSAttributedString.Key.underlineStyle : 1,
            NSAttributedString.Key.foregroundColor :  UIColor(hexString: "#222165")
            
        ]
        let rewardAttString = NSMutableAttributedString()
        rewardAttString.append(NSAttributedString(string: "Homepage".localized(), attributes: fontDict))
        self.homePageButton.setAttributedTitle(rewardAttString, for: .normal)
        
        
        let gameAttString = NSMutableAttributedString()
        gameAttString.append(NSAttributedString(string: "Games".localized(), attributes: fontDict))
        self.gamePageButton.setAttributedTitle(gameAttString, for: .normal)
        
  
    }
    
    func neumorphicEffect() {
        shareButton.populateView(complition: shareButtonActionHandler(action:))
        shareButton.buttonState(isPressed: true)
        shareButton.setButtonTitle(title: "Share".localized())
        shareButton.setButtonFont(fSize: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fName: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
                                  
        shareButton.button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        shareButton.button.setTitleColor(blueColor, for: .normal)
    }
    
    func shareButtonActionHandler(action: NeumorphicButtonAction) {
        handle?(.share)
    }
    
    func cornerRadius() {
        containerView.addShadow(cornerRadius: 10, shadowRadius: 4, opacity: 0.4, color: UIColor.black)
    }
    
    @IBAction func homepageButtonAction() {
        handle?(.homePage)
    }
    
    
    @IBAction func gamePageBtnAction(_ sender: Any) {
        handle?(.gamePage)
    }
    
    
    @IBAction func shareBtnTapped(_ sender: Any) {
        shareImage = captureUIImageFromUIView(shareContentView)
        shareMainView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showActionSheetView()
        }
    }
    
    
    func showActionSheetView() {
        
        let imageToShare = [shareImage!, Constants.referMessage] as [Any]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.setValue(Constants.commonEmailSubject, forKey: "Subject")
        activityViewController.popoverPresentationController?.sourceView = self // so that iPads won't crash
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems:[Any]?, error: Error?) in
            self.shareMainView.isHidden = true
            //Constants.referMessage = ""
        }
        if let viewController = UIApplication.topMostViewController {
            viewController.present(activityViewController, animated: true) {
               // self.shareMainView.isHidden = true
            }
        }
        
    }
    fileprivate func captureUIImageFromUIView(_ view: UIView?) -> UIImage {

         guard (view != nil) else{
            let errorImage = UIImage(named: "Error Image") ?? UIImage()
            return errorImage
         }
         if #available(iOS 10.0, *) {
             let renderer = UIGraphicsImageRenderer(size: view!.bounds.size)
             let capturedImage = renderer.image {
                 (ctx) in
                 view!.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
             }
             return capturedImage
         } else {
             UIGraphicsBeginImageContextWithOptions((view!.bounds.size), view!.isOpaque, 0.0)
             view!.drawHierarchy(in: view!.bounds, afterScreenUpdates: false)
             let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
             UIGraphicsEndImageContext()
             return capturedImage!
         }
    }
    
}
