//
//  Game.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit
enum GameError {
    case noActiveGames
    case noGames
}

public enum GameAction {
    case backButton
    case homeAction
    case spinReward
}

public enum GameLanguage: String, CaseIterable {
    case EN, AR
}

public class Game {
    
    private static var controllerRef: UIViewController?
    
    public enum GameNames: String, CaseIterable {
        case SpinNWin
        case PredictNWin
        case ReferNWin
    }
    
    public static func dismissController() {
        print("Dismiss controler called")
        controllerRef?.dismiss(animated: true, completion: nil)
    }
    
    private static func getAllGamesList(_ gmeType: String, withCompletion completion: @escaping (_ gameId: String) -> Void) {
        GameListVM.getGameList(url: Constants.listGameUrl) {
            DispatchQueue.main.async {
                let gameId = GameListVM.allGames.filter({ $0.gameType.lowercased() == gmeType.lowercased() }).first?.gameId
                completion(gameId ?? "0")
            }
        }
    }
    
    public static func open(controller: UIViewController, msisdn: String, language: String, gameType: String, complition:((GameAction)->Void)?) {
        UIFont.loadMyFonts
        UIApplication.shared.windows.forEach { window in
            if #available(iOS 13.0, *) {
                window.overrideUserInterfaceStyle = .light
            } else {
                // Fallback on earlier versions
            }
        }
        getUrlFromInfoPlist()
        self.getAllGamesList(gameType, withCompletion : {(Id) in
            print("Game Language", language)
            StoreManager.shared.msisdn = msisdn
            StoreManager.shared.language = language
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.goNext()
            StoreManager.shared.accessToken = "J0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9"
            //complition = gameActionHandler(complition: <#T##((GameAction) -> Void)?##((GameAction) -> Void)?##(GameAction) -> Void#>)
            //complition = gameActionHandler(complition:)
            getControllerRef(controller: controller, gameType: gameType, gameId: Id)
            //loadGameList(controller: controller)
            CallBack.shared.callBacKAction { (action) in
                switch action {
                case .back:
                    print("game callback 1")
                    complition?(.backButton)
                case .homeAction:
                    print("game callback 2")
                    complition?(.homeAction)
                case .spinReward:
                    print("game callback 3")
                    complition?(.spinReward)
                default :
                    print("default called")
                }
            }
        })

    }
    
    
//    public static func openGameList(controller: UIViewController, msisdn: String, language: String) {
//        getUrlFromInfoPlist()
//        StoreManager.shared.msisdn = msisdn
//        StoreManager.shared.language = language
//        IQKeyboardManager.shared.enable = true
//        IQKeyboardManager.shared.goNext()
//
//        StoreManager.shared.accessToken = "J0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9"
//        //deleteThis(contr: controller)
//        //getControllerRef(controller: controller)
//        loadGameList(controller: controller)
//    }
    
    public static func openGameList(controller: UIViewController, msisdn: String, language: String, complition:((GameAction)->Void)?) {
        UIFont.loadMyFonts
        UIApplication.shared.windows.forEach { window in
            if #available(iOS 13.0, *) {
                window.overrideUserInterfaceStyle = .light
            } else {
                // Fallback on earlier versions
            }
        }
        getUrlFromInfoPlist()
        StoreManager.shared.msisdn = msisdn
        StoreManager.shared.language = language
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.goNext()
        
        StoreManager.shared.accessToken = "J0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9"
        paginationLoad(target: controller)
        CallBack.shared.callBacKAction { (action) in
            switch action {
            case .back:
                    complition?(.backButton)
            case .homeAction:
                complition?(.homeAction)
            case .spinReward:
                complition?(.spinReward)
            default :
                print("default")
            }
        }
    }
    
    static func paginationLoad(target: UIViewController) {
        
        let cont = UIStoryboard(name: "GameList", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "ADCBGameListController")
        
        let nav = CustomNavViewController(rootViewController: cont)
        nav.navigationBar.isHidden = true
        nav.modalPresentationStyle = .fullScreen
        
        controllerRef = nav
        target.present(nav, animated: true, completion: nil)
        
    }
    
    static func deleteThis(contr: UIViewController) {
        let cont = UIStoryboard(name: "Refer", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "ContactListController")
        contr.present(cont, animated: true, completion: nil)
    }
    
    private class func navigateToController(controller: UIViewController, storyboard: String, id: String) -> UIViewController {
    
        let cont = UIStoryboard(name: storyboard, bundle: Bundle(for: Game.self)).instantiateViewController(withIdentifier: id)
        
        let nav = CustomNavViewController(rootViewController: cont)
        nav.navigationBar.isHidden = true
        nav.modalPresentationStyle = .fullScreen
        controllerRef = nav
        controller.present(nav, animated: true, completion: nil)
        return cont
        //getControllerRef(gameType: gameType)
    }
    
    private class func getControllerRef(controller: UIViewController, gameType: String, gameId: String?) {
        if gameType == "PredictNWin" {
           let cont = self.navigateToController(controller: controller, storyboard: "Predict", id: "PredictIntroController") as? PredictIntroController
            cont?.isDirectLoad = true
            getGameList(gameType: gameType, gameId: gameId) { (games, error) in
                DispatchQueue.main.async {
                    cont?.updateOnResponce(game: games, error: error)
                }
            }
        } else if gameType == "SpinNWin" {
            let cont = self.navigateToController(controller: controller, storyboard: "Spin", id: "SpinHomeController") as? SpinHomeController
            cont?.isDirectLoad = true
            getGameList(gameType: gameType, gameId: gameId) { (game, error) in
                DispatchQueue.main.async {
                    cont?.updateOnResponce(game: game, error: error)
                }
            }
        } else if gameType == "ReferNWin" {
            let cont = self.navigateToController(controller: controller, storyboard: "Refer", id: "ReferIntroController") as? ReferIntroController
            cont?.isDirectLoad = true
            getGameList(gameType: gameType, gameId: gameId) { (games, error)  in
                DispatchQueue.main.async {
                    cont?.updateOnResponce(game: games, error: error)
            }
        }
        } else {
            print("No Game type match")
        }
}
        private class func getGameList(gameType: String, gameId: String?, complition:((Games?, GameError?)->Void)?) {
        GameListVM.getGame(url: Constants.listGameUrl, gameType: gameType, gameid: gameId) {
            print("Data is \(GameListVM.activeGames)")
            if let gam = GameListVM.activeGames.first {
                complition?(gam,nil)
            }
            if GameListVM.allGames.isEmpty {
                complition?(nil, .noGames)
            }
            if GameListVM.activeGames.isEmpty {
                complition?(nil, .noActiveGames)
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
