//
//  PredictIntroController.swift
//  ADCBGamification
//
//  Created by SKY on 02/07/21.
//

import UIKit

class PredictIntroController: UIViewController {
    @IBOutlet weak var customNav: CustomNavView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navInitialSetup()
    }
    
    func navInitialSetup() {
        customNav.populateView(sController: self)
    }
    @IBAction func nextController() {
        let cont = UIStoryboard(name: "Predict", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "PredictMatchController")
        
        self.navigationController?.pushViewController(cont, animated: true)
    }
}
