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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.isHidden = true
        expireView.populateView {
            self.containerView.isHidden = false
            self.spinerView.loadSpinner(sourceView: self.containerView)
            self.expireView.isHidden = true
        }
    }
}
