//
//  SpinFailViewHelper.swift
//  ADCBGamification
//
//  Created by SKY on 22/07/21.
//

import UIKit
enum SpinFailViewAction {
    case gamePage
    case homePage
    case spinAgainTapped
}
class SpinFailViewHelper {
    private var view: SpinFailView?
    private var rootView = UIApplication.shared.windows.first
    
    func loadScreen(info: SpinAssignReward?, action:((SpinFailViewAction)->Void)?, gameObj: Games?) {
        DispatchQueue.main.async {
            self.removeView()
            self.rootView = UIApplication.shared.windows.first
            self.view = SpinFailView.loadXib()
            self.view?.frame = UIScreen.main.bounds
            self.rootView?.addSubview(self.view!)
            self.view?.populateView(info: info, action: action, game: gameObj)
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
