//
//  CustomNavView.swift
//  ADCBGamification
//
//  Created by SKY on 05/07/21.
//

import UIKit
enum CustomNavViewAction {
    case back
    case home
}
@IBDesignable class CustomNavView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    var isDismiss: Bool = false
    var view: UIView?
    var sController: UIViewController?
    var handler:((CustomNavViewAction)->Void)?
    func loadXib() -> UIView {
        return UINib(nibName: "CustomNavView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialStup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialStup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initialStup()
    }
    
    func initialStup() {
        view = loadXib()
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view!)
        
    }
    
    func hideBackButton(isHide: Bool) {
        backButton.isHidden = isHide
    }
    
    func hideHomeButton(isHide: Bool) {
        homeButton.isHidden = isHide
    }
    
    @IBAction func backButtonAction() {
        handler?(.back)
        //CallBack.shared.handle?(.back)
        let cont = sController?.getTopController()
        if  cont?.navigationController?.viewControllers.count ?? 0 <= 1 {
            cont?.dismiss(animated: true, completion: nil)
            CallBack.shared.handle?(.close)
        } else {
            cont?.navigationController?.popViewController(animated: true)
            CallBack.shared.handle?(.back)
        }
    }
    
    @IBAction func homeButtonAction() {
        print("Home button tapped")
        handler?(.home)
        CallBack.shared.handle?(.close)
        sController?.dismiss(animated: true, completion: nil)
    }
    
    func populateView(sController: UIViewController, complition:((CustomNavViewAction)->Void)? = nil) {
        self.handler = complition
        self.sController = sController
        
        print("cont?.navigationController?.viewControllers.count \(sController.navigationController?.viewControllers.count)")
    }
}
