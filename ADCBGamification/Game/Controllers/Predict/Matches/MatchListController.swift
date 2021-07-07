//
//  MatchListController.swift
//  ADCBGamification
//
//  Created by SKY on 02/07/21.
//

import UIKit

class MatchListController: UIViewController {
    @IBOutlet weak var matchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registorCell()
        tableSetup()
    }
    
    func tableSetup() {
        matchTableView.delegate = self
        matchTableView.dataSource = self
    }
    
    func registorCell() {
        matchTableView.register(UINib(nibName: "MatchTableViewCell", bundle: Bundle(for: Self.self)), forCellReuseIdentifier: "MatchTableViewCell")
    }
}

extension MatchListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell") as! MatchTableViewCell
        cell.populateCell()
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
