//
//  ContestWinnerCollectionCell.swift
//  ADCBGamification
//
//  Created by Sathish Kumar on 31/01/22.
//

import UIKit

class ContestWinnerCollectionCell: UICollectionViewCell {

    @IBOutlet weak var winnerCount: UILabel!
    @IBOutlet weak var contestGameTitle: UILabel!
    @IBOutlet weak var contestGamevsCode: UILabel!
    @IBOutlet weak var contestDate: UILabel!
    @IBOutlet weak var contestAnnouncedDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFontFamily()
    }
    
    func setupFontFamily() {
        

        winnerCount.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 20.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        contestGameTitle.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 20.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        contestGamevsCode.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  10.0 : 10.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold")
        
        contestDate.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  9.0 : 9.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        contestAnnouncedDate.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  9.0 : 9.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")

    }
    
    
    func populateView(list: PredictContestWinnerModel?, index: Int) {
        
        let winnerString = "Winners".localized()
        winnerCount.text = "\(list?.totalWinners ?? 0)\n\(winnerString)"
        contestGameTitle.text = list?.title ?? ""
        if let opponentA = list?.opponentAsynonym, let opponentB = list?.opponentBsynonym {
            
            let opponentString = [NSAttributedString.Key.font : UIFont(name: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold", size: 11), NSAttributedString.Key.foregroundColor : UIColor(red: 34/255.0, green: 33/255.0, blue: 101/255.0, alpha: 1.0) ]
            let vsString = [NSAttributedString.Key.font : UIFont(name: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular", size: 10), NSAttributedString.Key.foregroundColor : UIColor(red: 34/255.0, green: 33/255.0, blue: 101/255.0, alpha: 1.0) ]
            
            let text = NSMutableAttributedString()
            text.append(NSAttributedString(string: "\(opponentA.capitalized) ", attributes: opponentString as [NSAttributedString.Key : Any]));
            text.append(NSAttributedString(string: "vs".localized(), attributes: vsString as [NSAttributedString.Key : Any]));
            text.append(NSAttributedString(string: " \(opponentB.capitalized)", attributes: opponentString as [NSAttributedString.Key : Any]))
            contestGamevsCode.attributedText = text
         
        }
        
        if let contestStartDate = list?.eventStartDate, let contestEndDate = list?.eventEndDate {
            
            let dateString = [NSAttributedString.Key.font : UIFont(name: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular", size: 11), NSAttributedString.Key.foregroundColor : UIColor(red: 34/255.0, green: 33/255.0, blue: 101/255.0, alpha: 1.0) ]
            let rawString = [NSAttributedString.Key.font : UIFont(name: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular", size: 11), NSAttributedString.Key.foregroundColor : UIColor(red: 84/255.0, green: 84/255.0, blue: 86/255.0, alpha: 1.0) ]
            
            let startDate = Utility.convertDateWithFormat(inputDate: contestStartDate, currFormat: "dd-MM-yyyy", expFormat: "MMM d")
            let endDate = Utility.convertDateWithFormat(inputDate: contestEndDate, currFormat: "dd-MM-yyyy", expFormat: " MMM d, yyyy")

     
            let text = NSMutableAttributedString()
            text.append(NSAttributedString(string: "Contest on".localized(), attributes: rawString as [NSAttributedString.Key : Any]));
            text.append(NSAttributedString(string: " ", attributes: rawString as [NSAttributedString.Key : Any]));
            text.append(NSAttributedString(string: "\(startDate) ", attributes: dateString as [NSAttributedString.Key : Any]));
            text.append(NSAttributedString(string: "-", attributes: dateString as [NSAttributedString.Key : Any]));
            text.append(NSAttributedString(string: " \(endDate)", attributes: dateString as [NSAttributedString.Key : Any]));
            
            contestDate.attributedText = text
            
        }
        
        if let announceDate = list?.announcementDate {
            
            let dateString = [NSAttributedString.Key.font : UIFont(name: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular", size: 11), NSAttributedString.Key.foregroundColor : UIColor(red: 34/255.0, green: 33/255.0, blue: 101/255.0, alpha: 1.0) ]
            let rawString = [NSAttributedString.Key.font : UIFont(name: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular", size: 11), NSAttributedString.Key.foregroundColor : UIColor(red: 84/255.0, green: 84/255.0, blue: 86/255.0, alpha: 1.0) ]
            
            let currDate = Utility.convertDateWithFormat(inputDate: announceDate, currFormat: "dd-MM-yyyy", expFormat: " MMM d, yyyy")

     
            let text = NSMutableAttributedString()
            text.append(NSAttributedString(string: "Announced on".localized(), attributes: rawString as [NSAttributedString.Key : Any]));
            text.append(NSAttributedString(string: " ", attributes: rawString as [NSAttributedString.Key : Any]));
            text.append(NSAttributedString(string: "\(currDate) ", attributes: dateString as [NSAttributedString.Key : Any]));
            
            contestAnnouncedDate.attributedText = text
            
        }
    }
    

}
