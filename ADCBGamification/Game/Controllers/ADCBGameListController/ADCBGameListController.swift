//
//  ADCBGameListController.swift
//  ADCBGamification
//
//  Created by SKY on 13/07/21.
//

import UIKit

class ADCBGameListController: UIViewController {
    
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var customNavigationView: UIView!
    @IBOutlet weak var bgCloudImage: UIImageView!
    @IBOutlet weak var topSectionView: UIView!
    @IBOutlet weak var gameButtonSection: UIButton! {
        didSet {
            gameButtonSection.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var conteestWinnerSection: UIButton! {
        didSet {
            conteestWinnerSection.layer.cornerRadius = 12
        }
    }
    
    
    var games = [Games]()
    var contestWinnerList = [PredictContestWinnerModel]()
    var currentIndex = 0
    var contRef: UIViewController?
    var selectedSectionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topSectionView.isHidden = true
        UIFont.loadMyFonts
        UIApplication.configureFacebookId
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadGames(notification:)), name: Notification.Name("ReloadGameList"), object: nil)

        if #available(iOS 13.0, *) {
            //UIApplication.shared.windows.over
           // overrideUserInterfaceStyle = .light
            
            UIWindow().overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        tableViewSetup()
        getInitialApiCalls()
        navigationViewCornerRadius()
        playerGameHandler()
        checkLeftToRight()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
    }
    
    @objc func reloadGames(notification: Notification) {
        getInitialApiCalls()
    }
    
    func navigationViewCornerRadius() {
        self.customNavigationView.layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.customNavigationView.roundCorners(corners: [.bottomLeft,.bottomRight], bound: self.customNavigationView.bounds, radius: 20.0)
        }
    }
    
    func playerGameHandler() {
//        CallBack.shared.callBacKAction { (action) in
//            switch action {
//            case .gamePlayed(let index):
//                DispatchQueue.main.async {
//                    //: TODOD - Disabling is handled based on the game.executionStatus
//                    /* let cell = self.gamesCollectionView.cellForItem(at: index) as? ADCBGameListCollectionCell
//                     cell?.disableCell() */
//                }
//                print("gamePlayed")
//            default :
//                print("Default action")
//            }
//        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        let con = self.navigationController
 
        (con as? CustomNavViewController)?.changeOnlyTitle(title: "Games".localized())
//        activityIndicatorView.startAnimating()
//        getResponce()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
        let con = self.navigationController
        //(con as? CustomNavViewController)?.hideBackButton(isHide: false)
    }
    
    func tableViewSetup() {
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        gamesCollectionView.register(UINib(nibName: "ADCBGameListCollectionCell", bundle: Bundle(for: Self.self)), forCellWithReuseIdentifier: "ADCBGameListCollectionCell")
        gamesCollectionView.register(UINib(nibName: "ContestWinnerCollectionCell", bundle: Bundle(for: Self.self)), forCellWithReuseIdentifier: "ContestWinnerCollectionCell")
        gamesCollectionView.register(UINib(nibName: "ListGameCollectionHeaderView", bundle: Bundle(for: Self.self)), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ListGameCollectionHeaderView")
        gamesCollectionView.register(UINib(nibName: "ListGameCollectionFooterView", bundle: Bundle(for: Self.self)), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ListGameCollectionFooterView")
        
    }
    
    
    func getInitialApiCalls() {
        
        self.activityIndicatorView.startAnimating()
        let taskGroup = DispatchGroup()
        taskGroup.enter()
        self.getContestResponse { isSuccess in
            taskGroup.leave()
        }
        taskGroup.enter()
        self.getResponce { isSuccess in
            taskGroup.leave()
        }
        taskGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
        }
        
    }
    
    func getResponce(completion: @escaping(_: (Bool) -> Void)) {
        
        enableGameSectionTab()
        GameListVM.getGameList(url: Constants.listGameUrl) { (success, message) in
            if success {
                DispatchQueue.main.async {
                    self.games = GameListVM.allGames
                    self.gamesCollectionView.reloadData()
                    completion(true)
                }
            } else {
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    let text = message ?? ""
                    self.showToast(message: (text.isEmpty) ? "Something went wrong. Try again !" : text)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        
                        self.dismiss(animated: false) {
                            CallBack.shared.handle!(.dismissed)
                        }                    }
                }
                completion(false)
            }
            
        }
    }
    
    func getContestResponse(completion: @escaping(_: (Bool) -> Void)) {
        
        enableContestWinnerTab()
        GameListVM.getPredicNWinContestList(url: Constants.predictContestWinnerListUrl) { (data) in
            if data?.respCode == "SC0000" {
                DispatchQueue.main.async {
                    self.topSectionView.isHidden = false
                    self.contestWinnerList = (data?.announcedEvents ?? [])
                    self.gamesCollectionView.reloadData()
                    completion(true)
                }
            } else {
                self.topSectionView.isHidden = true
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    let text = data?.respDesc ?? ""
                    self.showToast(message: (text.isEmpty) ? "Something went wrong. Try again !" : text)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.dismiss(animated: false) {
                            CallBack.shared.handle!(.dismissed)
                        }                    }
                }
                completion(false)
            }
        }
        
    }
    
    deinit {
      NotificationCenter.default.removeObserver(self, name: Notification.Name("ReloadGameList"), object: nil)
    }
    
    
    func moveToController(sName: String, id: String, gameType: String, game: Games, index: IndexPath) {
        let contr = UIStoryboard(name: sName, bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: id)
        if gameType == "PredictNWin" {
            (contr as? PredictIntroController)?.game = game
        } else if gameType == "SpinNWin" {
            (contr as? SpinMainVC)?.game = game
            (contr as? SpinMainVC)?.gameIndex = index
        } else if gameType == "ReferNWin" {
            (contr as? ReferIntroController)?.game = game
        }
        self.navigationController?.pushViewController(contr, animated: true)
    }
    
    func getControllerRef(gameType: String, game: Games, index: IndexPath) {
        if gameType == "SpinNWin" {
            self.moveToController(sName: "Spin", id: "SpinMainVC", gameType: gameType, game: game, index: index)
        } else if gameType == "PredictNWin" {
            self.moveToController(sName: "Predict", id: "PredictIntroController", gameType: gameType, game: game, index: index)
        } else if gameType == "ReferNWin" {
            self.moveToController(sName: "Refer", id: "ReferIntroController", gameType: gameType, game: game, index: index)
        } else {
            print("no game type ")
        }
    }
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    
    fileprivate func enableGameSectionTab() {
        
        selectedSectionIndex = 0
        
        gameButtonSection.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1294117647, blue: 0.3960784314, alpha: 1)
        gameButtonSection.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        conteestWinnerSection.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        conteestWinnerSection.setTitleColor(#colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.337254902, alpha: 1), for: .normal)
    }
    
    @IBAction func gameSectionAction(_ sender: Any) {
        self.activityIndicatorView.startAnimating()
        getResponce { isSuccess in
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    fileprivate func enableContestWinnerTab() {
        
        selectedSectionIndex = 1
        
        conteestWinnerSection.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1294117647, blue: 0.3960784314, alpha: 1)
        conteestWinnerSection.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        gameButtonSection.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        gameButtonSection.setTitleColor(#colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.337254902, alpha: 1), for: .normal)
        
    }
    
    @IBAction func contestWinnerSectionAction(_ sender: Any) {
        self.activityIndicatorView.startAnimating()
        getContestResponse { isSuccess in
            self.activityIndicatorView.stopAnimating()
        }
        
    }
    
}

extension ADCBGameListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedSectionIndex == 0 {
            return games.count
        }
        return contestWinnerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if selectedSectionIndex == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ADCBGameListCollectionCell", for: indexPath) as! ADCBGameListCollectionCell
            cell.populateView(game: self.games[indexPath.row], index: indexPath.row)
            cell.crownAction = {
                print(indexPath.row)
                let contr = UIStoryboard(name: "LeaderBoard", bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: "LeaderBoardVC")
                (contr as? LeaderBoardVC)?.game =  self.games[indexPath.row]
                self.navigationController?.pushViewController(contr, animated: true)
            }
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContestWinnerCollectionCell", for: indexPath) as! ContestWinnerCollectionCell
        cell.populateView(list: self.contestWinnerList[indexPath.row], index: indexPath.row)
        return cell

       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedSectionIndex == 0 {
            let gameType = games[indexPath.row].gameType
            let game = games[indexPath.row]
            getControllerRef(gameType: gameType, game: game,index: indexPath)
        } else {
            self.currentIndex = indexPath.row
            performSegue(withIdentifier: "showwinners", sender: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width/2.28)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ListGameCollectionHeaderView", for: indexPath) as! ListGameCollectionHeaderView
            headerView.backgroundColor = .clear
            if selectedSectionIndex == 0 {
                headerView.populateView(title: "Enjoy your time and win many prizes".localized())
            } else {
                headerView.populateView(title: "Announcement from last 30 days. Contest winner will be alerted with a notification".localized())
            }
            
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ListGameCollectionFooterView", for: indexPath)
            return footerView
            
        default:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ListGameCollectionFooterView", for: indexPath)
            return footerView
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        //OpenSans-Regular
        let siz = headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return siz
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showwinners") {
            let vc = segue.destination as! ContestWinnerDetailsVC
            vc.gameId = self.contestWinnerList[currentIndex].gameId ?? 0
            vc.eventId = self.contestWinnerList[currentIndex].eventId ?? 0
        }
    }
    
}

