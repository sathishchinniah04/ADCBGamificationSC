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
        //self.delegate = self
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
//extension CustomNavViewController: UINavigationControllerDelegate, UINavigationBarDelegate {
//    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        UIView.animate(withDuration: 0.3) {
//            self.nav.alpha = 0.1
//        } completion: { (done) in
//            print("will show")
//        }
//    }
//
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        print("Did show")
//        UIView.animate(withDuration: 0.3) {
//            self.nav.alpha = 1.0
//        } completion: { (done) in
//            print("did show")
//        }
//    }
//
//
//    func navigationBar(_ navigationBar: UINavigationBar, didPush item: UINavigationItem) {
//        print("didPush")
//    }
//
//    func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) {
//        print("didPop")
//    }
//}
