//
//  SpinerContainerHelper.swift
//  Gamification
//
//  Created by SKY on 20/06/21.
//

import UIKit
class SpinerContainerHelper {
    var view: SpinerContainerView?
    //var rootView = UIApplication.shared.windows.first
    
    func loadSpinner(sourceView: UIView) {
        DispatchQueue.main.async {
            self.removeView()
            //self.rootView = UIApplication.shared.windows.first
            self.view = SpinerContainerView.loadXib()
            self.view?.frame = sourceView.bounds//UIScreen.main.bounds
            self.view?.populateView()
            sourceView.addSubview(self.view!)
        }
    }
    
    func removeView() {
        view?.removeFromSuperview()
        view = nil
    }
}
