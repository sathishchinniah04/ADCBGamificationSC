//
//  ReferSuccessViewHelper.swift
//  ADCBGamification
//
//  Created by SKY on 08/07/21.
//

import UIKit

class ReferSuccessViewHelper {
    private var view: ReferSuccessView?
    private var rootView = UIApplication.shared.windows.first
    
    func loadScreen(status: ReferralStatus?, message: String , info: SpinAssignReward?, action:((ReferSuccessViewAction)->Void)?) {
        DispatchQueue.main.async {
            self.removeView()
            self.rootView = UIApplication.shared.windows.first
            self.view = ReferSuccessView.loadXib()
            self.view?.frame = UIScreen.main.bounds
            self.rootView?.addSubview(self.view!)
            self.view?.populateView(info: info,status: status!, action: action)
            self.view?.referalStatus = status
            self.view?.txtMessage = message
            self.animateUp()
        }
    }
    
   private func animateUp() {
        self.view?.alpha = 0.0
        UIView.animate(withDuration: 0.3) {
            self.view?.alpha = 1.0
        } completion: { (done) in
            print("done")
        }
    }
    
     func animateAndRemove() {
        UIView.animate(withDuration: 0.3) {
            self.view?.alpha = 0.0
        } completion: { (done) in
            self.removeView()
        }
    }
    
    func removeView() {
        view?.removeFromSuperview()
        view = nil
    }
}
