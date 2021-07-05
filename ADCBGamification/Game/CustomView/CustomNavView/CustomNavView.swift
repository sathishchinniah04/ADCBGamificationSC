//
//  CustomNavView.swift
//  ADCBGamification
//
//  Created by SKY on 05/07/21.
//

import UIKit

@IBDesignable class CustomNavView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    var isDismiss: Bool = false
    var view: UIView?
    var sController: UIViewController?
    
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
    
    @IBAction func backButtonAction() {
        print("Back button tapped controllers count is  = \(sController?.navigationController?.viewControllers.count)")
        if  sController?.navigationController?.viewControllers.count ?? 0 <= 1 {
            sController?.dismiss(animated: true, completion: nil)
        } else {
            sController?.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func homeButtonAction() {
        print("Home button tapped")
        sController?.dismiss(animated: true, completion: nil)
    }
    
    func populateView(sController: UIViewController) {
        self.sController = sController
    }
}
