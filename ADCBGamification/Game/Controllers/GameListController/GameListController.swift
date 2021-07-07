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
//        GameListVM.getGameList(url: Constants.listGameUrl) {
//            DispatchQueue.main.async {
//                self.activityIndicatorView.stopAnimating()
//                self.games = GameListVM.allGames
//                self.gamesTableView.reloadData()
//            }
//        }
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
    
    
}
