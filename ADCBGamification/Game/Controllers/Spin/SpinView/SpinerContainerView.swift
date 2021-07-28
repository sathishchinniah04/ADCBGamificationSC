//
//  SpinerContainerView.swift
//  Gamification
//
//  Created by SKY on 20/06/21.
//

import UIKit
enum SpinerContainerViewAction {
        case spinTapped
    case view(UIView, _ containerView: UIView)
}

class SpinerContainerView: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var wheelContainerView: UIView!
    @IBOutlet weak var spinCenterView: UIView!
    @IBOutlet weak var spinNowButton: UIButton!
    var offer: [Offers]?
    var fortuneWheel: TTFortuneWheel?
    var slices: [CarnivalWheelSlice] = []
    var handle:((SpinerContainerViewAction)->Void)?
    static func loadXib() ->SpinerContainerView {
        return UINib(nibName: "SpinerContainerView", bundle:Bundle(for: SpinerContainerView.self)).instantiate(withOwner: self, options: nil).first as! SpinerContainerView
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
    }
    
    func addCenterViewRadius() {
        DispatchQueue.main.async {
            self.spinNowButton.addCustomShadow(cornerRadius: 10, opacity: 0.4, color: UIColor.darkBlueColor(), offSet: CGSize(width: 4, height: 4))
            self.spinCenterView.backgroundColor = UIColor.customYellowColor()
            self.spinCenterView.layer.cornerRadius = self.spinCenterView.frame.width/2
            self.spinCenterView.layer.borderWidth = 3
            self.spinCenterView.layer.borderColor = UIColor.white.cgColor
            self.containerView.layer.cornerRadius  = self.containerView.frame.width/2
            self.containerView.layer.borderColor = UIColor.white.cgColor
            self.containerView.layer.borderWidth = 3.0
        }
    }
    
    func populateView() {
        addCenterViewRadius()
        fortuneWheel?.clipsToBounds = false
    }
    
    func stopAnimationAtIndex(achivementId: String, complition:((Bool)->Void)?) {
        print("achivementId \(achivementId)")
        DispatchQueue.main.async {
            self.wheelContainerView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
        if achivementId == "-1" {
            self.startRotate(index: 1) { () -> Void? in
                complition?(false)
            }
            return
        }
        
        if let ind = self.offer?.firstIndex(where: {$0.rewardId == achivementId}) {
            
            print("index  found is \(ind) self.offer count is == \(self.offer?.count)")
            DispatchQueue.main.async {
                self.startRotate(index: ind*2) { () -> Void? in
                    complition?(true)
                }//(index: ind*2, complition: complition)
            }
        } else {
            DispatchQueue.main.async {
                self.startRotate(index: 1) { () -> Void? in
                    complition?(false)
                }//(index: 1, complition: complition)
            }
        }        
    }
    
    func populateSpinner(offer: [Offers],complition:((SpinerContainerViewAction)->Void)?) {
        self.offer = offer
        spinSetup(offer: offer)
        self.handle = complition
        //self.mainContainerView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        complition?(.view(self.mainContainerView, self.wheelContainerView))
    }
    
    func spinSetup(offer: [Offers]) {
        for item in offer {
            print("item.defaultReward \(item.defaultReward)")
            
            slices.append(CarnivalWheelSlice.init(title: "\(item.rewardTitle ?? "")"))
            slices.append(CarnivalWheelSlice.init(title: ""))
            //self.offer?.append(Offers())
            if item.defaultReward ?? false {
                slices.removeLast()
                slices.removeLast()
            }
        }
        fortuneWheel = TTFortuneWheel(frame: wheelContainerView.bounds, slices:slices)
        self.fortuneWheel?.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi/2))
        fortuneWheel?.frameStroke.width = 0
        fortuneWheel?.layer.borderWidth = 1.0
        fortuneWheel?.layer.cornerRadius = (fortuneWheel?.frame.height)!/2
        fortuneWheel?.equalSlices = true
        wheelContainerView.addSubview(fortuneWheel!)

        fortuneWheel?.equalSlices = true
        fortuneWheel?.initialDrawingOffset = CGFloat(getOffset(slices: slices.count))
        
        fortuneWheel?.slices.enumerated().forEach { (pair) in
            
            let st = pair.element as! CarnivalWheelSlice
            
            st.style = .babyBlue
        }
        fortuneWheel?.slices.enumerated().forEach { (pair) in
            let slice = pair.element as? CarnivalWheelSlice
            let offset = pair.offset
            switch offset % 4 {
            
            case 0: slice?.style = .deepBlue
            case 1: slice?.style = .sandYellow
            case 2: slice?.style = .deepBlue
            case 3: slice?.style = .sandYellow
            default: slice?.style = .deepBlue
            }
        }
        rotateView()
    }
    
    func rotateView() {
        DispatchQueue.main.async {
            self.containerView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
    }
    
    func getOffset(slices: Int) -> Int{
        if slices == 8 {
            return -23
        } else if slices == 7 {
            return -26
        } else if slices == 6 {
            return -30
        } else if slices == 5 {
            return -36
        } else if slices == 4 {
            return -45
        } else if slices == 3 {
            return -60
        } else if slices == 2 {
            return -90
        } else {
            return -18
        }
    }

    func enableSpinButton() {
        self.spinNowButton.alpha = 1.0
        self.spinNowButton.isUserInteractionEnabled = true
    }
    
    private func startRotate(index: Int = 0, complition:(()->Void?)? = nil) {
        print("Index is \(index)")
        DispatchQueue.main.async {
            self.fortuneWheel?.startAnimating(fininshIndex: index,offset: CGFloat(-1*self.getOffset(slices: self.slices.count)), { (done) in
                print("done")
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    complition?()
                }
            })
        }
    }
    
    @IBAction func spinNowButtonAction() {
        self.fortuneWheel?.startAnimating()
        self.handle?(.spinTapped)
        self.spinNowButton.alpha = 0.0
        self.spinNowButton.isUserInteractionEnabled = false
//        startRotate(index: 3) { () -> Void? in
//            print("spinNowButtonAction ")
//        }
    }
}
