//
//  ExpireView.swift
//  Gamification
//
//  Created by SKY on 19/06/21.
//

import UIKit

class ExpireView: UIView {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var expireLabel: UILabel!
    var termsView = TermsViewHelper()
    var handler: (()->Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initialSetup()
    }
    
    func loadNib() -> UIView {
        return UINib(nibName: "ExpireView", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    private func initialSetup() {
        let view = loadNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        addSubview(view)
        button.addCustomShadow(cornerRadius: 10, shadowRadius: 4, opacity: 0.3, color: UIColor.blue, offSet: CGSize(width: 4, height: 4))
    }
    
    func populateView(complition: (()->Void)?) {
        self.handler = complition
        setupLabel()
    }
    
    func setupButtonName(name: String) {
        button.setTitle(name, for: .normal)
    }
    
    func setupLabel() {
        gameNameLabel.text = "Refer & Win"
        expireLabel.text = "Expire is 02h 33mins"
    }
    
    @IBAction func playButtonAction() {
        termsView.show {
            print("fsdfsdfdss")
            self.handler?()
        }
    }

}
