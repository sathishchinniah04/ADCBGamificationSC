//
//  PredictMatchController.swift
//  ADCBGamification
//
//  Created by SKY on 02/07/21.
//

import UIKit

class PredictMatchController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonContainerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navInitialSetup()
        tableSetup()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            self.buttonContainerView.addShadow(cornerRadius:0, shadowRadius: 5, opacity: 0.5)
        }
    }

    func tableSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PredictMatchTableViewCell", bundle: Bundle(for: Self.self)), forCellReuseIdentifier: "PredictMatchTableViewCell")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let con = self.navigationController
        //(con as? CustomNavViewController)?.changeTitle(title: "SHIV")
    }
    
    func navInitialSetup() {
        //customNavView.populateView(sController: self)
    }
}

extension PredictMatchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PredictMatchTableViewCell") as! PredictMatchTableViewCell
        cell.populateView(index: indexPath.row)
        return cell
    }
    
    
}
