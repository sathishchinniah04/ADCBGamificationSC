//
//  CustomNeumorphicButton.swift
//  ADCBGamification
//
//  Created by SKY on 26/07/21.
//

import UIKit

class GenericNeumorphicButton: UIView {
    @IBOutlet weak var firstContainerView: UIView!
    @IBOutlet weak var secondContainerView: UIView!
    
    var view: UIView?
    func loadXib() -> UIView {
        return UINib(nibName: "GenericNeumorphicButton", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
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
    
    func initialSetup() {
        view = loadXib()
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view!)
        shadowSetup()
    }
    
    func shadowSetup() {
        secondContainerView.backgroundColor = TTUtils.uiColor(from: 0xF8F8F8)
        let bottomC = UIColor.black.withAlphaComponent(0.3)
        let topC = UIColor.white.withAlphaComponent(1.0)
        firstContainerView.addCustomShadow(cornerRadius: 10, shadowRadius: 3, opacity: 1, color: bottomC, offSet: CGSize(width: 3, height: 3))
        secondContainerView.addCustomShadow(cornerRadius: 10, shadowRadius: 4, opacity: 1, color: topC, offSet: CGSize(width: -4, height: -4))
    }
}
