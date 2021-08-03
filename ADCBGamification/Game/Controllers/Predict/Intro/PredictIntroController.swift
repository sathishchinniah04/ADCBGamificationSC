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
    var isDirectLoad: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        if !isDirectLoad {return}
        let con = self.navigationController
      //  (con as? CustomNavViewController)?.hideBackButton(isHide: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isDirectLoad {return}
        print("viewWillDisappear")
        let con = self.navigationController
            //   (con as? CustomNavViewController)?.hideBackButton(isHide: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    func initialSetup() {
        expireView.isUserInteractionEnabled = false
        expireView.alpha = 0.0
        if let gam = game {
            self.updateOnResponce(game: gam, error: nil)
        }
    }
    
    func updateOnResponce(game: Games?, error: GameError?) {
        if let gam = game {
            self.basedOnResponce(game: gam)
        }
        Utility.errorHandler(target: self, error: error)
    }
    
    func basedOnResponce(game: Games) {
        activityIndicator.stopAnimating()
        expireView.isUserInteractionEnabled = true
        self.game = game
        expireViewSetup()
        UIView.animate(withDuration: 0.3) {
            self.expireView.alpha = 1.0
        }
    }
    
    func expireViewSetup() {
        
        expireView.setupButtonName(name: "Predict Now".localized())
        expireView.populateView(isShowTerms: false, game: self.game) {
          self.nextController()
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let _ = self.navigationController
//        //(con as? CustomNavViewController)?.changeTitle(title: "SKY")
//    }
    
    func nextController() {
        let cont = UIStoryboard(name: "Predict", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "MatchListController") as! MatchListController
        cont.game = self.game
        self.navigationController?.pushViewController(cont, animated: true)
    }
}
