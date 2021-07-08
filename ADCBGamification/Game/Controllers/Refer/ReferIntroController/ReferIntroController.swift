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
        self.expireView.populateView(game: game, complition: expireViewHandle)
        
    }
    
    func expireViewHandle() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                self.expireView.isHidden = true
            } completion: { (done) in
                self.navigate()
            }
        }
    }
    func navigate() {
        if #available(iOS 13.0, *) {
            let cont = UIStoryboard(name: "Refer", bundle: Bundle(for: ReferIntroController.self)).instantiateViewController(identifier: "ReferViewController") as! ReferViewController
            self.navigationController?.pushViewController(cont, animated: true)
        } else {
            // Fallback on earlier versions
        }
        
        
    }
}

