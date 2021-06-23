//
//  ReferSuccessPopupHelper.swift
//  Gamification
//
//  Created by SKY on 19/06/21.
//

import UIKit
class ReferSuccessPopupHelper {
    var view: ReferSuccessPopupView?
    var rootView = UIApplication.shared.windows.first
    var handle:(()->Void)?
    func show(complition:(()->Void)?) {
        DispatchQueue.main.async {
            self.removeView()
            self.view = ReferSuccessPopupView.loadXib()
            self.view?.frame = UIScreen.main.bounds
            self.rootView?.addSubview(self.view!)
            self.view?.populateView(complition: self.viewButtonAction)
            self.animatefadeup()
            self.handle = complition
        }
    }
    
    
    func viewButtonAction() {
        self.handle?()
        animateAndRemove()
    }
    
   private func animatefadeup() {
        self.view?.containerView.alpha = 0.0
        self.view?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        UIView.animate(withDuration: 0.3) {
            self.view?.containerView.alpha = 1.0
            self.view?.backgroundColor = UIColor.black.withAlphaComponent(0.30)
        } completion: { (done) in
            print("done")
        }

    }
    func animateAndRemove() {
        
        UIView.animate(withDuration: 0.3) {
            self.view?.containerView.alpha = 0.0
            self.view?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        } completion: { (done) in
            self.removeView()
        }
    }
    
    private  func removeView() {
        view?.removeFromSuperview()
        view = nil
        
    }
}
