//
//  KnowMoreViewHelper.swift
//  ADCBGamification
//
//  Created by SKY on 19/07/21.
//

import UIKit

class KnowMoreViewHelper {
    static var view: KnowMoreView?
    static var window = UIApplication.shared.windows.first
    
    static func show(info: SpinAssignReward?, action:((KnowMoreViewAction)->Void)?) {
        DispatchQueue.main.async {
            removeView()
            window = UIApplication.shared.windows.first
            view = KnowMoreView.loadXib()
            view?.frame = UIScreen.main.bounds
            view?.populateView(info: info, action: action)
            window?.addSubview(view!)
            animatefadeup()
            view?.handler = {
                animateAndRemove()
            }
        }
    }
    
    static private func animatefadeup() {
         view?.containerView.alpha = 0.0
        view?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
         UIView.animate(withDuration: 0.3) {
            view?.backgroundColor = UIColor.black.withAlphaComponent(0.40)
             view?.containerView.alpha = 1.0
         } completion: { (done) in
             print("done")
         }
     }
    
    static func animateAndRemove() {
         UIView.animate(withDuration: 0.3) {
             view?.containerView.alpha = 0.0
            
             view?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
         } completion: { (done) in
             removeView()
         }
     }
     
    static private func removeView() {
         view?.removeFromSuperview()
         view = nil
     }
}
