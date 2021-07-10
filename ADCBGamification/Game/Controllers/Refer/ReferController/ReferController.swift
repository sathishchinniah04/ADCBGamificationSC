//
//  ReferController.swift
//  ADCBGamification
//
//  Created by SKY on 09/07/21.
//

import UIKit

class ReferController: UIViewController {
    
    @IBOutlet weak var referCodeView: UIView!
    @IBOutlet weak var shareButton: NeumorphicButton!
    @IBOutlet weak var chooseContactButton: ReferContactButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDottedLine()
    }
    
    func addDottedLine() {
        DispatchQueue.main.async {
            self.referCodeView.addDottedLine()
            self.shareButton.populateView(complition: self.referButtonHandle(action:))
            self.shareButton.buttonState(isPressed: true)
            self.shareButton.button.setImage(UIImage(named: "Refershare"), for: .normal)
            self.chooseContactButton.populateView(complition: self.chooseContactButtonTapped(action:))
        }
    }
    
    func referButtonHandle(action: NeumorphicButtonAction) {
        print("Tapped refer")
        
    }
    
    func chooseContactButtonTapped(action: ReferContactButtonAction) {
        switch action {
        case .chooseContact:
            self.openContactList()
        default:
            break
        }
    }
    
    func openContactList() {
        let cont = UIStoryboard(name: "Refer", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "ContactListController")
        self.present(cont, animated: true, completion: nil)
    }
    
}
