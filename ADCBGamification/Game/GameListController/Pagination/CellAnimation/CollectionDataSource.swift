//
//  CollectionDataSource.swift
//  Pagination
//
//  Created by SKY on 25/12/20.
//

import UIKit
enum CollectionCellAction {
    //case didSelect(IndexPath)
    case startGame(IndexPath)
    case page(Int)
    
        
}
class CollectionDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var cellTapHandler: ((CollectionCellAction)->Void)?
   // var numberOfItems: Int = 0
    var collectionView: UICollectionView!
    var games: [Games]? = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.games?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PageCollectionCell
        cell.populateCell(index: indexPath, game: self.games?[indexPath.row])
        cell.cellTapHandler = cellTapHandler
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("didselect \(indexPath)")
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        //cellTapHandler?(.startGame)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Find collectionview cell nearest to the center of collectionView
        // Arbitrarily start with the last cell (as a default)
        var closestCell : UICollectionViewCell = collectionView.visibleCells[0];
        for cell in collectionView!.visibleCells as [UICollectionViewCell] {
            let closestCellDelta = abs(closestCell.center.x - collectionView.bounds.size.width/2.0 - collectionView.contentOffset.x)
            let cellDelta = abs(cell.center.x - collectionView.bounds.size.width/2.0 - collectionView.contentOffset.x)
            if (cellDelta < closestCellDelta){
                closestCell = cell
            }
        }
        let indexPath = collectionView.indexPath(for: closestCell)
        collectionView.scrollToItem(at: indexPath!, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        cellTapHandler?(.page(indexPath?.row ?? 0))
       // print("Index is \(indexPath)")
    }
}
