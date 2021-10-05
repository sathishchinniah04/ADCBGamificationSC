//
//  GamesViewController.swift
//  Pagination
//
//  Created by SKY on 25/12/20.
//

import UIKit

class GamesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionContainerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let collectionDataSource = CollectionDataSource()
    let flowLayout = ZoomAndSnapFlowLayout()
    var games: [Games]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        collectionViewSetup()
        getGameListFromApi()
        fixWarningActivityIndicator()
    }
    
    func fixWarningActivityIndicator(){
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .gray
        }
    }
    
    //flip
    func initialSetup() {
        displayGameList()
        
        pageControl.isHidden = true
    }
    
    func displayGameList() {
        
        collectionView.isHidden = false
        pageControl.isHidden = false
    }
    
    func displayCompletedGames() {
        
        collectionView.isHidden = true
        pageControl.isHidden = true
    }
    
    func getGameListFromApi() {
        games = [Games]()
        
        GameListVM.getGameList(url: Constants.listGameUrl) { (success,message)  in
                        DispatchQueue.main.async {
                            self.games = GameListVM.allGames
                            self.activityIndicator.stopAnimating()
                            self.pageControl.isHidden = false
                            self.collectionDataSource.games = self.games
                            self.pageControl.numberOfPages = self.games?.count ?? 0
                            self.collectionView.reloadData()
                        }
                    }
    }
    
    
    func collectionViewSetup(){
        guard let collectionView = collectionView else { fatalError() }
        //collectionDataSource.numberOfItems = 2
        collectionDataSource.collectionView = collectionView
        collectionDataSource.cellTapHandler = cellActionHandler(action:)
        //collectionView.decelerationRate = .fast //uncomment if necessary
        collectionView.dataSource = collectionDataSource
        collectionView.delegate = collectionDataSource
        collectionView.collectionViewLayout = flowLayout
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .always
        } else {
            // Fallback on earlier versions
        }
        collectionView.register(UINib(nibName: "PageCollectionCell", bundle: Bundle(for: PageCollectionCell.self)), forCellWithReuseIdentifier: "Cell")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.flowLayout.setHeight(width: self.collectionContainerView.bounds.width/1.7,height: self.collectionContainerView.frame.height-150)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension GamesViewController {
    func cellActionHandler(action: CollectionCellAction) {
        switch action {
        case .startGame(let index):
            //navigateToController(game: self.games?[index.row])
            self.getControllerRef(gameType: self.games?[index.row].gameType ?? "", game: (self.games?[index.row])!)
        case .page(let index):
            self.pageControl.currentPage = index
        }
    }
    
    
    
    func moveToController(sName: String, id: String, gameType: String, game: Games) {
        let contr = UIStoryboard(name: sName, bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: id)
        if gameType == "PredictNWin" {
            (contr as? PredictIntroController)?.game = game
        } else if gameType == "SpinNWin" {
            (contr as? SpinHomeController)?.game = game
        } else if gameType == "ReferNWin" {
            (contr as? ReferIntroController)?.game = game
        }
        self.navigationController?.pushViewController(contr, animated: true)
    }
    
    func getControllerRef(gameType: String, game: Games) {
        if gameType == "SpinNWin" {
            self.moveToController(sName: "Spin", id: "SpinHomeController", gameType: gameType, game: game)
        } else if gameType == "PredictNWin" {
            self.moveToController(sName: "Predict", id: "PredictIntroController", gameType: gameType, game: game)
        } else if gameType == "ReferNWin" {
            self.moveToController(sName: "Refer", id: "ReferIntroController", gameType: gameType, game: game)
        } else {
            print("no game type ")
        }
    }
    
    /*
    
    func navigateToController(game: Games?) {
        if game?.gameType == "GuessNWin" {
            moveToGuessAndWin(game: game)
        } else if game?.gameType == "ReferNWin" {
            moveToReferAndWin(game: game)
        } else if game?.gameType == "ShakeAndWin" {
            moveToShakeAndWin(game: game)
        } else if game?.gameType == "SpinNWin" {
            moveToSpinAndWin(game: game)
        } else if game?.gameType == "LotteryNWin" {
            moveToLotteryAndWin(game: game)
        } else if game?.gameType == "Survey"{
            moveToLotteryAndWin(game: game)
        } else if game?.gameType == "Quiz"{
            moveToActiveAndWin(game: game)
        } else if game?.gameType == "PredictNWin" {
            moveToPredictAndWin(game: game)
        } else {
            moveToLotteryAndWin(game: game)
        }
    }
    
    
    
    func moveToReferAndWin(game: Games?) {
        
    }
    
    func moveToSpinAndWin(game: Games?) {
        
    }
    
    func moveToShakeAndWin(game: Games?) {
        
    }
    func moveToGuessAndWin(game: Games?) {
        
    }
    func moveToLotteryAndWin(game: Games?) {
        
    }
    
    func moveToSpendAndWin(game: Games?) {
        
    }
    
    func moveToActiveAndWin(game: Games?) {
        
    }
    func moveToPredictAndWin(game: Games?) {
        
    }
 */
}
