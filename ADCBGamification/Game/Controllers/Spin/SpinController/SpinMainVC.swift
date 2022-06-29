//
//  SpinHomeController.swift
//  Gamification
//
//  Created by SKY on 20/06/21.
//

import UIKit


class SpinMainVC: UIViewController {
    
    @IBOutlet weak var expireView: ExpireView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var homeAnimationStaticView: AnimationView!
    @IBOutlet weak var lottiSpinAnimationView: AnimationView!
    
    @IBOutlet weak var spinDummyImgView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var bgCloudImage: UIImageView!
    @IBOutlet weak var spinHomeBgView: UIImageView!
    @IBOutlet weak var spinBtn: UIButton!
    
    var spinerView = SpinerContainerHelper()
    var game: Games?
    var isDirectLoad: Bool = false
    var spinOffers: SpinOffers?
    var spinAssignReward: SpinAssignReward?
    var spinSuccessView = SpinSuccessViewHelper()
    var spinFailView = SpinFailViewHelper()
    var gameIndex: IndexPath?
    var con: UINavigationController?
    var wheelView: UIView?
    var spinNowTapped: Bool = false
    private var homeAnimationView: AnimationView?
    private var spinAnimationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        (con as? CustomNavViewController)?.nav.disableBackAction = self.expireView.isHidden
        self.spinBtn.setTitle("Spin".localized(), for: .normal)
        self.spinDummyImgView.isHidden = true
        self.lottiSpinAnimationView.isHidden = true
        self.homeAnimationStaticView.isHidden = true
       // self.animationSetUp()
//        activityIndicatorView.startAnimating()
        if let gam = game {
            updateOnResponce(game: gam, error: nil)
        }
        activityIndicatorView.startAnimating()
        checkLeftToRight()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        self.spinHomeBgView.image = UIImage(named: (StoreManager.shared.language.lowercased() == "en") ? "SpinHome" : "spin_arabic", in: Bundle(for: CustomNavView.self), compatibleWith: nil)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        //activityIndicatorView.startAnimating()
        //self.expireView.genericButton.button.isUserInteractionEnabled = false
        con = self.navigationController
       // let con = self.navigationController
        (con as? CustomNavViewController)?.changeTitleAndSubTitle(title: nil, subTitle: nil)
        (con as? CustomNavViewController)?.showLogo()
        //self.spinerView.startRotate()
        //self.expireView.genericButton.alpha = 0.5
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            print("spin going to stop")
//            self.spinerView.stopAnimationAtIndex(achivementId: "1") { (stopped) in
//                if stopped {
//                    self.expireView.genericButton.alpha = 1.0
//                    self.activityIndicatorView.stopAnimating()
//                    self.expireView.genericButton.button.isUserInteractionEnabled = true
//                }
//
//            }
//        }
        if !isDirectLoad {return}

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //con = self.navigationController
       // (con as? CustomNavViewController)?.changeTitleAndSubTitle(title: nil, subTitle: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
        if isDirectLoad {return}
        
        print("viewWillDisappear")
        
        con = self.navigationController
        
//        if self.isMovingFromParent {
//
//            if self.expireView.isHidden {
//                self.spinHomeBgView.isHidden = false
//                self.spinDummyImgView.isHidden = true
//                self.containerView.isHidden = true
//                self.expireView.isHidden = false
//                self.spinBtn.isHidden = true
//                self.nukeAllAnimations()
//                self.wheelView?.layer.removeAllAnimations()
//            } else {
//                print("first screen")
//            }
//        }
      //  (con as? CustomNavViewController)?.hideBackButton(isHide: false)
    }
    
    func animationSetUp() {
        
        lottiSpinAnimationView.isHidden = true
        homeAnimationStaticView.isHidden = false
        homeAnimationView = .init(name: "home")
        homeAnimationView!.frame = homeAnimationStaticView.bounds
        homeAnimationView!.contentMode = .scaleAspectFit
        homeAnimationView!.loopMode = .loop
        homeAnimationStaticView.addSubview(homeAnimationView!)
    
    }
    
    @IBAction func spinBtnAction(_ sender: Any) {
        
        self.spinNowTapped = true
        self.spinBtn.isHidden = true
        self.spinerView.startRotate()
        self.assignRewards()
        if let ind = self.gameIndex {
            CallBack.shared.handle?(.gamePlayed(ind))
        }
        UIView.animate(withDuration: 0.8) {
            //self.spinDummyImgView.isHidden = true
            self.spinDummyImgView.alpha = 1.0
        } completion: { (done) in
            print("Animation done")
        }
        self.spinerView.unHideSpinView()
    }
    
    func updateOnResponce(game: Games?,error: GameError?) {
        if let gam = game {
            self.handlerBasedOnResponce(game: gam)
        }
        Utility.errorHandler(target: self, error: error)
    }
    
    
    func updateErrorOnResponce(errorMsg: String, isSuccess: Bool) {
        self.showToast(message: errorMsg)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func handlerBasedOnResponce(game: Games) {
        print("Updated from game list type = \(game.gameType)  gameId  = \(game.gameId ?? "")")
        activityIndicatorView.stopAnimating()
        expireView.isUserInteractionEnabled = true
        self.game = game
        self.getSpinOffers()
        self.populateExpireView(game: game)
        UIView.animate(withDuration: 0.3) {
            self.expireView.alpha = 1.0
        }
    }
    
    
    func initialSetup() {
        self.spinBtn.isHidden = true
        containerView.backgroundColor = UIColor.clear
        containerView.isHidden = true
        spinerView.hideSpinView()
        expireViewInitialSetup()
    }
    
    func expireViewInitialSetup() {
        self.expireView.alpha = 0.0
        expireView.setupButtonName(name: "Play".localized())
        expireView.isUserInteractionEnabled = false
        
    }

    
    func populateExpireView(game: Games) {
        self.spinDummyImgView.alpha = 1.0
        self.spinerView.enableSpinButton(hide: true)
        expireView.populateView(isShowTerms: false, game: self.game) {
            if self.expireView.genericButton.button.titleLabel?.text == "Play".localized() {
                self.spinerView.enableSpinButton(hide: true)
              self.expireView.setupButtonName(name: "Spin".localized())
                self.homeAnimationStaticView.isHidden = true
                (self.con as? CustomNavViewController)?.changeOnlyTitle(title: "Spin & Win".localized())
                self.spinHomeBgView.isHidden = true
                self.spinDummyImgView.isHidden = false
                self.containerView.isHidden = false
                self.expireView.isHidden = true
                (self.con as? CustomNavViewController)?.nav.disableBackAction = self.expireView.isHidden
                self.spinBtn.isHidden = false
                self.nukeAllAnimations()
                self.wheelView?.layer.removeAllAnimations()
                
                
            } else {
                
            }
            
           /* self.spinHomeBgView.isHidden = true
            self.spinDummyImgView.isHidden = false
            self.spinNowTapped = true
            self.nukeAllAnimations()
            self.wheelView?.layer.removeAllAnimations()
            self.homeAnimationStaticView.isHidden = true
            (self.con as? CustomNavViewController)?.changeOnlyTitle(title: "Spin & Win".localized())
            self.scaleToOrginalSize()
            self.spinerView.startRotate()
            self.assignRewards()
            if let ind = self.gameIndex {
                CallBack.shared.handle?(.gamePlayed(ind))
            }
            UIView.animate(withDuration: 0.8) {
                self.spinDummyImgView.alpha = 1.0
            } completion: { (done) in
                print("Animation done")
            }
            self.spinerView.unHideSpinView()
            self.containerView.isHidden = false
            self.expireView.isHidden = true */
            
        }
    }
    
    func onAcceptingTermsAndConditon() {
        //self.containerView.isHidden = false
        self.spinerView.loadSpinner(sourceView: self.containerView)
        //self.expireView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.spinerView.enableSpinButton(hide: true)
            guard let off = self.spinOffers?.offers else { return }
            self.spinerView.populateSpinner(offer: off,complition: self.spinButtonTapped(action:))
        }
    }
    
    func spinButtonTapped(action: SpinerContainerViewAction) {
        switch action {
        case .spinTapped:
            print("Spin button tapped")
            self.assignRewards()
        case .view(let spinView, let wContainerView):
//            self.scalingSpinerView(v: spinView, wContaner:wContainerView)
            break;
        default:
            break
        }
    }
    
    func scalingSpinerView(v: UIView, wContaner: UIView) {
        self.spinDummyImgView.isHidden = true
       // self.activityIndicatorView.stopAnimating()
        let v = v
        wheelView = wContaner
        let scaleX = spinDummyImgView.frame.size.width/v.frame.size.width
        let scaleY = spinDummyImgView.frame.size.height/v.frame.size.height
        spinDummyImgView.addSubview(v)
        spinDummyImgView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY).translatedBy(x: -50, y: 0)
        // wContaner.transform = CGAffineTransform(rotationAngle: 0.5)
        //rotate()
    }

    // MARK : Animations
    func nukeAllAnimations() {
        self.view.subviews.forEach({$0.layer.removeAllAnimations()})
        self.view.layer.removeAllAnimations()
        self.view.layoutIfNeeded()
    }
    

    func rotate() {


        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.homeAnimationView?.stop()
            UIView.animate(withDuration: 1.0, delay: 0.5, options: [], animations: { () -> Void in
                let rotate = CABasicAnimation(keyPath: "transform.rotation")
                rotate.fromValue = 0
                rotate.toValue = 1.05 * Float.pi * 2.0
                rotate.duration = 8
                rotate.speed = 2
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    rotate.speed = 0.5
                }
                
                rotate.fillMode = CAMediaTimingFillMode.forwards
                rotate.isRemovedOnCompletion = false
                rotate.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
                self.wheelView?.layer.add(rotate, forKey: "transform.rotation")
            }) { _ in

                UIView.animate(withDuration: 0.2, delay: 0.5, options: [.curveEaseOut], animations: { () -> Void in
                    self.wheelView?.layer.removeAnimation(forKey: "rotationAnimation")
                })
                // 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    if !self.spinNowTapped {
                        self.homeAnimationView?.play()
                    }
                }
                

                // 2
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    if !self.spinNowTapped {
                        self.homeAnimationView?.stop()
                        UIView.animate(withDuration: 1.0, delay: 0.5, options: [], animations: { () -> Void in
                            let rotate = CABasicAnimation(keyPath: "transform.rotation")
                            rotate.toValue = 0
                            rotate.fromValue = 1.05 * Float.pi * 2.5
                            rotate.duration = 8
                            rotate.speed = 2.0
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                rotate.speed = 0.1
                            }
                            rotate.fillMode = CAMediaTimingFillMode.forwards
                            rotate.isRemovedOnCompletion = false
                            rotate.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
                            self.wheelView?.layer.add(rotate, forKey: "transform.rotation")
                        }) { _ in
//
                            UIView.animate(withDuration: 0.2, delay: 0.5, options: [], animations: { () -> Void in
                                self.wheelView?.layer.removeAnimation(forKey: "rotationAnimation")
                            })

                            // 3
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                if !self.spinNowTapped {
                                    self.homeAnimationView?.play()
                                }

                            }
//
//                            // 4
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                if !self.spinNowTapped {
                                    self.homeAnimationView?.stop()
                                    self.slowClockRotateWheelAnimation()
                                }
//
                            }

                        }
                    }


                }
            }
        }

    }

    
    func slowClockRotateWheelAnimation() {

        CATransaction.begin()
        CATransaction.setCompletionBlock({
            if !self.spinNowTapped {
                DispatchQueue.main.asyncAfter(deadline: .now() - 2) {
                    UIView.animate(withDuration: 0.2, delay: 0.5, options: [], animations: { () -> Void in
                        self.wheelView?.layer.removeAnimation(forKey: "rotationAnimation")
                    })
                    self.slowAnticlockRotateWheelAnimation()
                }
            }
        })
        
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = 0
        rotate.toValue = 1.1 * Float.pi * 1.0
        rotate.duration = 10.0
        rotate.isRemovedOnCompletion = true
        self.wheelView?.layer.add(rotate, forKey: "transform.rotation")
        CATransaction.commit()
    }
    
    func slowAnticlockRotateWheelAnimation() {

        CATransaction.begin()
        CATransaction.setCompletionBlock({
            if !self.spinNowTapped {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    UIView.animate(withDuration: 0.2, delay: 0.5, options: [], animations: { () -> Void in
                        self.wheelView?.layer.removeAnimation(forKey: "rotationAnimation")
                    })
                    self.slowClockRotateWheelAnimation()
                }
            }
        })
        
        if !self.spinNowTapped {
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.toValue = 0
        rotate.fromValue = 1.1 * Float.pi * 1.0
        rotate.duration = 10.0
        rotate.isRemovedOnCompletion = true
        self.wheelView?.layer.add(rotate, forKey: "transform.rotation")
        CATransaction.commit()
        }
        
        if self.spinNowTapped {
            self.wheelView?.layer.removeAnimation(forKey: "rotationAnimation")
        }
    }
    
    
    func scaleToOrginalSize() {
        let gap = spinDummyImgView.center.y - self.view.center.y
        print("gaping = \(gap)")
        UIView.animate(withDuration: 0.5) {
                //self.spinDummyImgView.transform = .identity
            self.spinDummyImgView.transform = CGAffineTransform(translationX: -50, y: (-1*gap)/1.0)
            }
    }
    
    func getSpinOffers() {
        guard let gameId = self.game?.gameId else { return }
        SpinViewOfferVM.getOffers(gameId: gameId,complition: spinOffersResponce(data:))
    }
    
    func assignRewards() {
        guard let gameId = self.game?.gameId else { return }
        SpinViewOfferVM.assignReward(gameId: gameId) { (spinAssignReward) in
            if spinAssignReward != nil {
                self.spinAssignReward = spinAssignReward
                if let inde = spinAssignReward?.responseObject?.first?.achievmentId  {
                    print(inde)
                    self.spinerView.stopAnimationAtIndex(achivementId: inde, complition: self.spinnerStopped(isPass:))
                } else {
                    self.spinerView.stopAnimationAtIndex(achivementId: "0", complition: self.spinnerStopped(isPass:))
                }
            } else {
                self.spinerView.stopAnimationAtIndex(achivementId: "0", complition: self.spinnerStopped(isPass:))
            }
        }
    }
    
    func spinSuccessAnimation() {
        
        lottiSpinAnimationView.isHidden = false
        self.spinAnimationView = .init(name: "spin_success_new", bundle: Bundle(for: Self.self), imageProvider: nil, animationCache: nil)
//        self.spinAnimationView = .init(name: "spin_success_new", bundle: Bundle(for: SpinMainVC.self), imageProvider: nil, animationCache: nil)
            //.init(name: "spin_success_new")
        self.spinAnimationView!.frame = self.lottiSpinAnimationView.bounds
        self.spinAnimationView!.contentMode = .scaleAspectFill
        self.spinAnimationView!.animationSpeed = 1.0
        self.spinAnimationView!.loopMode = .playOnce
        self.lottiSpinAnimationView.addSubview(self.spinAnimationView!)
        self.spinAnimationView?.play()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//
//            self.spinAnimationView = .init(name: "sparkle")
//            self.spinAnimationView!.frame = self.lottiSpinAnimationView.bounds
//            self.spinAnimationView!.contentMode = .scaleAspectFill
//            self.spinAnimationView!.animationSpeed = 0.5
//            self.spinAnimationView!.loopMode = .playOnce
//            self.lottiSpinAnimationView.addSubview(self.spinAnimationView!)
//            self.spinAnimationView?.play()
//        }
        
        
    }
    
    func spinnerStopped(isPass: Bool) {
        print("spinner stpped")
        
        if isPass {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
               self.spinSuccessAnimation()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.lottiSpinAnimationView.isHidden = true
                self.spinSuccessView.loadScreen(info: self.spinAssignReward, gameObj: self.game,action: self.successScreenActionHandler(action:))
            }
            
        } else {
            self.spinFailView.loadScreen(info: self.spinAssignReward, action: self.failScreenActionHandler(action:), gameObj: self.game)
            //self.spinSuccessView.loadScreen(info: self.spinAssignReward, action: self.successScreenActionHandler(action:))
        }
    }
    
    func failScreenActionHandler(action: SpinFailViewAction) {
        switch action {
        case .gamePage:
            spinFailView.animateAndRemove()
            self.navigationController?.popViewController(animated: true)
        case .homePage:
            spinFailView.animateAndRemove()
            self.dismiss(animated: true) {
                CallBack.shared.handle?(.homeAction)
            }
        case .spinAgainTapped:
            self.spinFailView.animateAndRemove()
            self.spinerView.enableSpinButton()
            self.spinerView.enableSpinButton(hide: false)
            print("Spin again tapped")
        default:
            break
        }
    }
    
    func knowMoreAction(action: KnowMoreViewAction) {
        
        switch action {
        case .knowmore:
            print("know more page tapped")
            self.spinSuccessView.animateAndRemove()
            self.dismiss(animated: true) {
                CallBack.shared.handle?(.knowMoreAction)
            }
        default:
            break;
        }
    }
    
    func successScreenActionHandler(action: SpinSuccessViewAction) {
        switch action {
        case .homePageTapped:
            print("home page tapped")
            self.spinSuccessView.animateAndRemove()
            self.dismiss(animated: true) {
                CallBack.shared.handle?(.homeAction)
            }
        case .knowMoreTapped:
            print("Know more tapped")
            KnowMoreViewHelper.show(info: self.spinAssignReward, action: self.knowMoreAction(action:))
        case .rewardTapped:
            print("Reward  tapped")
            CallBack.shared.handle?(.spinReward)
            CallBack.shared.handle?(.homeAction)
            spinSuccessView.removeView()
            self.dismiss(animated: true, completion: nil)
        case .spinAgainTapped:
            self.spinSuccessView.animateAndRemove()
            self.spinerView.enableSpinButton()
            self.spinerView.enableSpinButton(hide: false)
            //self.navigationController?.popViewController(animated: true)
            print("Spin again tapped")
        case .gameTapped:
            self.spinSuccessView.animateAndRemove()
            self.navigationController?.popToRootViewController(animated: true)
        case .shareTapped:
            print("share the content")
            shareTapped()
        default:
            break
        }
    }
    
    func shareTapped() {
        
    }
    
    func spinOffersResponce(data: SpinOffers) {
        print("data got from respo \(data)")
        DispatchQueue.main.async {
            if data.respCode == "SC0000" {
                self.onSuccess(info: data)
            } else {
                self.onFailure(info: data)
            }
            self.activityIndicatorView.stopAnimating()
        }
    }
    func onSuccess(info: SpinOffers) {
        self.spinOffers = info
        self.onAcceptingTermsAndConditon()
    }
    func onFailure(info: SpinOffers) {
        self.view.showAlert(singelBtn: true, ok: "Ok", title: "Alert", message: info.respDesc ?? "") { (done) in
            self.navigationController?.popViewController(animated: true)
        }
    }
}
