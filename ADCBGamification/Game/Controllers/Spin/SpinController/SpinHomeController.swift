//
//  SpinHomeController.swift
//  Gamification
//
//  Created by SKY on 20/06/21.
//

import UIKit


class SpinHomeController: UIViewController {
    
    @IBOutlet weak var expireView: ExpireView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var homeAnimationStaticView: AnimationView!
    @IBOutlet weak var lottiSpinAnimationView: AnimationView!
    
    @IBOutlet weak var spinDummyImgView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
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
    var timer = Timer()
    private var homeAnimationView: AnimationView?
    private var spinAnimationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()    
        self.initialSetup()
        self.animationSetUp()
        if let gam = game {
            updateOnResponce(game: gam, error: nil)
        }
        activityIndicatorView.startAnimating()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        if !isDirectLoad {return}
        con = self.navigationController
       // let con = self.navigationController
        (con as? CustomNavViewController)?.changeTitleAndSubTitle(title: nil, subTitle: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        con = self.navigationController
        (con as? CustomNavViewController)?.changeTitleAndSubTitle(title: nil, subTitle: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isDirectLoad {return}
        print("viewWillDisappear")
        con = self.navigationController
        
      //  (con as? CustomNavViewController)?.hideBackButton(isHide: false)
    }
    
    func animationSetUp() {
        homeAnimationStaticView.isHidden = false
        homeAnimationView = .init(name: "home")
        homeAnimationView!.frame = homeAnimationStaticView.bounds
        homeAnimationView!.contentMode = .scaleAspectFit
        homeAnimationView!.loopMode = .loop
        homeAnimationStaticView.addSubview(homeAnimationView!)
        
        lottiSpinAnimationView.isHidden = true
        self.spinAnimationView = .init(name: "sample")
        self.spinAnimationView!.frame = self.lottiSpinAnimationView.bounds
        self.spinAnimationView!.contentMode = .scaleAspectFill
        self.spinAnimationView!.animationSpeed = 0.5
        self.spinAnimationView!.loopMode = .playOnce
        self.lottiSpinAnimationView.addSubview(self.spinAnimationView!)
        
    }
    
    func updateOnResponce(game: Games?,error: GameError?) {
        if let gam = game {
            self.handlerBasedOnResponce(game: gam)
        }
        Utility.errorHandler(target: self, error: error)
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
        containerView.backgroundColor = UIColor.clear
        containerView.isHidden = true
        spinerView.hideSpinView()
        expireViewInitialSetup()
    }
    
    func expireViewInitialSetup() {
        self.expireView.alpha = 0.0
        expireView.setupButtonName(name: "Spin")
        expireView.isUserInteractionEnabled = false
        
    }
    
    func populateExpireView(game: Games) {
        self.spinDummyImgView.alpha = 1.0
        self.spinerView.enableSpinButton(hide: true)
        expireView.populateView(isShowTerms: false, game: self.game) {
            self.timer.invalidate()
            self.homeAnimationStaticView.isHidden = true
            (self.con as? CustomNavViewController)?.changeOnlyTitle(title: "Spin & Win")
            self.scaleToOrginalSize()
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
            self.containerView.isHidden = false
            self.expireView.isHidden = true
            
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
            self.scalingSpinerView(v: spinView, wContaner:wContainerView)
            
        default:
            break
        }
    }
    
    func scalingSpinerView(v: UIView, wContaner: UIView) {
        self.activityIndicatorView.stopAnimating()
        let v = v
        wheelView = wContaner
        let scaleX = spinDummyImgView.frame.size.width/v.frame.size.width
        let scaleY = spinDummyImgView.frame.size.height/v.frame.size.height
        spinDummyImgView.addSubview(v)
        spinDummyImgView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY).translatedBy(x: -50, y: 0)
        
        wContaner.transform = CGAffineTransform(rotationAngle: 0.5)
        rotate()
        timer =  Timer.scheduledTimer(withTimeInterval: 15.0, repeats: true) { (timer) in
            self.rotate()
        }
    }

    // MARK : Animations
   
    func rotate() {
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.homeAnimationView?.stop()
            UIView.animate(withDuration: 1.0, delay: 0.5, options: [], animations: { () -> Void in
                let rotate = CABasicAnimation(keyPath: "transform.rotation")
                rotate.fromValue = 0
                rotate.toValue = 5.5 * Double.random(in: 2..<6)
                rotate.duration = 5.0
                rotate.fillMode = CAMediaTimingFillMode.forwards
                rotate.isRemovedOnCompletion = false
                self.wheelView?.layer.add(rotate, forKey: "transform.rotation")
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    self.wheelView?.layer.removeAnimation(forKey: "rotationAnimation")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.homeAnimationView?.play()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    self.homeAnimationView?.stop()
                    UIView.animate(withDuration: 1.0, delay: 0.5, options: [], animations: { () -> Void in
                        let rotate = CABasicAnimation(keyPath: "transform.rotation")
                        rotate.toValue = 0
                        rotate.fromValue = 5.5 * Double.random(in: 2..<6)
                        rotate.duration = 5.0
                        rotate.fillMode = CAMediaTimingFillMode.forwards
                        rotate.isRemovedOnCompletion = false
                        self.wheelView?.layer.add(rotate, forKey: "transform.rotation")
                    }) { _ in
                        UIView.animate(withDuration: 0.5) {
                            self.wheelView?.layer.removeAnimation(forKey: "rotationAnimation")
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            self.homeAnimationView?.play()
                        }
                    }
                }
            }
            
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
            self.spinAssignReward = spinAssignReward
            if let inde = spinAssignReward.responseObject?.first?.achievmentId  {
                self.spinerView.stopAnimationAtIndex(achivementId: inde, complition: self.spinnerStopped(isPass:))
            } else {
                self.spinerView.stopAnimationAtIndex(achivementId: "1", complition: self.spinnerStopped(isPass:))
            }
        }
    }
    
    func spinnerStopped(isPass: Bool) {
        print("spinner stpped")
        self.lottiSpinAnimationView.isHidden = false
        if isPass {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.spinAnimationView?.play()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                self.spinSuccessView.loadScreen(info: self.spinAssignReward, action: self.successScreenActionHandler(action:))
            }
            
        } else {
                self.spinFailView.loadScreen(action: self.failScreenActionHandler(action:))
        }
    }
    
    func failScreenActionHandler(action: SpinFailViewAction) {
        switch action {
        case .gamePage:
            spinFailView.animateAndRemove()
            self.navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
    
    func successScreenActionHandler(action: SpinSuccessViewAction) {
        switch action {
        case .homePageTapped:
            print("home page tapped")
            self.spinSuccessView.animateAndRemove()
            self.navigationController?.popToRootViewController(animated: true)
        case .knowMoreTapped:
            print("Know more tapped")
            KnowMoreViewHelper.show(info: self.spinAssignReward)
        case .rewardTapped:
            print("Reward  tapped")
            CallBack.shared.handle?(.spinReward)
            CallBack.shared.handle?(.close)
            spinSuccessView.removeView()
            self.dismiss(animated: true, completion: nil)
        case .spinAgainTapped:
            self.spinSuccessView.animateAndRemove()
            self.spinerView.enableSpinButton()
            self.spinerView.enableSpinButton(hide: false)
            //self.navigationController?.popViewController(animated: true)
            print("Spin again tapped")
        default:
            break
        }
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
