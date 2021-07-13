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
    }
    func addShadowOnView() {
        self.addShadow(cornerRadius: 10, shadowRadius: 3, opacity: 0.4, color: UIColor.black)
    }
    
//
    func setImage(index: Int) {
        backGroundImageView.image = UIImage(named: "ListImg\(index)", in: Bundle(for: PageCollectionCell.self), compatibleWith: nil)//UIImage(named: "ListImg\(index)")
    
    }
    
}
