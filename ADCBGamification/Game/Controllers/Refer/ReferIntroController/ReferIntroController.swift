//
//  ReferIntroController.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit

class ReferIntroController: UIViewController {
    
    @IBOutlet weak var expireView: ExpireView!
    var game: Games?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.expireView.populateView(isShowTerms: false, game: game, complition: expireViewHandle)
        
    }
    
    func updateOnResponce(game: Games) {
        print("Updated from game list type = \(game.gameType)  gameId  = \(game.gameId ?? "")")
        //activityIndicator.stopAnimating()
        expireView.isUserInteractionEnabled = true
        self.game = game
    }
    func expireViewHandle() {
        DispatchQueue.main.async {
            self.navigate()
//            UIView.animate(withDuration: 0.3) {
//                self.expireView.isHidden = false
//            } completion: { (done) in
//                self.navigate()
//            }
        }
    }
    func navigate() {
        
            //let cont = UIStoryboard(name: "Refer", bundle: Bundle(for: ReferIntroController.self)).instantiateViewController(withIdentifier: "ReferViewController") as! ReferViewController
            let cont = UIStoryboard(name: "Refer", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "ReferController") as! ReferController
            self.navigationController?.pushViewController(cont, animated: true)
        
    }
}

