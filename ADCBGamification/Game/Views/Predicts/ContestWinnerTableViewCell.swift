//
//  ContestWinnerTableViewCell.swift
//  ADCBGamification
//
//  Created by Sathish Kumar on 01/02/22.
//

import UIKit

class ContestWinnerTableViewCell: UITableViewCell {

    @IBOutlet weak var indexLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.layer.cornerRadius = 5
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
