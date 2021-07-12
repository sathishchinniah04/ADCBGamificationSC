//
//  SpinerContainerHelper.swift
//  Gamification
//
//  Created by SKY on 20/06/21.
//

import UIKit
class SpinerContainerHelper {
    var view: SpinerContainerView?
    func loadSpinner(sourceView: UIView) {
        DispatchQueue.main.async {
            self.removeView()
            self.view = SpinerContainerView.loadXib()
            self.view?.frame = sourceView.bounds
            self.view?.populateView()
            sourceView.addSubview(self.view!)
        }
    }
    
    func stopAnimationAtIndex(index: String, complition:(()->Void)?) {
        self.view?.stopAnimationAtIndex(index: index, complition: complition)
    }
    
    func populateSpinner(offer: [Offers],complition:((SpinerContainerViewAction)->Void)?) {
        self.view?.populateSpinner(offer: offer, complition: complition)
    }
    
    func hideSpinView() {
        self.view?.isHidden = true
    }
    
    func unHideSpinView() {
        self.view?.isHidden = false
    }
    
    func removeView() {
        view?.removeFromSuperview()
        view = nil
    }
}
