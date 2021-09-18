//
//  PredictMatchController.swift
//  ADCBGamification
//
//  Created by SKY on 02/07/21.
//

import UIKit

protocol PredictDateDelegate {
    func predictAction()
}

class PredictMatchController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var bgCloudImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var contentView: UIView! {
        didSet {
            contentView.clipsToBounds = true
            contentView.layer.cornerRadius = 20
            if #available(iOS 11.0, *) {
                contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            } else {
                // Fallback on earlier versions
            }
        }
    }
    @IBOutlet weak var contentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topSeperatorLbl: UILabel! {
        didSet {
            topSeperatorLbl.layer.cornerRadius = 3.5
        }
    }
    var delegate: PredictDateDelegate? = nil
    var selectedEvent: EventsList?
    var eventsList: EventsList?
    var selectedIndex: Int = 0
    var game: Games?
    var teamA: String = ""
    var teamB: String = ""
    var predictSuccessHelper = PredictSuccessHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        navInitialSetup()
        tableSetup()
        contentViewTopConstraint.constant = 80
        //self.buttonContainerView.addShadow(cornerRadius:0, shadowRadius: 2, opacity: 0.5)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        self.submitButton.setTitle("Confirm & Submit".localized(), for: .normal)
        self.submitButton.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
        
        let con = self.navigationController
 
        (con as? CustomNavViewController)?.changeOnlyTitle(title: "Predict & Win".localized())
        
        
        addSwipe()

    }
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gesture.direction = direction
            self.contentView.addGestureRecognizer(gesture)
        }
    }

    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        let direction = sender.direction
        switch direction {
            case .right:
                print("Gesture direction: Right")
            case .left:
                print("Gesture direction: Left")
            case .up:
                print("Gesture direction: Up")
                UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {

                    self.contentViewTopConstraint.constant = 20
                    UIView.animate(withDuration: 0.5) {
                        self.contentView.layoutIfNeeded()
                    }
                    
//                    if self.contentView.frame.origin.y > 150 {
//                        let screenSize = UIScreen.main.bounds.size
//
//                        let x = screenSize.width - self.contentView.frame.size.width
//                        let y = self.contentView.frame.origin.y - 100
//
//                        self.contentView.frame = CGRect(x: x, y: y, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height + 100)
//                    }

                })
               
            case .down:
                print("Gesture direction: Down")
               
                    self.dismiss(animated: true, completion: nil)
                
            default:
                print("Unrecognized Gesture Direction")
        }
        
    }

    func initialSetup() {
        //self.submitButton.alpha = 0.2
        self.submitButton.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        self.submitButton.setTitleColor(#colorLiteral(red: 0.6274509804, green: 0.6274509804, blue: 0.6274509804, alpha: 1), for: .normal)
        self.submitButton.isUserInteractionEnabled = false
    }
    
    func tableSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PredictMatchTableViewCell", bundle: Bundle(for: Self.self)), forCellReuseIdentifier: "PredictMatchTableViewCell")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let _ = self.navigationController
        //(con as? CustomNavViewController)?.changeTitle(title: "SHIV")
    }
    
    func navInitialSetup() {
        //customNavView.populateView(sController: self)
    }
    
    func onSuccess() {
       
            self.predictSuccessHelper.show(event: self.selectedEvent, complition: self.predictSuccessPopupHandler(action:))

    }
    
    func predictSuccessPopupHandler(action: PredictSuccessViewAction) {
        switch action {
        case .homePage:
            self.predictSuccessHelper.animateAndRemove()
            self.dismiss(animated: false) {
                self.delegate?.predictAction()
            }
//            self.dismiss(animated: true) {
//                CallBack.shared.handle?(.homeAction)
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
//                self.navigationController?.popToRootViewController(animated: true)
//            }
        case .share:
            let message = Constants.referMessage
            self.openActivityController(text: message)
        case .gamePage:
            self.predictSuccessHelper.animateAndRemove()
            self.dismiss(animated: true) {
                self.navigationController?.popViewController(animated: true)
            }
        default:
            break
        }
    }
    
    @IBAction func submitAnswer() {
        guard let gId = game?.gameId else { return }
        guard let event = eventsList else { return }
        selectedEvent = event
        Constants.referMessage = ""
        PredictViewModel.submitAnswer(gameId: gId, event: event, index: selectedIndex, complition: onSuccess)
        print("submit ans")
    }
}

extension PredictMatchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let cellCount = eventsList?.questionList?.count ?? 0
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PredictMatchTableViewCell") as! PredictMatchTableViewCell

        let questions = eventsList?.questionList?[indexPath.row].question
        
        if eventsList?.questionList?.count ?? 0 > 1 {
            cell.seperatorView.isHidden = false
        } else {
            cell.seperatorView.isHidden = true
        }
        cell.populateView(index: indexPath.row, info: eventsList, complition: answerButtonTapped(action:))
        return cell
    }
    
    func answerButtonTapped(action: PredictMatchTableViewCellAction) {
        switch action {
        case .tapped(let qNo, let inde):
            self.teamA = eventsList?.OpponentA ?? ""
            self.teamB = eventsList?.OpponentB ?? ""
            
        break
        default:
            break
        }
        guard let eve = eventsList else { return }
        if PredictViewModel.checkAllQuestionAnswered(event: eve, index: selectedIndex) {
            self.submitButton.alpha = 1.0
            self.submitButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1294117647, blue: 0.3960784314, alpha: 1)
            self.submitButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.submitButton.isUserInteractionEnabled = true
        }
    }
    
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
