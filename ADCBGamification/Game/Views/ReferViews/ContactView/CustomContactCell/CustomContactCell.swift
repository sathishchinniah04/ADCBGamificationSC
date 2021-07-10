//
//  CustomContactCell.swift
//  ADCBGamification
//
//  Created by SKY on 10/07/21.
//

import UIKit

class CustomContactCell: UITableViewCell {
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var initialCharLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateView(info: FetchedContact) {
        cornerSetup()
        labelSetup(info: info)
    }
    
    func labelSetup(info: FetchedContact) {
        DispatchQueue.main.async {
            self.contactNameLabel.text = info.firstName
            self.contactLabel.text = info.telephone
            let fistC = info.firstName.first?.description ?? ""
            let secC = info.lastName.first?.description ?? ""
            self.initialCharLabel.text = fistC+secC
        }
    }
    
    func cornerSetup() {
        DispatchQueue.main.async {
    //        self.imageContainerView.layer.cornerRadius = 10.0
        }
    }
    
}
