//
//  CustomNavViewController.swift
//  ADCBGamification
//
//  Created by SKY on 05/07/21.
//

import UIKit

class CustomNavViewController: UINavigationController {
    let nav = CustomNavView()
    var yellow = UIColor(red: 255.0/256.0, green: 224.0/256.0, blue: 0.0/256.0, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
        topView.backgroundColor = yellow
        self.view.addSubview(topView)
        //self.delegate = self
        nav.backgroundColor = yellow
        nav.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 45)
        nav.populateView(sController: self,complition: navHandler(action:))
        self.view.addSubview(nav)
    }
    
    func changeTitle(title: String?) {
        nav.titleLabel.text = title ?? "simply"
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
/*
extension CustomNavViewController: UINavigationControllerDelegate, UIViewControllerTransitioningDelegate{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print("will show")
        UIView.animate(withDuration: 0.3) {
            //self.nav.alpha = 0.1
        } completion: { (done) in
            print("will show")
        }
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        print("Did show")
        UIView.animate(withDuration: 0.3) {
            //self.nav.alpha = 1.0
        } completion: { (done) in
            print("did show")
        }
    }

}
 */
