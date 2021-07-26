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
    
    var games = [Games]()
    var contRef: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        getResponce()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        let con = self.navigationController
        //(con as? CustomNavViewController)?.hideBackButton(isHide: true)
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
        //registerClass(myFooterViewClass, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "myFooterView")
        //register(UINib(nibName: "ADCBGameListCollectionCell", bundle: Bundle(for: SeforCellWithReuseIdentifiereIdentifier: "ADCBGameListCollectionCell")
    }
    
    func getResponce() {
        GameListVM.getGameList(url: Constants.listGameUrl) {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.games = GameListVM.allGames
                self.gamesCollectionView.reloadData()
            }
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
    return cell
}

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gameType = games[indexPath.row].gameType
        let game = games[indexPath.row]
        getControllerRef(gameType: gameType, game: game)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width/2.28)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {

            case UICollectionView.elementKindSectionHeader:

                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ListGameCollectionHeaderView", for: indexPath) as! ListGameCollectionHeaderView
                headerView.backgroundColor = .clear
                headerView.populateView(title: "Enjoy the games and earn more rewards. We wish you goodluck!")
                return headerView

            case UICollectionView.elementKindSectionFooter:
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
                return footerView

            default:

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
    
    

    
}
