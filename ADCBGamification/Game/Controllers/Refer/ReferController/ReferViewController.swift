//
//  ReferViewController.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit

class ReferViewController: UIViewController {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tblView: ReferTableView!
    var successScreen = ReferSuccessPopupHelper()
    var termsViewHelper = TermsViewHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup() {
        tblView.tableSetup(type: .newRefer,complition: tableActionHandle(action:))
    }
    
    func tableActionHandle(action: ReferTableViewAction) {
        switch action {
        case .refer:
            self.openActivityController(text: "Sending from refer")
        case .resend:
            print("resend button tapped")
//            self.successScreen.show {
//                print("Continue tapped 6")
//            }
            self.termsViewHelper.show {
                print("Continue tapped 6")
            }
        case .sendRefer:
            print("sendrefer button tapped")
        default:
            break
        }
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        print("sendrr \(sender.selectedSegmentIndex)")
        if sender.selectedSegmentIndex ==  0 {
            tblView.loadCell(type: .newRefer)
        } else {
            tblView.loadCell(type: .history)
        }
    }
}
