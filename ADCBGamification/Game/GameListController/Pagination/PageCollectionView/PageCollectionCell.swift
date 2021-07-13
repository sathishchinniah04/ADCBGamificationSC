//
//  PageCollectionCell.swift
//  Pagination
//
//  Created by SKY on 25/12/20.
//

import UIKit

class PageCollectionCell: UICollectionViewCell {
    //@IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var gameLogoImageView: UIImageView!
    @IBOutlet weak var expireView: ExpireView!
    var index: IndexPath?
    var game: Games?
    var cellTapHandler: ((CollectionCellAction)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func populateCell(index: IndexPath, game: Games?) {
        
        expireView.populateView(isShowTerms: false, game: game) {
            print("tap action PageCollectionCell")
            self.cellTapHandler?(.startGame(index))
        }
        addShadowOnView()
        guard let gam = game else { return }
        imageLogoSetup(game: gam, index: index.row)
    }
    func addShadowOnView() {
        self.addShadow(cornerRadius: 10, shadowRadius: 3, opacity: 0.4, color: UIColor.black)
    }
    
    func imageLogoSetup(game: Games,index: Int) {
        var imgName: String = ""
        if game.gameType == "SpinNWin" {
            imgName = "Spin"
        } else if game.gameType == "PredictNWin" {
            
        } else if game.gameType == "ReferNWin" {
            
        } else if game.gameType == "Spi" {
            
        } else {
            
        }
        gameLogoImageView.image = UIImage(named: imgName, in: Bundle(for: Self.self), compatibleWith: nil)
    }
    
//
    func setImage(index: Int) {
        backGroundImageView.image = UIImage(named: "ListImg\(index)", in: Bundle(for: PageCollectionCell.self), compatibleWith: nil)//UIImage(named: "ListImg\(index)")
    
    }
    
}
