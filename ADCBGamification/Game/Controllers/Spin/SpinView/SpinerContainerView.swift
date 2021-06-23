//
//  SpinerContainerView.swift
//  Gamification
//
//  Created by SKY on 20/06/21.
//

import UIKit

class SpinerContainerView: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var wheelContainerView: UIView!
    @IBOutlet weak var spinCenterView: UIView!
    @IBOutlet weak var spinNowButton: UIButton!
    
    var fortuneWheel: TTFortuneWheel?
    var slices: [CarnivalWheelSlice] = []
    
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
            self.spinCenterView.backgroundColor = UIColor.yellow
            self.spinCenterView.layer.cornerRadius = self.spinCenterView.frame.width/2
            self.spinCenterView.layer.borderWidth = 3
            self.spinCenterView.layer.borderColor = UIColor.white.cgColor
            self.containerView.layer.cornerRadius  = self.containerView.frame.width/2
            self.containerView.layer.borderColor = UIColor.white.cgColor
            self.containerView.layer.borderWidth = 3.0
        }
    }
    
    func populateView() {
        spinSetup()
        addCenterViewRadius()
        fortuneWheel?.clipsToBounds = false
    }
    
    func spinSetup() {
        
        slices.append(CarnivalWheelSlice.init(title: "100 \n Points"))
        slices.append(CarnivalWheelSlice.init(title: "101 \n Points"))
        slices.append(CarnivalWheelSlice.init(title: "102 \n Points"))
        slices.append(CarnivalWheelSlice.init(title: "103 \n Points"))
        slices.append(CarnivalWheelSlice.init(title: "104 \n Points"))
        slices.append(CarnivalWheelSlice.init(title: "105 \n Points"))
        slices.append(CarnivalWheelSlice.init(title: "106 \n Points"))
        slices.append(CarnivalWheelSlice.init(title: "107 \n Points"))
        
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

    private func startRotate(index: Int = 0, complition:(()->Void?)? = nil) {
        DispatchQueue.main.async {
            self.fortuneWheel?.startAnimating(fininshIndex: index,offset: CGFloat(-1*self.getOffset(slices: self.slices.count)), { (done) in
                print("done")
                complition?()
            })
        }
    }
    
    @IBAction func spinNowButtonAction() {
        startRotate(index: 3) { () -> Void? in
            print("spinNowButtonAction ")
        }
    }
}
