//
//  SpinerContainerHelper.swift
//  Gamification
//
//  Created by SKY on 20/06/21.
//

import UIKit
class SpinerContainerHelper {
    var view: SpinerContainerView?
    var rootView = UIApplication.shared.windows.first
    
    func loadSpinner() {
        DispatchQueue.main.async {
            self.removeView()
            self.rootView = UIApplication.shared.windows.first
            self.view = SpinerContainerView.loadXib()
            self.view?.frame = UIScreen.main.bounds
            self.view?.populateView()
            self.rootView?.addSubview(self.view!)
        }
    }
    
    func removeView() {
        view?.removeFromSuperview()
        view = nil
    }
}
