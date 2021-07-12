//
//  MatchListController.swift
//  ADCBGamification
//
//  Created by SKY on 02/07/21.
//

import UIKit

class MatchListController: UIViewController {
    @IBOutlet weak var matchTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var predictGame = PredictGame()
    var game: Games?
    var tournaments: [Tournaments]?
    override func viewDidLoad() {
        super.viewDidLoad()
        registorCell()
        tableSetup()
        getMatchList()
    }
    
    func tableSetup() {
        matchTableView.delegate = self
        matchTableView.dataSource = self
    }
    
    func registorCell() {
        matchTableView.register(UINib(nibName: "MatchTableViewCell", bundle: Bundle(for: Self.self)), forCellReuseIdentifier: "MatchTableViewCell")
    }
    
    func getMatchList() {
        guard let gam = game else { return }
        PredictViewModel.getPredictDetail(gameId: gam.gameId ?? "0") { (info) in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.predictGame = info
                self.tournaments = info.predictionList?.first?.tournaments
                self.matchTableView.reloadData()
            }
        }
    }
}

extension MatchListController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tournaments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournaments?[section].eventList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell") as! MatchTableViewCell
        Constants.leagueName = tournaments?[indexPath.section].tournamentName ?? ""
        let event = tournaments?[indexPath.section].eventList?[indexPath.row]
        cell.populateCell(index: indexPath.row, info: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt \(indexPath)")
        moveToController(index: indexPath)
    }
    
    func moveToController(index: IndexPath) {
        let controller = UIStoryboard(name: "Predict", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "PredictMatchController") as! PredictMatchController
        let event = tournaments?[index.section].eventList?[index.row]
        
        controller.eventsList = event
        controller.selectedIndex = index.row
        controller.game = game
        //self.present(controller, animated: true, completion: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
