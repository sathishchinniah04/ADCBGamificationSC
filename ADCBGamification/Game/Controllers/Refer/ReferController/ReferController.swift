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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDottedLine()
    }
    
    func addDottedLine() {
        DispatchQueue.main.async {
            self.referCodeView.addDottedLine()
            self.shareButton.populateView(complition: self.referButtonHandle(action:))
            self.shareButton.buttonState(isPressed: true)
        }
    }
    
    func referButtonHandle(action: NeumorphicButtonAction) {
        print("Tapped refer")
        
    }
}
