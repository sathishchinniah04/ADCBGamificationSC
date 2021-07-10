//
//  Game.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit
public class Game {
    
    private static var controllerRef: UIViewController?
    
    public static func open(controller: UIViewController, msisdn: String, language: String, gameType: String, gameId: String?) {
        getUrlFromInfoPlist()
        StoreManager.shared.msisdn = msisdn
        StoreManager.shared.language = language
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.goNext()
        
        StoreManager.shared.accessToken = "J0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9"
        getControllerRef(controller: controller, gameType: gameType, gameId: gameId)
        //loadGameList(controller: controller)
    }
    
    public static func openGameList(controller: UIViewController, msisdn: String, language: String) {
        getUrlFromInfoPlist()
        StoreManager.shared.msisdn = msisdn
        StoreManager.shared.language = language
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.goNext()
        
        StoreManager.shared.accessToken = "J0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9"
        //deleteThis(contr: controller)
       // getControllerRef(controller: controller)
        loadGameList(controller: controller)
    }
    
    static func deleteThis(contr: UIViewController) {
        let cont = UIStoryboard(name: "Refer", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "ContactListController")
        contr.present(cont, animated: true, completion: nil)
    }
    
    private class func navigateToController(controller: UIViewController, storyboard: String, id: String) -> UIViewController {
    
        let cont = UIStoryboard(name: storyboard, bundle: Bundle(for: Game.self)).instantiateViewController(withIdentifier: id)
        controllerRef = cont
        let nav = CustomNavViewController(rootViewController: cont)
        nav.navigationBar.isHidden = true
        nav.modalPresentationStyle = .fullScreen
        controller.present(nav, animated: true, completion: nil)
        return cont
        //getControllerRef(gameType: gameType)
    }
    
    private class func getControllerRef(controller: UIViewController, gameType: String, gameId: String?) {
        if gameType == "PredictNWin" {
           let cont = self.navigateToController(controller: controller, storyboard: "Predict", id: "PredictIntroController") as? PredictIntroController
            getGameList(gameType: gameType, gameId: gameId) { (games) in
                DispatchQueue.main.async {
                    cont?.updateOnResponce(game: games)
                }
            }
        } else if gameType == "Spin" {
            let cont = self.navigateToController(controller: controller, storyboard: "Spin", id: "SpinHomeController") as? SpinHomeController
        } else if gameType == "Refer" {
            let cont = self.navigateToController(controller: controller, storyboard: "Refer", id: "ReferIntroController") as? ReferIntroController
        } else {
            print("Game type does not match")
        }
    }
    
    private static func getGameList(gameType: String, gameId: String?, complition:((Games)->Void)?) {
        GameListVM.getGame(url: Constants.listGameUrl, gameType: gameType, gameid: gameId) {
            print("Data is \(GameListVM.activeGames)")
            if let gam = GameListVM.activeGames.first {
                complition?(gam)
            }
        }
    }
    
    private class func loadGameList(controller: UIViewController) {
        let cont = UIStoryboard(name: "GameList", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "GameListController")
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
