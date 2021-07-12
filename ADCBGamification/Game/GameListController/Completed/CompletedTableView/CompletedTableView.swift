//
//  CompletedTableView.swift
//  Gamification
//
//  Created by SKY on 21/01/21.
//  Copyright © 2021 SIXDEE. All rights reserved.
//

import UIKit

//
//  SpendTableView.swift
//  Gamification
//
//  Created by SKY on 20/01/21.
//  Copyright © 2021 SIXDEE. All rights reserved.
//

import UIKit

class CompletedTableView: UITableView {
    var items = ["","","","",""]
    var imageName = [Int.random(in: 1...3),Int.random(in: 1...3),Int.random(in: 1...3),Int.random(in: 1...3),Int.random(in: 1...3)]
    func tableViewSetup() {
        self.delegate = self
        self.dataSource = self
        registorCell()
    }

    func registorCell() {
        self.register(UINib(nibName: "CompletedTableViewCell", bundle: Bundle(for: CompletedTableViewCell.self)), forCellReuseIdentifier: "CompletedTableViewCell")
    }
}
extension CompletedTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedTableViewCell") as! CompletedTableViewCell
        //cell.populateCell(imageIndex: imageName[indexPath.row], indexPath: indexPath)
        return cell
    }
    
    
}


