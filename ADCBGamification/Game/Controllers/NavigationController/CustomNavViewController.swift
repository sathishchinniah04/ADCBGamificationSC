//
//  CustomNavViewController.swift
//  ADCBGamification
//
//  Created by SKY on 05/07/21.
//

import UIKit

class CustomNavViewController: UINavigationController {
    let nav = CustomNavView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nav.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 45)
        nav.populateView(sController: self,complition: navHandler(action:))
        self.view.addSubview(nav)
    }
    
    func changeTitle(title: String) {
        nav.titleLabel.text = title
    }
    func navHandler(action: CustomNavViewAction) {
        switch action {
        case .back:
            print("back button")
        case .home:
            print("home button")
        default:
            break
        }
    }
}
