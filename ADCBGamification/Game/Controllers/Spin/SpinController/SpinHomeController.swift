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
    @IBOutlet weak var spinDummyImgView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var spinerView = SpinerContainerHelper()
    var game: Games?
    var spinOffers: SpinOffers?
    var spinSuccessView = SpinSuccessViewHelper()
    override func viewDidLoad() {
        super.viewDidLoad()    
        self.initialSetup()
        
        if let gam = game {
            updateOnResponce(game: gam, error: nil)
        }
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
        expireView.populateView(isShowTerms: false, game: self.game) {
            self.spinDummyImgView.isHidden = true
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
            guard let off = self.spinOffers?.offers else { return }
            self.spinerView.populateSpinner(offer: off,complition: self.spinButtonTapped(action:))
        }
    }
    
    func spinButtonTapped(action: SpinerContainerViewAction) {
        switch action {
        case .spinTapped:
            print("Spin button tapped")
            self.assignRewards()
        default:
            break
        }
    }
    
    func getSpinOffers() {
        guard let gameId = self.game?.gameId else { return }
        SpinViewOfferVM.getOffers(gameId: gameId,complition: spinOffersResponce(data:))
    }
    
    func assignRewards() {
        guard let gameId = self.game?.gameId else { return }
        SpinViewOfferVM.assignReward(gameId: gameId) { (spinAssignReward) in
            if let inde = spinAssignReward.responseObject?.first?.achievmentId  {
                self.spinerView.stopAnimationAtIndex(index: inde, complition: self.spinnerStopped)
            }
        }
    }
    
    func spinnerStopped() {
        print("spinner stpped")
        spinSuccessView.loadScreen(action: successScreenActionHandler(action:))
    }
    
    func successScreenActionHandler(action: SpinSuccessViewAction) {
        switch action {
        case .homePageTapped:
            print("home page tapped")
            self.spinSuccessView.animateAndRemove()
            self.navigationController?.popToRootViewController(animated: true)
        case .knowMoreTapped:
            print("Know more tapped")
            KnowMoreViewHelper.show()
        case .rewardTapped:
            print("Reward  tapped")
        case .spinAgainTapped:
            self.spinSuccessView.animateAndRemove()
            self.navigationController?.popViewController(animated: true)
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
