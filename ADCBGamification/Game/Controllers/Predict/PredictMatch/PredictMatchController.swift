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
    var eventsList: EventsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navInitialSetup()
        tableSetup()
        self.buttonContainerView.addShadow(cornerRadius:0, shadowRadius: 2, opacity: 0.5)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }

    func tableSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PredictMatchTableViewCell", bundle: Bundle(for: Self.self)), forCellReuseIdentifier: "PredictMatchTableViewCell")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let _ = self.navigationController
        //(con as? CustomNavViewController)?.changeTitle(title: "SHIV")
    }
    
    func navInitialSetup() {
        //customNavView.populateView(sController: self)
    }
}

extension PredictMatchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellCount = eventsList?.questionList?.count ?? 0
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PredictMatchTableViewCell") as! PredictMatchTableViewCell
       // print("quest is   \(eventsList?.questionList?.first?.question)")
        let questions = eventsList?.questionList?[indexPath.row].question
        print("quest is \(questions)")
        cell.populateView(index: indexPath.row, info: eventsList)
        return cell
    }
    
    
}
