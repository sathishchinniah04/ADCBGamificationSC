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
    
    var noOfQ: Int = 0
    var handle:((_ qNo: Int,_ indexPath : Int)->Void)?
    var noOfButton: Int = 4
    var eventsList: EventsList?
    var index: Int = 0
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
        firstAnswerButton.handler = firstButtonHandler
        secondAnswerButton.handler = secButtonHandler
        thirdAnswerButton.handler = thirdButtonHandler
        fourthAnswerButton.handler = fourthButtonHandler
    }
    
    func firstButtonHandler() {
        self.eventsList?.questionList?[index].predOptions?[0].isSelected = true
        buttonContainerStackView.isUserInteractionEnabled = false
        handle?(0, self.index)
    }
    func secButtonHandler() {
        
        self.eventsList?.questionList?[index].predOptions?[1].isSelected = true
        buttonContainerStackView.isUserInteractionEnabled = false
        handle?(1, self.index)
    }
    func thirdButtonHandler() {
        self.eventsList?.questionList?[index].predOptions?[2].isSelected = true
        buttonContainerStackView.isUserInteractionEnabled = false
        handle?(2, self.index)
    }
    func fourthButtonHandler() {
        self.eventsList?.questionList?[index].predOptions?[3].isSelected = true
        buttonContainerStackView.isUserInteractionEnabled = false
        handle?(3, self.index)
    }
    
    
    
    func hideAllButton() {
        for i in 0..<noOfButton {
        let v = self.viewWithTag(i+1)
            v?.isHidden = true
        }
    }
    func populateView(index: Int, eventsList: EventsList?, complition:((_ qNo: Int,_ indexPath : Int)->Void)?) {
        guard let even = eventsList else { return }
        self.eventsList = even
        self.index = index
        
        let noOfQues = even.questionList?[index].predOptions?.count ?? 0
        self.handle = complition
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
            let ans = predOp?[0].text ?? ""// ;let id = "\(predOp?[0].id ?? 0)"
            
            firstAnswerButton.button.setTitle(ans, for: .normal)
            secondAnswerButton.isHidden = true
            thirdAnswerButton.isHidden = true
            fourthAnswerButton.isHidden = true
            predOp?[0].isSelected = false
        }
        if noOfQ == 2 {
            
            let ans = predOp?[0].text ?? "" //; let id = "\(predOp?[0].id ?? 0)"
            let ans1 = predOp?[1].text ?? ""//; let id1 = "\(predOp?[1].id ?? 0)"
    
            firstAnswerButton.button.setTitle(ans, for: .normal)
            secondAnswerButton.button.setTitle(ans1, for: .normal)
            thirdAnswerButton.isHidden = true
            fourthAnswerButton.isHidden = true
            predOp?[0].isSelected = false
            predOp?[1].isSelected = false
        }
        if noOfQ == 3 {
            let ans = predOp?[0].text ?? "" //; let id = "\(predOp?[0].id ?? 0)"
            let ans1 = predOp?[1].text ?? ""//; let id1 = "\(predOp?[1].id ?? 0)"
            let ans2 = predOp?[2].text ?? ""// ; let id2 = "\(predOp?[2].id ?? 0)"
            
            firstAnswerButton.button.setTitle(ans, for: .normal)
            secondAnswerButton.button.setTitle(ans1, for: .normal)
            thirdAnswerButton.button.setTitle(ans2, for: .normal)
            fourthAnswerButton.isHidden = true
            predOp?[0].isSelected = false
            predOp?[1].isSelected = false
            predOp?[2].isSelected = false
            
        }
        
        if noOfQ == 4 {
            let ans = predOp?[0].text ?? "" //; let id = "\(predOp?[0].id ?? 0)"
            let ans1 = predOp?[1].text ?? ""//; let id1 = "\(predOp?[1].id ?? 0)"
            let ans2 = predOp?[2].text ?? "" //; let id2 = "\(predOp?[2].id ?? 0)"
            let ans3 = predOp?[3].text ?? ""//; let id3 = "\(predOp?[3].id ?? 0)"
            
            firstAnswerButton.button.setTitle(ans, for: .normal)
            secondAnswerButton.button.setTitle(ans1, for: .normal)
            thirdAnswerButton.button.setTitle(ans2, for: .normal)
            fourthAnswerButton.button.setTitle(ans3, for: .normal)
            predOp?[0].isSelected = false
            predOp?[1].isSelected = false
            predOp?[2].isSelected = false
            predOp?[3].isSelected = false
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
