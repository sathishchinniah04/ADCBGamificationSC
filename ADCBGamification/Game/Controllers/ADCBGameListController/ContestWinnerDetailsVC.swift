//
//  ContestWinnerDetailsVC.swift
//  ADCBGamification
//
//  Created by Sathish Kumar on 31/01/22.
//

import UIKit

class ContestWinnerDetailsVC: UIViewController {
    
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
    @IBOutlet weak var bgCloudImage: UIImageView!
    @IBOutlet weak var topView: UIView!

    @IBOutlet weak var gameTitleLbl: UILabel!
    @IBOutlet weak var opponentCodeLbl: UILabel!
    @IBOutlet weak var contestDateLbl: UILabel!
    @IBOutlet weak var annonucementDateLbl: UILabel!
    @IBOutlet weak var contestTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var contestWinnerHeaderTitle: UILabel!
    
    var gameId = 0
    var eventId = 0
    let cellReuseIdentifier = "ContestWinnerTableViewCell"
    var winnerList = [PredictContestWinnerNameList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getContestWinnerDetails()
        contentViewTopConstraint.constant = 80
        addSwipe()
        checkLeftToRight()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        contestTableView.register(UINib(nibName: "ContestWinnerTableViewCell", bundle: Bundle(for: Self.self)), forCellReuseIdentifier: cellReuseIdentifier)
        contestTableView.delegate = self
        contestTableView.dataSource = self
        contestWinnerHeaderTitle.text = "Contest Winner Name".localized()


    }
    
    func getContestWinnerDetails() {
        
        activityIndicatorView.startAnimating()
        let url = Constants.predictContestWinnerDetailUrl + "\(gameId)"
        GameListVM.getContestWinnerDetails(url: url, eventId: "\(eventId)", limit: "0", offset: "0") { (data) in
            if data?.respCode == nil {
                self.updateUI(data: data)
            } else {
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    let text = data?.respDesc ?? ""
                    self.showToast(message: (text.isEmpty) ? "Something went wrong. Try again !" : text)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.dismiss(animated: false) {
                            CallBack.shared.handle!(.dismissed)
                        }                    }
                }
            }
        }
        
    }
    
    func updateUI(data: PredictContestWinnerDetails?) {
        DispatchQueue.main.async {
            self.winnerList = (data?.winners ?? [])
            self.gameTitleLbl.text = (data?.title ?? "")
            if let opponentA = data?.opponentAsynonym, let opponentB = data?.opponentBsynonym {
                
                let opponentString = [NSAttributedString.Key.font : UIFont(name: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-Bold", size: 11), NSAttributedString.Key.foregroundColor : UIColor(red: 34/255.0, green: 33/255.0, blue: 101/255.0, alpha: 1.0) ]
                let vsString = [NSAttributedString.Key.font : UIFont(name: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular", size: 10), NSAttributedString.Key.foregroundColor : UIColor(red: 34/255.0, green: 33/255.0, blue: 101/255.0, alpha: 1.0) ]
                
                let text = NSMutableAttributedString()
                text.append(NSAttributedString(string: "\(opponentA.capitalized) ", attributes: opponentString as [NSAttributedString.Key : Any]));
                text.append(NSAttributedString(string: "vs".localized(), attributes: vsString as [NSAttributedString.Key : Any]));
                text.append(NSAttributedString(string: " \(opponentB.capitalized)", attributes: opponentString as [NSAttributedString.Key : Any]))
                self.opponentCodeLbl.attributedText = text
                
            }
            
            if let contestStartDate = data?.eventStartDate, let contestEndDate = data?.eventEndDate {
                
                let dateString = [NSAttributedString.Key.font : UIFont(name: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular", size: 14), NSAttributedString.Key.foregroundColor : UIColor(red: 34/255.0, green: 33/255.0, blue: 101/255.0, alpha: 1.0) ]
                let rawString = [NSAttributedString.Key.font : UIFont(name: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular", size: 14), NSAttributedString.Key.foregroundColor : UIColor(red: 84/255.0, green: 84/255.0, blue: 86/255.0, alpha: 1.0) ]
                
                let startDate = Utility.convertDateWithFormat(inputDate: contestStartDate, currFormat: "dd-MM-yyyy", expFormat: "MMM d")
                let endDate = Utility.convertDateWithFormat(inputDate: contestEndDate, currFormat: "dd-MM-yyyy", expFormat: " MMM d, yyyy")
                
                
                let text = NSMutableAttributedString()
                text.append(NSAttributedString(string: "Contest on".localized(), attributes: rawString as [NSAttributedString.Key : Any]));
                text.append(NSAttributedString(string: " ", attributes: rawString as [NSAttributedString.Key : Any]));
                text.append(NSAttributedString(string: "\(startDate) ", attributes: dateString as [NSAttributedString.Key : Any]));
                text.append(NSAttributedString(string: "-", attributes: dateString as [NSAttributedString.Key : Any]));
                text.append(NSAttributedString(string: " \(endDate)", attributes: dateString as [NSAttributedString.Key : Any]));
                
                self.contestDateLbl.attributedText = text
                
            }
            
            
            if let announceDate = data?.announcementDate {
                
                let dateString = [NSAttributedString.Key.font : UIFont(name: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular", size: 14), NSAttributedString.Key.foregroundColor : UIColor(red: 34/255.0, green: 33/255.0, blue: 101/255.0, alpha: 1.0) ]
                let rawString = [NSAttributedString.Key.font : UIFont(name: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular", size: 14), NSAttributedString.Key.foregroundColor : UIColor(red: 84/255.0, green: 84/255.0, blue: 86/255.0, alpha: 1.0) ]
                
                let currDate = Utility.convertDateWithFormat(inputDate: announceDate, currFormat: "dd-MM-yyyy", expFormat: " MMM d, yyyy")
                
                
                let text = NSMutableAttributedString()
                text.append(NSAttributedString(string: "Announced on".localized(), attributes: rawString as [NSAttributedString.Key : Any]));
                text.append(NSAttributedString(string: " ", attributes: rawString as [NSAttributedString.Key : Any]));
                text.append(NSAttributedString(string: "\(currDate) ", attributes: dateString as [NSAttributedString.Key : Any]));
                
                self.annonucementDateLbl.attributedText = text
                
            }
            
            self.contestTableView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
        
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
                })
            case .down:
                print("Gesture direction: Down")
                contentView.backgroundColor = .clear
                self.dismiss(animated: false, completion: nil)
                
            default:
                print("Unrecognized Gesture Direction")
        }
        
    }

}


extension ContestWinnerDetailsVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.winnerList.isEmpty {
            self.contestTableView.setEmptyMessage("No Winner available".localized())
        } else {
            self.contestTableView.restore()
        }
        return self.winnerList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ContestWinnerTableViewCell
        cell.indexLbl.text = "\(indexPath.row + 1)"
        cell.nameLbl.text =  self.winnerList[indexPath.row].name
        return cell
    }


}
