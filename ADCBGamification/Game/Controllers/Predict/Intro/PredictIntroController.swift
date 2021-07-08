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
        self.initialSetup()
    }
    
    func initialSetup() {
        expireView.isUserInteractionEnabled = false
        expireViewSetup()
        if let gam = game {
            self.updateOnResponce(game: gam)
        }
    }
    
    func updateOnResponce(game: Games) {
        print("Updated from game list type = \(game.gameType)  gameId  = \(game.gameId ?? "")")
        activityIndicator.stopAnimating()
        expireView.isUserInteractionEnabled = true
        self.game = game
    }
    
    
    func expireViewSetup() {
        expireView.button.setTitle("Predict Now", for: .normal)
        expireView.populateView(isShowTerms: false, game: self.game) {
          self.nextController()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let _ = self.navigationController
        //(con as? CustomNavViewController)?.changeTitle(title: "SKY")
    }
    
    func nextController() {
        let cont = UIStoryboard(name: "Predict", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "MatchListController")
        self.navigationController?.pushViewController(cont, animated: true)
    }
}
