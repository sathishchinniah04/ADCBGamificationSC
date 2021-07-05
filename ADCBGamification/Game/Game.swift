//
//  Game.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit
public class Game {
    public static func loadGame(controller: UIViewController) {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.goNext()
        //self.navigateToCOntroller(controller: controller, storyboard: "Spin", id: "SpinHomeController")
        self.navigateToController(controller: controller, storyboard: "Predict", id: "PredictIntroController")
       // self.navigateToController(controller: controller, storyboard: "Refer", id: "ReferIntroController")
    }
    
    static func navigateToController(controller: UIViewController, storyboard: String, id: String) {
        var cont: UIViewController?
        if #available(iOS 13.0, *) {
            let cont = UIStoryboard(name: storyboard, bundle: Bundle(for: Game.self)).instantiateViewController(identifier: id)
            let nav = CustomNavViewController(rootViewController: cont)
            nav.navigationBar.isHidden = true
            nav.modalPresentationStyle = .fullScreen
            controller.present(nav, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
        
        
    }
}
