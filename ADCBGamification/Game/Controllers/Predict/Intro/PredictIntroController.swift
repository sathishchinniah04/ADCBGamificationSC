//
//  PredictIntroController.swift
//  ADCBGamification
//
//  Created by SKY on 02/07/21.
//

import UIKit

class PredictIntroController: UIViewController {
    @IBOutlet weak var expireView: ExpireView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var game: Games?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expireViewSetup()
        expireView.isUserInteractionEnabled = false
    }
    
    func updateOnResponce(game: Games) {
        print("Updated from game list")
        activityIndicator.stopAnimating()
        expireView.isUserInteractionEnabled = true
        self.game = game
    }
    
    
    func expireViewSetup() {
        expireView.isShowTerms = false
        expireView.button.setTitle("Predict Now", for: .normal)
        expireView.handler = {
            self.nextController()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let con = self.navigationController
        //(con as? CustomNavViewController)?.changeTitle(title: "SKY")
    }
    
    func nextController() {
        let cont = UIStoryboard(name: "Predict", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "MatchListController")
        self.navigationController?.pushViewController(cont, animated: true)
    }
}
