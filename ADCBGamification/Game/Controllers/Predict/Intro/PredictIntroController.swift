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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let con = self.navigationController
        (con as? CustomNavViewController)?.changeTitle(title: "SKY")
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
    
    @IBAction func nextController() {
        let cont = UIStoryboard(name: "Predict", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "PredictMatchController")
        
        self.navigationController?.pushViewController(cont, animated: true)
    }
}
