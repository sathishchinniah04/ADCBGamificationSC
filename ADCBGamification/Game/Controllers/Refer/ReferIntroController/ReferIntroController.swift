//
//  ReferIntroController.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit

class ReferIntroController: UIViewController {
    
    @IBOutlet weak var expireView: ExpireView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var game: Games?
    var isDirectLoad: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.expireView.populateView(isShowTerms: false, game: game, complition: expireViewHandle)
//
        initialSetup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        if !isDirectLoad {return}
        let con = self.navigationController
       // (con as? CustomNavViewController)?.hideBackButton(isHide: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isDirectLoad {return}
        print("viewWillDisappear")
        let con = self.navigationController
       // (con as? CustomNavViewController)?.hideBackButton(isHide: false)
    }
    func initialSetup() {
        expireView.setupButtonName(name: "Refer".localized())
        expireView.isUserInteractionEnabled = false
        expireView.alpha = 0.0
        if let gam = game {
            self.updateOnResponce(game: gam, error: nil)
        }
    }
    
    func updateOnResponce(game: Games?, error: GameError?) {
        if let gam = game {
            self.updateOnReponceHandler(game: gam)
        }
        Utility.errorHandler(target: self, error: error)
    }
    
    
    func updateOnReponceHandler(game: Games) {
        print("Updated from game list type = \(game.gameType)  gameId  = \(game.gameId ?? "")")
        self.game = game
        activityIndicatorView.stopAnimating()
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
    
    func nextController() {
        let cont = UIStoryboard(name: "Refer", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "ReferController") as! ReferController
        //cont.game = self.game
        self.navigationController?.pushViewController(cont, animated: true)
    }
    
//    func navigate() {
//
//            //let cont = UIStoryboard(name: "Refer", bundle: Bundle(for: ReferIntroController.self)).instantiateViewController(withIdentifier: "ReferViewController") as! ReferViewController
//            let cont = UIStoryboard(name: "Refer", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "ReferController") as! ReferController
//            self.navigationController?.pushViewController(cont, animated: true)
//
//    }
}

