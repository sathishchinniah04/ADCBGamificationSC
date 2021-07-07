//
//  Game.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit
public class Game {
    public static func loadGame(controller: UIViewController, msisdn: String, language: String) {
        getUrlFromInfoPlist()
        StoreManager.shared.msisdn = msisdn
        StoreManager.shared.language = language
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.goNext()
        StoreManager.shared.accessToken = "J0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9"
        
        GameListVM.getGameList(url: Constants.listGameUrl)
        //self.navigateToCOntroller(controller: controller, storyboard: "Spin", id: "SpinHomeController")
        self.navigateToController(controller: controller, storyboard: "Predict", id: "PredictIntroController")
       // self.navigateToController(controller: controller, storyboard: "Refer", id: "ReferIntroController")
    }
    
    static func navigateToController(controller: UIViewController, storyboard: String, id: String) {
    
        let cont = UIStoryboard(name: storyboard, bundle: Bundle(for: Game.self)).instantiateViewController(withIdentifier: id)
        let nav = CustomNavViewController(rootViewController: cont)
        nav.navigationBar.isHidden = true
        nav.modalPresentationStyle = .fullScreen
        controller.present(nav, animated: true, completion: nil)
    }
    
    private class func getUrlFromInfoPlist() {
        var resourceFileDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            resourceFileDictionary = NSDictionary(contentsOfFile: path)
        }
        if let resourceFileDictionaryContent = resourceFileDictionary {
            if let url = resourceFileDictionaryContent.object(forKey: "gameUrl") {
                StoreManager.shared.gameUrl = url as? String ?? ""
            }
        }
    }
}
