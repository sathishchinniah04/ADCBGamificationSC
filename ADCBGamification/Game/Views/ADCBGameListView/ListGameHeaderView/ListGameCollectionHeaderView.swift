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
        titleLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
    }
    
    func populateView(title: String) {
        self.titleLabel.text = title
    }
}
