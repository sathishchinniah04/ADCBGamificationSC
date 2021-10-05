//
//  GameListController.swift
//  ADCBGamification
//
//  Created by SKY on 07/07/21.
//

import UIKit

class GameListController: UIViewController {
    @IBOutlet weak var gamesTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var games = [Games]()
    var contRef: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        getResponce()
        
    }
    
    func tableViewSetup() {
        gamesTableView.delegate = self
        gamesTableView.dataSource = self
        gamesTableView.register(UINib(nibName: "GameListTableViewCell", bundle: Bundle(for: Self.self)), forCellReuseIdentifier: "GameListTableViewCell")
    }
    
    func getResponce() {
        GameListVM.getGameList(url: Constants.listGameUrl) { (success) in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.games = GameListVM.allGames
                self.gamesTableView.reloadData()
            }
        }
    }
}

extension GameListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameListTableViewCell") as! GameListTableViewCell
        cell.populateView(game: self.games[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameType = self.games[indexPath.row].gameType
        let game = self.games[indexPath.row]
        getControllerRef(gameType: gameType, game: game)
    }
    
    func moveToController(sName: String, id: String, gameType: String, game: Games) {
        let contr = UIStoryboard(name: sName, bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: id)
        if gameType == "PredictNWin" {
            (contr as? PredictIntroController)?.game = game
        } else if gameType == "SpinNWin" {
            (contr as? SpinHomeController)?.game = game
        } else if gameType == "ReferNWin" {
            (contr as? ReferIntroController)?.game = game
        }
        self.navigationController?.pushViewController(contr, animated: true)
    }
    
    func getControllerRef(gameType: String, game: Games) {
        if gameType == "SpinNWin" {
            self.moveToController(sName: "Spin", id: "SpinHomeController", gameType: gameType, game: game)
        } else if gameType == "PredictNWin" {
            self.moveToController(sName: "Predict", id: "PredictIntroController", gameType: gameType, game: game)
        } else if gameType == "ReferNWin" {
            self.moveToController(sName: "Refer", id: "ReferIntroController", gameType: gameType, game: game)
        } else {
            print("no game type ")
        }
    }
}
