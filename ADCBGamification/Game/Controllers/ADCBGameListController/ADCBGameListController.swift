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
    var games = [Games]()
    var contRef: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIFont.loadMyFonts
        UIApplication.configureFacebookId
        if #available(iOS 13.0, *) {
            //UIApplication.shared.windows.over
           // overrideUserInterfaceStyle = .light
            
            UIWindow().overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        tableViewSetup()
        getResponce()
        navigationViewCornerRadius()
        playerGameHandler()
        checkLeftToRight()
        self.bgCloudImage.image = UIImage(named: "Clouds", in: Bundle(for: CustomNavView.self), compatibleWith: nil)
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
        gamesCollectionView.register(UINib(nibName: "ListGameCollectionHeaderView", bundle: Bundle(for: Self.self)), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ListGameCollectionHeaderView")
        gamesCollectionView.register(UINib(nibName: "ListGameCollectionFooterView", bundle: Bundle(for: Self.self)), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ListGameCollectionFooterView")
        
    }
    
    func getResponce() {
        GameListVM.getGameList(url: Constants.listGameUrl) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.games = GameListVM.allGames
                    self.gamesCollectionView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.showToast(message: "Something went wring. Try again !")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.dismiss(animated: false, completion:  nil)
                    }
                }

            }

        }
    }
    
    func moveToController(sName: String, id: String, gameType: String, game: Games, index: IndexPath) {
        let contr = UIStoryboard(name: sName, bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: id)
        if gameType == "PredictNWin" {
            (contr as? PredictIntroController)?.game = game
        } else if gameType == "SpinNWin" {
            (contr as? SpinHomeController)?.game = game
            (contr as? SpinHomeController)?.gameIndex = index
        } else if gameType == "ReferNWin" {
            (contr as? ReferIntroController)?.game = game
        }
        self.navigationController?.pushViewController(contr, animated: true)
    }
    
    func getControllerRef(gameType: String, game: Games, index: IndexPath) {
        if gameType == "SpinNWin" {
            self.moveToController(sName: "Spin", id: "SpinHomeController", gameType: gameType, game: game, index: index)
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
}

extension ADCBGameListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return games.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gameType = games[indexPath.row].gameType
        let game = games[indexPath.row]
        getControllerRef(gameType: gameType, game: game,index: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width/2.28)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {

            case UICollectionView.elementKindSectionHeader:

                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ListGameCollectionHeaderView", for: indexPath) as! ListGameCollectionHeaderView
                headerView.backgroundColor = .clear
                headerView.populateView(title: "Enjoy the games and earn more rewards. We wish you goodluck!".localized())
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

    
}

