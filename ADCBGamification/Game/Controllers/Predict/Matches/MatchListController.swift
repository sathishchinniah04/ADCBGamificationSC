//
//  MatchListController.swift
//  ADCBGamification
//
//  Created by SKY on 02/07/21.
//

import UIKit

class MatchListController: UIViewController {
    @IBOutlet weak var matchTableView: UITableView!
    var predictGame = PredictGame()
    var game: Games?
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
        PredictViewModel.getPredictDetail(gameId: game?.gameId ?? "0") { (info) in
            print("info is \(info)")
        }
    }
}

extension MatchListController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2//predictGame.predictionList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//predictGame.predictionList?[section].tournaments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell") as! MatchTableViewCell
        let tournaments = predictGame.predictionList?[indexPath.section].tournaments?[indexPath.row]
        cell.populateCell(index: indexPath.row, info: tournaments)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt \(indexPath)")
        moveToController()
    }
    
    func moveToController() {
        let controller = UIStoryboard(name: "Predict", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "PredictMatchController") as! PredictMatchController
        //self.present(controller, animated: true, completion: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
