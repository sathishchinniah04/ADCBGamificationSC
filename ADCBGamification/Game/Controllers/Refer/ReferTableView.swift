//
//  ReferTableView.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit
enum ReferTableCellType {
    case newRefer
    case history
}
enum ReferTableViewAction {
    case refer
    case sendRefer
    case resend
}
class ReferTableView: UITableView {
    var cellType: ReferTableCellType = .newRefer
    var handle:((ReferTableViewAction)->Void)?
    
    func tableSetup(type: ReferTableCellType, complition: ((ReferTableViewAction)->Void)?) {
        self.cellType = type
        self.delegate = self
        self.dataSource = self
        registorCell()
        self.handle = complition
    }
    
    func loadCell(type: ReferTableCellType) {
        self.cellType = type
        self.reloadData()
    }
    
    func registorCell() {
        self.register(UINib(nibName: "HistoryTableViewCell", bundle: Bundle(for: ReferTableView.self)), forCellReuseIdentifier: "HistoryTableViewCell")
        self.register(UINib(nibName: "NewReferTableViewCell", bundle: Bundle(for: ReferTableView.self)), forCellReuseIdentifier: "NewReferTableViewCell")
    }
}

extension ReferTableView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellType == .newRefer {
            return 1
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellType == .newRefer {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewReferTableViewCell") as! NewReferTableViewCell
            cell.populateView(complition: referCellActionHandle(action:))
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell") as! HistoryTableViewCell
           // cell.contentView.backgroundColor = backgroundColor1
            cell.populateView(index: indexPath.row, complition: historyCellHandler(action:))
            return cell
        }
    }
    
    func referCellActionHandle(action: NewReferTableViewCellAction) {
        print("action \(action)")
        switch action {
        case .refer:
            handle?(.refer)
        case .sendButton:
            handle?(.sendRefer)
        default:
            break
        }
    }
    
    func historyCellHandler(action: HistoryTableViewCellAction) {
        switch action {
        case .update:
            self.beginUpdates()
            self.endUpdates()
        case .resend:
            handle?(.resend)
            self.beginUpdates()
            self.endUpdates()
        default:
            break
        }
    }
}
