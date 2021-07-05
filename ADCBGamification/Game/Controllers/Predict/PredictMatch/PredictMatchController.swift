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
    
    func navInitialSetup() {
        customNavView.populateView(sController: self)
    }
}
