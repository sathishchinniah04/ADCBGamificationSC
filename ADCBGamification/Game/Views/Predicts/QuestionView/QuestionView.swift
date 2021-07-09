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
    func populateView(index: Int, tournament: Tournaments?) {
        guard let tourn = tournament else { return }
        let noOfQues = tourn.eventList?.first?.numberOfquestions ?? "0"
        noOfQ = Int(noOfQues) ?? 0
        setupCornerRadius()
        self.visibleOption()
        labelSetup(index: index, info: tourn)
        buttonPopulate(index: index, info: tourn)
    }
    
    func labelSetup(index: Int, info: Tournaments) {
        guard let list = info.eventList?.first?.questionList?[index] else { return }
        noOfQuesLabel.text = "Question \(list.questionId ?? "0")"
        questionLabel.text = list.question
    }
    
    func buttonPopulate(index: Int, info: Tournaments) {
        let predOp = info.eventList?.first?.questionList?[index].predOptions
        if noOfQ == 1 {
            firstAnswerButton.button.setTitle(predOp?[0].text, for: .normal)
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
