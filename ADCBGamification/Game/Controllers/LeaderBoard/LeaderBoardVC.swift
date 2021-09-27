//
//  LeaderBoardVC.swift
//  ADCBGamification
//
//  Created by Sathish Kumar on 27/09/21.
//

import UIKit

class LeaderBoardVC: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var customNavigationView: UIView!
    @IBOutlet weak var bgCloudImage: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var SecondRunnerView: UIView! {
        didSet {
            SecondRunnerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var thirdRunnerView: UIView! {
        didSet {
            thirdRunnerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var firstWinnerView: UIView! {
        didSet {
            firstWinnerView.layer.cornerRadius = 10
        }
    }
    
    
    var contRef: UIViewController?
    var game: Games?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIFont.loadMyFonts
        if #available(iOS 13.0, *) {
            UIWindow().overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        navigationViewCornerRadius()
        checkLeftToRight()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        self.gameName.text = game?.gameType
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        let con = self.navigationController
 
        (con as? CustomNavViewController)?.changeOnlyTitle(title: "LeaderBoard".localized())
    }
    
    func navigationViewCornerRadius() {
        self.customNavigationView.layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.customNavigationView.roundCorners(corners: [.bottomLeft,.bottomRight], bound: self.customNavigationView.bounds, radius: 20.0)
        }
    }

}
