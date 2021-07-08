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
    var spinerView = SpinerContainerHelper()
    var game: Games?
    var spinOffers: SpinOffers?
    var spinSuccessView = SpinSuccessViewHelper()
    override func viewDidLoad() {
        super.viewDidLoad()    
        self.initialSetup()
        self.getSpinOffers()
    }
    
    func initialSetup() {
        containerView.isHidden = true
        expireView.setupButtonName(name: "Spin")
        expireView.populateView(game: self.game) {
            self.onAcceptingTermsAndConditon()
        }
    }
    
    func onAcceptingTermsAndConditon() {
        self.containerView.isHidden = false
        self.spinerView.loadSpinner(sourceView: self.containerView)
        self.expireView.isHidden = true
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
        case .knowMoreTapped:
            print("Know more tapped")
        case .rewardTapped:
            print("Reward  tapped")
        case .spinAgainTapped:
            print("Spin again tapped")
        default:
            break
        }
    }
    
    func spinOffersResponce(data: SpinOffers) {
        print("data got from respo \(data)")
        self.spinOffers = data
    }
}
