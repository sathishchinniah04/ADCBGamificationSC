//
//  PredictSuccessHelper.swift
//  ADCBGamification
//
//  Created by SKY on 11/07/21.
//

import UIKit

class PredictSuccessHelper {
    var view: PredictSuccessView?
    var rootView = UIApplication.shared.windows.first
    
    func show(complition: ((PredictSuccessViewAction)->Void)?) {
        DispatchQueue.main.async {
            self.removeView()
            self.view = PredictSuccessView.loadXib()
            self.view?.frame = UIScreen.main.bounds
            self.rootView?.addSubview(self.view!)
            self.view?.populateView(complition: complition)
            self.animatefadeup()
        }
    }
    
    
    func viewButtonAction() {
        animateAndRemove()
    }
    
   private func animatefadeup() {
        self.view?.containerView.alpha = 0.0
       // self.view?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        UIView.animate(withDuration: 0.3) {
            self.view?.containerView.alpha = 1.0
         //   self.view?.backgroundColor = UIColor.black.withAlphaComponent(0.30)
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
