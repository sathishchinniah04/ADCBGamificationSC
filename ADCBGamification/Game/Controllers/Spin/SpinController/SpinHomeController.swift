//
//  SpinHomeController.swift
//  Gamification
//
//  Created by SKY on 20/06/21.
//

import UIKit

class SpinHomeController: UIViewController {
    @IBOutlet weak var expireView: ExpireView!
    var spinerView = SpinerContainerHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        expireView.populateView {
            self.spinerView.loadSpinner()
            self.expireView.isHidden = true
        }
    }
}
