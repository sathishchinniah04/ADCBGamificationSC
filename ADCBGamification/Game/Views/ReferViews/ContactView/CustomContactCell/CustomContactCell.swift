//
//  CustomContactCell.swift
//  ADCBGamification
//
//  Created by SKY on 10/07/21.
//

import UIKit

class CustomContactCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var initialCharLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var isSelectedVal: Bool = false {
        didSet {
            containerView.layer.borderWidth = isSelectedVal ? 0.5 : 0.0
            containerView.layer.borderColor = isSelectedVal ? #colorLiteral(red: 0.1333333333, green: 0.1294117647, blue: 0.3960784314, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateView(info: FetchedContact) {
        cornerSetup()
        
        if info.unknowContact == true {
            initialCharLabel.isHidden = true
            userImageView.isHidden = false
            imageContainerView.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        } else {
            initialCharLabel.isHidden = false
            imageContainerView.backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        }
        
        labelSetup(info: info)
        setupImage(info: info)
    }
    
    func labelSetup(info: FetchedContact) {
        DispatchQueue.main.async {
            self.contactNameLabel.text = info.firstName+" "+info.lastName
            self.contactLabel.text = info.telephone
            let fistC = info.firstName.first?.description ?? ""
            let secC = info.lastName.first?.description ?? ""
            self.initialCharLabel.text = fistC+secC
        }
    }
    
    func setupImage(info: FetchedContact) {
        DispatchQueue.main.async {
            if let imgD = info.image {
                self.userImageView.image = UIImage(data: imgD)
                self.userImageView.isHidden = false
            } else {
                if (info.unknowContact == true) {
                    self.userImageView.isHidden = false
                } else {
                    self.userImageView.isHidden = true
                }
            }
        }
    }
    
    
    func cornerSetup() {
        DispatchQueue.main.async {
            
        }
    }
    
}
