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
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var completedTableView: CompletedTableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let collectionDataSource = CollectionDataSource()
    let flowLayout = ZoomAndSnapFlowLayout()
    //var gameListViewModel: GameListViewModel?
    var games: [Games]? = []
    //var complition:((GameAction)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        collectionViewSetup()
        segmentControlSetup()
        getGameListFromApi()
        pageControlSetup()
        
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
        completedTableView.tableViewSetup()
        pageControl.isHidden = true
    }
    
    func displayGameList() {
        completedTableView.isHidden = true
        collectionView.isHidden = false
        pageControl.isHidden = false
    }
    
    func displayCompletedGames() {
        completedTableView.isHidden = false
        collectionView.isHidden = true
        pageControl.isHidden = true
    }
    
    func getGameListFromApi() {
        games = [Games]()
        
        GameListVM.getGameList(url: Constants.listGameUrl) {
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
    
    func pageControlSetup() {
        pageControl.addTarget(self, action: #selector(self.pageControlSelectionAction(_:)), for: .touchUpInside)
    }
    @objc func pageControlSelectionAction(_ sender: UIPageControl) {
        let page: Int? = sender.currentPage
        if let page = page {
            self.collectionView.scrollToItem(at: IndexPath(row: page, section: 0), at: .centeredHorizontally, animated: true)
        }
        print("Current page is \(String(describing: page))")
    }
    
    func segmentControlSetup() {
        //segmentControl.selectedSegmentIndex = 1
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
        //        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)], for: .selected)
        segmentControl.addTarget(self, action: #selector(segmentHanlder(segment:)), for: .valueChanged)
    }
    
    @objc func segmentHanlder(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            self.displayGameList()
        } else {
            self.displayCompletedGames()
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
    @IBAction func backButtonAction() {
        //        if self.navigationController != nil {
        //            self.navigationController?.popViewController(animated: true)
        //        } else {
        self.dismiss(animated: true, completion: nil)
        //}
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        //self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.isNavigationBarHidden = false
        //self.navigationController?.navigationBar.isHidden = false
    }
}

extension GamesViewController {
    func cellActionHandler(action: CollectionCellAction) {
        switch action {
        case .startGame(let index):
            navigateToController(game: self.games?[index.row])
        case .page(let index):
            self.pageControl.currentPage = index
        }
    }
    
    func navigateToController(game: Games?) {
        if game?.gameTitle == "Guess N Win" {
            moveToGuessAndWin(game: game)
        } else if game?.gameTitle == "Refer N Win" {
            moveToReferAndWin(game: game)
        } else if game?.gameTitle == "Shake And Win" {
            moveToShakeAndWin(game: game)
        } else if game?.gameTitle == "SpinNWin" {
            moveToSpinAndWin(game: game)
        } else if game?.gameTitle == "Lottery N Win" {
            moveToLotteryAndWin(game: game)
        } else if game?.gameTitle == "Survey"{
            moveToLotteryAndWin(game: game)
        } else if game?.gameTitle == "Quiz"{
            moveToActiveAndWin(game: game)
        } else if game?.gameTitle == "Predict N Win" {
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
}
