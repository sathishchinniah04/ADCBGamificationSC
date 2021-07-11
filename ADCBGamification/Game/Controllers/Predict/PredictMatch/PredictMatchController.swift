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
    @IBOutlet weak var submitButton: UIButton!
    var eventsList: EventsList?
    var selectedIndex: Int = 0
    var game: Games?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        navInitialSetup()
        tableSetup()
        self.buttonContainerView.addShadow(cornerRadius:0, shadowRadius: 2, opacity: 0.5)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }

    func initialSetup() {
        self.submitButton.alpha = 0.2
        self.submitButton.isUserInteractionEnabled = false
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
    
    @IBAction func submitAnswer() {
        guard let gId = game?.gameId else { return }
        guard let event = eventsList else { return }
        PredictViewModel.submitAnswer(gameId: gId, event: event, index: selectedIndex)
        print("submit ans")
    }
}

extension PredictMatchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let cellCount = eventsList?.questionList?.count ?? 0
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PredictMatchTableViewCell") as! PredictMatchTableViewCell

        let questions = eventsList?.questionList?[indexPath.row].question
        cell.populateView(index: indexPath.row, info: eventsList, complition: answerButtonTapped(action:))
        return cell
    }
    
    func answerButtonTapped(action: PredictMatchTableViewCellAction) {
        switch action {
        case .tapped(let qNo, let inde):
        break
        default:
            break
        }
        self.submitButton.alpha = 1.0
        self.submitButton.isUserInteractionEnabled = true
    }
    
}
