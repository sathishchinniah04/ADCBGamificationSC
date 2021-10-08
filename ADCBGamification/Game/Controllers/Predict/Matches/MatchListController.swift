//
//  MatchListController.swift
//  ADCBGamification
//
//  Created by SKY on 02/07/21.
//

import UIKit



class MatchListController: UIViewController, PredictDateDelegate {
 
    
    @IBOutlet weak var matchTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var bgCloudImage: UIImageView!
//    @IBOutlet weak var visualTopView: UIVisualEffectView!
    
    var predictGame = PredictGame()
    var game: Games?
    var tournaments: [Tournaments]?
    override func viewDidLoad() {
        super.viewDidLoad()
//        visualTopView.isHidden = true
        registorCell()
        tableSetup()
        getMatchList()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        let con = self.navigationController
 
        (con as? CustomNavViewController)?.changeOnlyTitle(title: "Predict & Win".localized())
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
                if info.respCode == "SC0000" {
                    self.onSuccess(info: info)
                } else {
                    self.onFailure(info: info)
                }
            }
        }
    }
    func onSuccess(info: PredictGame) {
        
        self.predictGame = info
        self.tournaments = info.predictionList?.first?.tournaments
        self.matchTableView.reloadData()
    }
    
    func predictAction(_ isHomeAction: Bool) {
        
        if isHomeAction {
            self.dismiss(animated: true) {
                CallBack.shared.handle?(.homeAction)
            }
        } else {
            NotificationCenter.default.post(name: Notification.Name("ReloadGameList"), object: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }

    }
    
    func onFailure(info: PredictGame) {
        self.view.showAlert(singelBtn: true, ok: "Ok", title: "Alert", message: info.respDesc ?? "") { (done) in
            self.navigationController?.popViewController(animated: true)
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
        //self.visualTopView.isHidden = false
        controller.eventsList = event
        controller.selectedIndex = index.row
        controller.game = game
        controller.delegate = self
        controller.nav = self.navigationController
        controller.modalPresentationStyle = .overFullScreen
        //self.present(controller, animated: true, completion: nil)
        let navController = UINavigationController(rootViewController: controller)
        self.present(navController, animated: true, completion: nil)
        //self.navigationController?.pushViewController(controller, animated: true)
    }
}
