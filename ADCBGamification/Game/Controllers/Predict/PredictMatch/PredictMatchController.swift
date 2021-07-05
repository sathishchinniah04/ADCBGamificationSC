//
//  PredictMatchController.swift
//  ADCBGamification
//
//  Created by SKY on 02/07/21.
//

import UIKit

class PredictMatchController: UIViewController {
    
    @IBOutlet weak var customNavView: CustomNavView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navInitialSetup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let con = self.navigationController
        (con as? CustomNavViewController)?.changeTitle(title: "SHIV")
    }
    
    func navInitialSetup() {
        //customNavView.populateView(sController: self)
    }
}
