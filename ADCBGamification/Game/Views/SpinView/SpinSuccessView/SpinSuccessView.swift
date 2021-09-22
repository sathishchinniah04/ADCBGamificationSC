//
//  SpinSuccessView.swift
//  ADCBGamification
//
//  Created by SKY on 08/07/21.
//

import UIKit
import Foundation

class InstagramManager: NSObject, UIDocumentInteractionControllerDelegate {

    private let kInstagramURL = "instagram://app"
    private let kUTI = "com.instagram.exclusivegram"
    private let kfileNameExtension = "instagram.igo"
    private let kAlertViewTitle = "Error"
    private let kAlertViewMessage = "Please install the Instagram application"

    var documentInteractionController = UIDocumentInteractionController()

    // singleton manager
    class var sharedManager: InstagramManager {
        struct Singleton {
            static let instance = InstagramManager()
        }
        return Singleton.instance
    }

    func postImageToInstagramWithCaption(imageInstagram: UIImage, instagramCaption: String, view: UIView) {
        // called to post image with caption to the instagram application

        let instagramURL = NSURL(string: kInstagramURL)
        if UIApplication.shared.canOpenURL(instagramURL! as URL) {
            let jpgPath = (NSTemporaryDirectory() as NSString).appendingPathComponent(kfileNameExtension)
            //UIImageJPEGRepresentation(imageInstagram, 1.0)!.writeToFile(jpgPath, atomically: true)
            do {
                try imageInstagram.jpegData(compressionQuality: 1.0)!.write(to: URL(fileURLWithPath: jpgPath), options: .atomic)
            } catch let error {
                print(error)
            }
 
            let rect = CGRect(x: 0,y: 0,width: 612,height: 612)
            let fileURL = NSURL.fileURL(withPath: jpgPath)
            documentInteractionController.url = fileURL
            documentInteractionController.delegate = self
            documentInteractionController.uti = kUTI

            // adding caption for the image
            documentInteractionController.annotation = ["InstagramCaption": instagramCaption]
            documentInteractionController.presentOpenInMenu(from: rect, in: view, animated: true)
        } else {

            print(kAlertViewMessage)
            // alert displayed when the instagram application is not available in the device
           // UIAlertView(title: kAlertViewTitle, message: kAlertViewMessage, delegate:nil, cancelButtonTitle:"Ok").show()
        }
    }

}
enum SpinSuccessViewAction {
    case rewardTapped
    case knowMoreTapped
    case homePageTapped
    case spinAgainTapped
    case gameTapped
    case shareTapped
}

class SpinSuccessView: UIView {
    
    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var goToLabel: UILabel!
    @IBOutlet weak var rewardButton: UIButton!
    @IBOutlet weak var knowMoreButton: UIButton!
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var spinAgainButton: UIButton!
    @IBOutlet weak var messageTitleLbl: UILabel!
    @IBOutlet weak var messageDescLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bgCloudImage: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var shareMainView: UIView!
    @IBOutlet weak var shareCloudImage: UIImageView!
    @IBOutlet weak var shareLogo: UIImageView!
    @IBOutlet weak var shareCongratzLbl: UILabel!
    @IBOutlet weak var shareGameTitleLbl: UILabel!
    @IBOutlet weak var shareContentView: UIView!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var shareMessageLbl: UILabel!
    @IBOutlet weak var shareExpLbl: UILabel!
    @IBOutlet weak var shareSubView: UIView!
    @IBOutlet weak var shareBtn: UIButton!
    
    var handle:((SpinSuccessViewAction)->Void)?
    var shareImage: UIImage?
    var shareMessage: String?
    
    
    static func loadXib() -> SpinSuccessView {
        return UINib(nibName: "SpinSuccessView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! SpinSuccessView
    }
    
    func populateView(info: SpinAssignReward?,action:((SpinSuccessViewAction)->Void)?) {
        self.handle = action
        appearanceSetup()
        setupLabel(info: info)
        checkLeftToRight()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        self.shareCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
    }
    
    func setupFontFamily() {
        
        shareMainView.isHidden = true
        shareGameTitleLbl.text = "Spin & Win".localized()
        shareCongratzLbl.text = "Congratulation".localized()
        
        
        
        shareBtn.setTitle("Share".localized(), for: .normal)
        shareBtn.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-SemiBold" : "OpenSans-SemiBold")
        
        titleLable.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 20.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        messageTitleLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        messageDescLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        goToLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
  
        shareGameTitleLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  30.0 : 30.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        shareCongratzLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  13.0 : 13.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        shareMessageLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  13.0 : 13.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        shareExpLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  9.0 : 9.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        
    }

    func showActionSheetView() {
        
        let imageToShare = [ shareImage!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.setValue(Constants.referMessage, forKey: "Subject")
        activityViewController.popoverPresentationController?.sourceView = self // so that iPads won't crash
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems:[Any]?, error: Error?) in
            self.shareMainView.isHidden = true
            Constants.referMessage = ""
        }
        if let viewController = UIApplication.topMostViewController {
            viewController.present(activityViewController, animated: true) {
               // self.shareMainView.isHidden = true
            }
        }
        
    }
    

    func setupLabel(info: SpinAssignReward?) {
        
        logoImageView.image = UIImage(named: (StoreManager.shared.language == "AR") ? "Logo_Arabic" : "Logo", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        
        shareLogo.image = UIImage(named: (StoreManager.shared.language == "AR") ? "Logo_Arabic" : "Logo", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        
        titleHeaderLabel.isHidden = true
        subTitleLabel.isHidden = true
        setupFontFamily()
        self.titleLable.text = "Hurray!".localized()
        self.goToLabel.text = "Go To".localized()
        //self.titleHeaderLabel.text = "simply".localized()
        //self.subTitleLabel.text = "life".localized()

        let fontDict: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? UIFont(name: "Tajawal-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5) : UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 1.5),
            NSAttributedString.Key.underlineStyle : 1,
            NSAttributedString.Key.foregroundColor :  UIColor(hexString: "#222165")
            
        ]
        let rewardAttString = NSMutableAttributedString()
        rewardAttString.append(NSAttributedString(string: "Games".localized(), attributes: fontDict))
        self.rewardButton.setAttributedTitle(rewardAttString, for: .normal)
        
        
        let homeAttString = NSMutableAttributedString()
        homeAttString.append(NSAttributedString(string: "Homepage".localized(), attributes: fontDict))
        self.homePageButton.setAttributedTitle(homeAttString, for: .normal)
        
        let spinAttString = NSMutableAttributedString()
        spinAttString.append(NSAttributedString(string: "Spin Again".localized(), attributes: fontDict))
        self.spinAgainButton.setAttributedTitle(spinAttString, for: .normal)

  
        
      /*  if let rewardsAttributedTitle = self.rewardButton.attributedTitle(for: .normal) {
            let mutableAttributedTitle = NSMutableAttributedString(attributedString: rewardsAttributedTitle)
            mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: "Rewards".localized())
            self.rewardButton.setAttributedTitle(mutableAttributedTitle, for: .normal)
        }
        
        if let homeAttributedTitle = self.rewardButton.attributedTitle(for: .normal) {
            let mutableAttributedTitle = NSMutableAttributedString(attributedString: homeAttributedTitle)
            mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: "Homepage".localized())
            self.homePageButton.setAttributedTitle(mutableAttributedTitle, for: .normal)
        }
        
        if let spinAttributedTitle = self.rewardButton.attributedTitle(for: .normal) {
            let mutableAttributedTitle = NSMutableAttributedString(attributedString: spinAttributedTitle)
            mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: "Spin Again".localized())
            self.spinAgainButton.setAttributedTitle(mutableAttributedTitle, for: .normal)
        } */
        
        //self.rewardButton.setTitle("Rewards".localized(), for: .normal)
        //self.homePageButton.setTitle("Homepage".localized(), for: .normal)
        
        self.spinAgainButton.setTitle("Spin Again".localized(), for: .normal)
        
        self.messageTitleLbl.text = "You have won ".localized() + "\(info?.responseObject?.first?.displayDetails?.first?.synonym ?? "")"
        self.messageDescLbl.text = "\(info?.responseObject?.first?.displayDetails?.first?.name ?? "")"
        
        self.shareMessageLbl.text =  "I won a".localized() + " " + (info?.responseObject?.first?.displayDetails?.first?.synonym ?? "") + " " + "by playing a Spin & Win".localized()

        if (info?.responseObject?.first?.expiryDate?.isEmpty ?? "".isEmpty || info?.responseObject?.first?.expiryDate == nil) {
            self.shareExpLbl.text = ""
        } else {
            self.shareExpLbl.text = "on ".localized() + Utility.convertDateFormat(inputDate: info?.responseObject?.first?.expiryDate ?? "")
        }
    
    }
    
    override func didMoveToWindow() {
        print("screen changed")
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        print("will move")
    }
    
    
    
    func appearanceSetup() {
        
        shareSubView.addShadow(cornerRadius: 20, shadowRadius: 3, opacity: 0.5, color: UIColor.black)
        containerView.addShadow(cornerRadius: 20, shadowRadius: 3, opacity: 0.5, color: UIColor.black)
        bounceAnimation(imageView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.handle?(.knowMoreTapped)
        }
    }
    
    @IBAction func whatsUpShareTap(_ sender: Any) {
        print("whatsapp")
    }
    
    @IBAction func fbShareTap(_ sender: Any) {
        print("fb")
    }
    
    @IBAction func instagramShareTap(_ sender: Any) {
        print("insta")
    }
    
    @IBAction func emailShareTap(_ sender: Any) {
        print("email")
    }
    
    /* @IBAction func rewardButtonAction() {
        handle?(.rewardTapped)
    } */
    
    @IBAction func gameBtnTap() {
        handle?(.gameTapped)
    }
    
    @IBAction func knowMoreButtonAction() {
        handle?(.knowMoreTapped)
    }
    
    @IBAction func homePageButtonAction() {
        handle?(.homePageTapped)
    }
    
    @IBAction func spinAgainButtonAction() {
        handle?(.spinAgainTapped)
    }
    
    @IBAction func shareBtnTap(_ sender: Any) {
        shareImage = captureUIImageFromUIView(shareContentView)
        shareMainView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showActionSheetView()
        }
    }
      
    //MARK: Share view
    
    // Convert view in to image
    
    
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

extension UIApplication {
    /// The top most view controller
    static var topMostViewController: UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController?.visibleView
    }
}

extension UIViewController {
    /// The visible view controller from a given view controller
    var visibleView: UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.visibleView
        } else if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.visibleView
        } else if let presentedViewController = presentedViewController {
            return presentedViewController.visibleView
        } else {
            return self
        }
    }
    
    func showToast(message: String) {
        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 20;
        toastContainer.clipsToBounds  =  true
        
        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font.withSize(12.0)
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        toastContainer.addSubview(toastLabel)
        self.view.addSubview(toastContainer)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = NSLayoutConstraint(item: toastLabel, attribute: .centerX, relatedBy: .equal, toItem: toastContainer, attribute: .centerXWithinMargins, multiplier: 1, constant: 0)
        let lableBottom = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let lableTop = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([centerX, lableBottom, lableTop])
        
        let containerCenterX = NSLayoutConstraint(item: toastContainer, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let containerTrailing = NSLayoutConstraint(item: toastContainer, attribute: .width, relatedBy: .equal, toItem: toastLabel, attribute: .width, multiplier: 1.1, constant: 0)
        let containerBottom = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -75)
        self.view.addConstraints([containerCenterX,containerTrailing, containerBottom])
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}

