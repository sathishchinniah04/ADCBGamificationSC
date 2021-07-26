//
//  ListGameCollectionHeaderView.swift
//  ADCBGamification
//
//  Created by SKY on 26/07/21.
//

import UIKit

class ListGameCollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateView(title: String) {
        self.titleLabel.text = title
    }
}
