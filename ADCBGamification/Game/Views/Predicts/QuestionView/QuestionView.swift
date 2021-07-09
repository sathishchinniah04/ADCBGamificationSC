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
    @IBOutlet weak var noOfQuesLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonContainerStackView: UIStackView!
    @IBOutlet weak var firstAnswerButton: CustomNeumophicButton!
    @IBOutlet weak var secondAnswerButton: CustomNeumophicButton!
    @IBOutlet weak var thirdAnswerButton: CustomNeumophicButton!
    @IBOutlet weak var fourthAnswerButton: CustomNeumophicButton!
    
    var noOfQ: Int = 2
    var noOfButton: Int = 4
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
        hideAllButton()
        buttonSetup()
    }
    
    func buttonSetup() {
        firstAnswerButton.handler = buttonHandler
        secondAnswerButton.handler = buttonHandler
        thirdAnswerButton.handler = buttonHandler
        fourthAnswerButton.handler = buttonHandler
    }
    
    func buttonHandler() {
            print("Tapped")
        buttonContainerStackView.isUserInteractionEnabled = false
    }
    
    func hideAllButton() {
        for i in 0..<noOfButton {
        let v = self.viewWithTag(i+1)
            v?.isHidden = true
        }
    }
    func populateView(index: Int, eventsList: EventsList?) {
        guard let even = eventsList else { return }
        let noOfQues = even.questionList?.first?.predOptions?.count ?? 0
        noOfQ = Int(noOfQues)
        setupCornerRadius()
        self.visibleOption()
        labelSetup(index: index, info: even)
        buttonPopulate(index: index, info: even)
    }
    
    func labelSetup(index: Int, info: EventsList) {
            questionLabel.text = info.questionList?[index].question
            noOfQuesLabel.text = "Question \(index+1)"
    }
    
    func buttonPopulate(index: Int, info: EventsList) {
        let predOp = info.questionList?[index].predOptions
        if noOfQ == 1 {
            firstAnswerButton.button.setTitle(predOp?[0].text, for: .normal)
        }
        if noOfQ == 2 {
            firstAnswerButton.button.setTitle(predOp?[0].text, for: .normal)
            secondAnswerButton.button.setTitle(predOp?[1].text, for: .normal)
        }
        if noOfQ == 3 {
            firstAnswerButton.button.setTitle(predOp?[0].text, for: .normal)
            secondAnswerButton.button.setTitle(predOp?[1].text, for: .normal)
            thirdAnswerButton.button.setTitle(predOp?[2].text, for: .normal)
        }
        
        if noOfQ == 4 {
            firstAnswerButton.button.setTitle(predOp?[0].text, for: .normal)
            secondAnswerButton.button.setTitle(predOp?[1].text, for: .normal)
            thirdAnswerButton.button.setTitle(predOp?[2].text, for: .normal)
            fourthAnswerButton.button.setTitle(predOp?[3].text, for: .normal)
        }
    }
    
    func setupCornerRadius() {
        DispatchQueue.main.async {
            self.questionContainerView.layer.cornerRadius = self.questionContainerView.frame.height/2
        }
    }
    
    func visibleOption() {
        for i in 0..<noOfQ {
            let v = self.viewWithTag(i+1)
            v?.isHidden = false
        }
    }
    
}
