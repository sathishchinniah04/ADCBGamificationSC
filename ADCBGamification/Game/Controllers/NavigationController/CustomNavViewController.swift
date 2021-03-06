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
        let ststusBarH = UIApplication.shared.statusBarFrame.size.height+10
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: ststusBarH))
        topView.backgroundColor = .clear//.customYellowColor()
        self.view.addSubview(topView)
        //self.delegate = self
        nav.backgroundColor = .clear//.customYellowColor()
        nav.frame = CGRect(x: 0, y: ststusBarH, width: UIScreen.main.bounds.width, height: 45)
        nav.populateView(sController: self,complition: navHandler(action:))
        self.view.addSubview(nav)
    }
    
    func hideBackButton(isHide: Bool) {
        nav.hideBackButton(isHide: isHide)
    }
    
    func hideHomeButton(isHide: Bool) {
        nav.hideHomeButton(isHide: isHide)
    }
    
    func changeTitle(title: String?) {
        nav.titleLabel.text = title ?? "simply"
    }
    
    func changeTitleAndSubTitle(title: String?, subTitle: String?) {
        nav.titleLabel.text = title ?? "simply"
        nav.subTitleLabel.text = subTitle ?? "life"
        nav.subTitleLabel.isHidden = false
    }
    
    func changeOnlyTitle(title: String?) {
        nav.titleLabel.text = title ?? "simply"
        nav.subTitleLabel.isHidden = true
    }
    
    func navHandler(action: CustomNavViewAction) {
        switch action {
        case .back:
            print("back button")
        case .home:
            print("home button")
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
