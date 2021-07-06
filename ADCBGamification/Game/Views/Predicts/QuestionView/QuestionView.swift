//
//  QuestionView.swift
//  ADCBGamification
//
//  Created by SKY on 05/07/21.
//

import UIKit

class QuestionView: UIView {
    var view: UIView?
    @IBOutlet weak var questionContainerView: UIView!
    
    @IBOutlet weak var firstAnswerButton: NeumorphicButton!
    @IBOutlet weak var secondAnswerButton: NeumorphicButton!
    @IBOutlet weak var thirdAnswerButton: NeumorphicButton!
    @IBOutlet weak var fourthAnswerButton: NeumorphicButton!
    
    
    func loaxXib() -> UIView {
        return UINib(nibName: "QuestionView", bundle: Bundle(for: Self.self)).instantiate(withOwner: self, options: nil).first as! UIView
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
        view = loaxXib()
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view!)
    }
    
    func populateView() {
        setupCornerRadius()
        buttonSetup()
    }
    
    func setupCornerRadius() {
        DispatchQueue.main.async {
            self.questionContainerView.layer.cornerRadius = self.questionContainerView.frame.height/2
        }
    }
    
    func buttonSetup() {
        firstAnswerButton.button.setTitleColor(UIColor.black, for: .normal)
        firstAnswerButton.button.setTitle("firstAnswerButton", for: .normal)
    }
}
