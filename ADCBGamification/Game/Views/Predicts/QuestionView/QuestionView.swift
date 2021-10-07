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
    
    
    @IBOutlet weak var firstAnswerButton: UIButton!
    @IBOutlet weak var secondAnswerButton: UIButton!
    @IBOutlet weak var thirdAnswerButton: UIButton!
    @IBOutlet weak var fourthAnswerButton: UIButton!
    
    
//    @IBOutlet weak var firstAnswerButton: CustomNeumophicButton!
//    @IBOutlet weak var secondAnswerButton: CustomNeumophicButton!
//    @IBOutlet weak var thirdAnswerButton: CustomNeumophicButton!
//    @IBOutlet weak var fourthAnswerButton: CustomNeumophicButton!
    @IBOutlet var answersImagesArray: [UIButton]!
    
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
        
        noOfQuesLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        questionLabel.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 20.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
        
        firstAnswerButton.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
        
        secondAnswerButton.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
        
        thirdAnswerButton.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
        
        fourthAnswerButton.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
        
    }
    
    @IBAction func firstBtnAction(_ sender: Any) {
        firstButtonHandler()
    }
    
    @IBAction func secondBtnAction(_ sender: Any) {
        secButtonHandler()
    }
    
    
    @IBAction func thirdBtnAction(_ sender: Any) {
        thirdButtonHandler()
    }
    
    @IBAction func fourthBtnAction(_ sender: Any) {
        fourthButtonHandler()
    }
        func buttonSetup() {
//        firstAnswerButton.handler = firstButtonHandler
//        secondAnswerButton.handler = secButtonHandler
//        thirdAnswerButton.handler = thirdButtonHandler
//        fourthAnswerButton.handler = fourthButtonHandler
            
            
            for button in self.answersImagesArray {
                button.backgroundColor = .white
                button.addShadowButton(cornerRadius: 10, shadowRadius: 2, opacity: 0.2, color: .lightGray)
            }

    }
    
    func firstButtonHandler() {
        
        for (_, list) in self.eventsList?.questionList?[index].predOptions?.enumerated() ?? [].enumerated() {
            list.isSelected = false
        }
        
        for (index, image) in self.answersImagesArray.enumerated() {
            if index == 0 {
//                image.contentMode = .scaleAspectFit
                image.backgroundColor = .clear
                image.addShadowButton(cornerRadius: 0, shadowRadius: 0, opacity: 0, color: .clear)
                
                image.setBackgroundImage(UIImage(named: "PNWImageSelected", in: Bundle(for: QuestionView.self), compatibleWith: nil), for: .normal)
//                image.imageView?.contentMode = .scaleAspectFit
               
            } else {
//                image.contentMode = .scaleAspectFill
                //image.setBackgroundImage(UIImage(named: "PNWImage", in: Bundle(for: QuestionView.self), compatibleWith: nil), for: .normal)
//                image.imageView?.contentMode = .scaleAspectFit
//                image.customShadow(lightSha: lightL!, cornerRadius: 5, backColor: UIColor.customYellowColor(), shadowColor: UIColor.white, shadowRadius: 2,opacity: 0.3, dx: 0, dy: 0)
//                image.customShadow(lightSha: darkL!, cornerRadius: 5, backColor: UIColor.customYellowColor(), shadowColor: UIColor.black,shadowRadius: 1, opacity: 0.8,dx: -1, dy: -1)
//                image.addCustomShadow(cornerRadius: 5, shadowRadius: 2, opacity: 0.5, color: UIColor.clear, offset: CGSize(width: 2, height: 2))
                image.setBackgroundImage(UIImage(named: " ", in: Bundle(for: QuestionView.self), compatibleWith: nil), for: .normal)

                image.backgroundColor = .white
                image.addShadowButton(cornerRadius: 10, shadowRadius: 2, opacity: 0.2, color: .lightGray)
            }
        }
        self.eventsList?.questionList?[index].predOptions?[0].isSelected = true
        buttonContainerStackView.isUserInteractionEnabled = true
        handle?(0, self.index)
    }
    func secButtonHandler() {
        for (_, list) in self.eventsList?.questionList?[index].predOptions?.enumerated() ?? [].enumerated() {
            list.isSelected = false
        }
        for (index, image) in self.answersImagesArray.enumerated() {
            if index == 1 {
//                image.contentMode = .scaleAspectFit
//                image.imageView?.contentMode = .scaleAspectFit
                image.backgroundColor = .clear
                image.addShadowButton(cornerRadius: 0, shadowRadius: 0, opacity: 0, color: .clear)
                image.setBackgroundImage(UIImage(named: "PNWImageSelected", in: Bundle(for: QuestionView.self), compatibleWith: nil), for: .normal)
//                image.image = UIImage(named: "PNWEnabled", in: Bundle(for: QuestionView.self), compatibleWith: nil)
            } else {
//                image.contentMode = .scaleAspectFill
//                image.image = UIImage(named: "newpnwdisabled", in: Bundle(for: QuestionView.self), compatibleWith: nil)
//                image.imageView?.contentMode = .scaleAspectFit
                image.setBackgroundImage(UIImage(named: " ", in: Bundle(for: QuestionView.self), compatibleWith: nil), for: .normal)
                image.backgroundColor = .white
                image.addShadowButton(cornerRadius: 10, shadowRadius: 2, opacity: 0.2, color: .lightGray)
                
            }
        }
        self.eventsList?.questionList?[index].predOptions?[1].isSelected = true
        
        buttonContainerStackView.isUserInteractionEnabled = true
        handle?(1, self.index)
    }
    
    
 
    func thirdButtonHandler() {
        for (_, list) in self.eventsList?.questionList?[index].predOptions?.enumerated() ?? [].enumerated() {
            list.isSelected = false
        }
        for (index, image) in self.answersImagesArray.enumerated() {
            if index == 2 {
               // image.contentMode = .scaleAspectFit
                image.backgroundColor = .clear
                image.addShadowButton(cornerRadius: 0, shadowRadius: 0, opacity: 0, color: .clear)
                image.setBackgroundImage(UIImage(named: "PNWImageSelected", in: Bundle(for: QuestionView.self), compatibleWith: nil), for: .normal)
//                image.image = UIImage(named: "PNWEnabled", in: Bundle(for: QuestionView.self), compatibleWith: nil)
            } else {
              //  image.contentMode = .scaleAspectFill
               // image.setBackgroundImage(UIImage(named: "PNWImage", in: Bundle(for: QuestionView.self), compatibleWith: nil), for: .normal)
               // image.image = UIImage(named: "newpnwdisabled", in: Bundle(for: QuestionView.self), compatibleWith: nil)
                image.setBackgroundImage(UIImage(named: " ", in: Bundle(for: QuestionView.self), compatibleWith: nil), for: .normal)

                image.backgroundColor = .white
                image.addShadowButton(cornerRadius: 10, shadowRadius: 2, opacity: 0.2, color: .lightGray)
            }
        }
        self.eventsList?.questionList?[index].predOptions?[2].isSelected = true
        buttonContainerStackView.isUserInteractionEnabled = true
        handle?(2, self.index)
    }
    func fourthButtonHandler() {
        for (_, list) in self.eventsList?.questionList?[index].predOptions?.enumerated() ?? [].enumerated() {
            list.isSelected = false
        }
        for (index, image) in self.answersImagesArray.enumerated() {
            if index == 3 {
               // image.contentMode = .scaleAspectFit
                image.backgroundColor = .clear
                image.addShadowButton(cornerRadius: 0, shadowRadius: 0, opacity: 0, color: .clear)
                image.setBackgroundImage(UIImage(named: "PNWImageSelected", in: Bundle(for: QuestionView.self), compatibleWith: nil), for: .normal)
//                image.image = UIImage(named: "PNWEnabled", in: Bundle(for: QuestionView.self), compatibleWith: nil)
            } else {
                //image.contentMode = .scaleAspectFill
               // image.setBackgroundImage(UIImage(named: "PNWImage", in: Bundle(for: QuestionView.self), compatibleWith: nil), for: .normal)
//                image.image = UIImage(named: "newpnwdisabled", in: Bundle(for: QuestionView.self), compatibleWith: nil)
                
                image.setBackgroundImage(UIImage(named: " ", in: Bundle(for: QuestionView.self), compatibleWith: nil), for: .normal)
                image.backgroundColor = .white
                image.addShadowButton(cornerRadius: 10, shadowRadius: 2, opacity: 0.2, color: .lightGray)
            }
        }
        self.eventsList?.questionList?[index].predOptions?[3].isSelected = true
        buttonContainerStackView.isUserInteractionEnabled = true
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
        
        let cnt = "\(index + 1)"

        if (StoreManager.shared.language.lowercased() == "ar".lowercased()) {
            noOfQuesLabel.text = "Question".localized() + cnt.convertedDigitsToLocale(Locale(identifier: "AR"))
        } else {
            noOfQuesLabel.text = "Question".localized() + cnt
        }
       

        
    }
    
    
    
    
    func buttonPopulate(index: Int, info: EventsList) {
        let predOp = info.questionList?[index].predOptions
        if noOfQ == 1 {
            let ans = predOp?[0].text ?? ""// ;let id = "\(predOp?[0].id ?? 0)"
            
            firstAnswerButton.setTitle(ans, for: .normal)
            secondAnswerButton.isHidden = true
            thirdAnswerButton.isHidden = true
            fourthAnswerButton.isHidden = true
            predOp?[0].isSelected = false
        }
        if noOfQ == 2 {
            
            let ans = predOp?[0].text ?? "" //; let id = "\(predOp?[0].id ?? 0)"
            let ans1 = predOp?[1].text ?? ""//; let id1 = "\(predOp?[1].id ?? 0)"
    
            firstAnswerButton.setTitle(ans, for: .normal)
            secondAnswerButton.setTitle(ans1, for: .normal)
            thirdAnswerButton.isHidden = true
            fourthAnswerButton.isHidden = true
            predOp?[0].isSelected = false
            predOp?[1].isSelected = false
        }
        if noOfQ == 3 {
            let ans = predOp?[0].text ?? "" //; let id = "\(predOp?[0].id ?? 0)"
            let ans1 = predOp?[1].text ?? ""//; let id1 = "\(predOp?[1].id ?? 0)"
            let ans2 = predOp?[2].text ?? ""// ; let id2 = "\(predOp?[2].id ?? 0)"
            
            firstAnswerButton.setTitle(ans, for: .normal)
            secondAnswerButton.setTitle(ans1, for: .normal)
            thirdAnswerButton.setTitle(ans2, for: .normal)
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
            
            firstAnswerButton.setTitle(ans, for: .normal)
            secondAnswerButton.setTitle(ans1, for: .normal)
            thirdAnswerButton.setTitle(ans2, for: .normal)
            fourthAnswerButton.setTitle(ans3, for: .normal)
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


extension UIButton {
    func addShadowButton(cornerRadius:CGFloat = 5.0,shadowRadius:CGFloat = 4, opacity: CGFloat = 0.1, color:UIColor = UIColor.black) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = Float(opacity)
        layer.shadowRadius = shadowRadius
    }
}

extension String {
    private static let formatter = NumberFormatter()

    func clippingCharacters(in characterSet: CharacterSet) -> String {
        components(separatedBy: characterSet).joined()
    }

    func convertedDigitsToLocale(_ locale: Locale = .current) -> String {
        let digits = Set(clippingCharacters(in: CharacterSet.decimalDigits.inverted))
        guard !digits.isEmpty else { return self }

        Self.formatter.locale = locale

        let maps: [(original: String, converted: String)] = digits.map {
            let original = String($0)
            let digit = Self.formatter.number(from: original)!
            let localized = Self.formatter.string(from: digit)!
            return (original, localized)
        }

        return maps.reduce(self) { converted, map in
            converted.replacingOccurrences(of: map.original, with: map.converted)
        }
    }
    
    func changeToArabic()-> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "ar_SA")
        let arabicNumber = numberFormatter.number(from: self)
        return "\(arabicNumber!)"
    }
}
