//
//  ReferIntroController.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit

class ReferIntroController: UIViewController {
    
    @IBOutlet weak var expireView: ExpireView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var bgCloudImage: UIImageView!
    @IBOutlet weak var referMessageLabel: UILabel!
    @IBOutlet weak var referMessageLabelEnglish: UILabel!
    @IBOutlet weak var referArbLblLeftConstraints: NSLayoutConstraint!
    @IBOutlet weak var referEngLblLeftConstraints: NSLayoutConstraint!
    
    var game: Games?
    var isDirectLoad: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.expireView.populateView(isShowTerms: false, game: game, complition: expireViewHandle)
//

        
        //setupLabelConstraints()
        setupArabicLabelConstraints()
        if StoreManager.shared.language == GameLanguage.EN.rawValue {
            referMessageLabel.isHidden = true
            referMessageLabelEnglish.isHidden = false
        } else {
            referMessageLabel.isHidden = false
            referMessageLabelEnglish.isHidden = true
        }
        checkLeftToRight()
        getReferCode()
        initialSetup()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
        //self.referMessageLabelEnglish.semanticContentAttribute = .forceLeftToRight

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        let con = self.navigationController
        (con as? CustomNavViewController)?.showLogo()
        if !isDirectLoad {return}
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // print("values", referArbLblLeftConstraints.constant)
    }
    
    func setupLabelConstraints() {
       
        let device = UIDevice.current.modelName
        if (device == "iPhone 11 Pro" || device == "iPhone 11 Pro Max") {
            referEngLblLeftConstraints.constant = 105
        } else {
            referEngLblLeftConstraints.constant = 112
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.referMessageLabelEnglish.layoutIfNeeded()
        }
    }
    
    
    func setupArabicLabelConstraints() {
       
        let device = UIDevice.current.modelName
        if (device == "iPhone 8") {
            referArbLblLeftConstraints.constant = 180
        } else  if (device == "iPhone 11 Pro") {
            referArbLblLeftConstraints.constant = 190
        } else {
            referArbLblLeftConstraints.constant = 200
        }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.referMessageLabel.layoutIfNeeded()
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isDirectLoad {return}
        print("viewWillDisappear")

    }
    
    func getReferCode() {
        self.activityIndicatorView.startAnimating()
        ReferViewModel.getReferalCode { (data) in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.referMessageLabel.text = data.rewardMessage
                self.referMessageLabelEnglish.text = data.rewardMessage
//
            }
        }
    }
    
    func initialSetup() {
        expireView.setupButtonName(name: "Refer".localized())
        expireView.isUserInteractionEnabled = false
        expireView.alpha = 0.0
        if let gam = game {
            self.updateOnResponce(game: gam, error: nil)
        }
    }
    
    func updateOnResponce(game: Games?, error: GameError?) {
        if let gam = game {
            self.updateOnReponceHandler(game: gam)
        }
        Utility.errorHandler(target: self, error: error)
    }
    
    
    func updateErrorOnResponce(errorMsg: String, isSuccess: Bool) {
        self.showToast(message: errorMsg)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: false) {
                CallBack.shared.handle!(.dismissed)
            }
        }
    }
    
    func updateOnReponceHandler(game: Games) {
        print("Updated from game list type = \(game.gameType)  gameId  = \(game.gameId ?? "")")
        self.game = game
        activityIndicatorView.stopAnimating()
        expireView.isUserInteractionEnabled = true
        self.game = game
        expireViewSetup()
        UIView.animate(withDuration: 0.3) {
            self.expireView.alpha = 1.0
        }
    }
    
    
    func expireViewSetup() {
        
        //expireView.setupButtonName(name: "Predict Now".localized())
        expireView.populateView(isShowTerms: false, game: self.game) {
          self.nextController()
        }
    }
    
    func nextController() {
        let cont = UIStoryboard(name: "Refer", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "ReferController") as! ReferController
        //cont.game = self.game
        self.navigationController?.pushViewController(cont, animated: true)
    }
    
//    func navigate() {
//
//            //let cont = UIStoryboard(name: "Refer", bundle: Bundle(for: ReferIntroController.self)).instantiateViewController(withIdentifier: "ReferViewController") as! ReferViewController
//            let cont = UIStoryboard(name: "Refer", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "ReferController") as! ReferController
//            self.navigationController?.pushViewController(cont, animated: true)
//
//    }
}


