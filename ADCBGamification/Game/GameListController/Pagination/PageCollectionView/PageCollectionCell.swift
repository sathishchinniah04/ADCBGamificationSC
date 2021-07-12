//
//  PageCollectionCell.swift
//  Pagination
//
//  Created by SKY on 25/12/20.
//

import UIKit

class PageCollectionCell: UICollectionViewCell {
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var expireLabel: UILabel!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    
    var index: IndexPath?
    var game: Games?
    var cellTapHandler: ((CollectionCellAction)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func populateCell(index: IndexPath, game: Games?) {
        self.index = index
        self.game = game
        setLabel(game: game)
        setImageView(index: index.row)
        game?.executionStatus == "LOCKED" ? onLock(info: game) : onActive(info: game)
        setImage(index: index.row)
        localize()
        addShadowOnLabel()
    }
    func addShadowOnLabel() {
        gameNameLabel.addShadow(shadowRadius: 4)
        expireLabel.addShadow(shadowRadius: 4)
        gameDescriptionLabel.addShadow(shadowRadius: 4)
    }
    
    func localize() {
        playButton.setTitle("Play now", for: .normal)
    }
    
    func setImage(index: Int) {
        backGroundImageView.image = UIImage(named: "ListImg\(index)", in: Bundle(for: PageCollectionCell.self), compatibleWith: nil)//UIImage(named: "ListImg\(index)")
       // backGroundImageView.downloadImageWith(name: self.game?.displayDetails?.imageList.first?.name ?? "")
    }
    func setImageView(index: Int) {
        switch index {
        case 0:
            self.backGroundImageView.backgroundColor = UIColor.blue.withAlphaComponent(0.7)
        case 1:
            self.backGroundImageView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        case 2:
            self.backGroundImageView.backgroundColor = UIColor.orange.withAlphaComponent(0.7)
        default:
            self.backGroundImageView.backgroundColor = .red
        }
        
    }
    
    func setLabel(game: Games?) {
        gameNameLabel.text = game?.gameTitle
        gameDescriptionLabel.text = game?.displayDetails?.description
    }

    @IBAction func startGameButtonAction() {
        if let index = self.index {
            cellTapHandler?(.startGame(index))
        }
    }
    
    func onActive(info: Games?) {
        let date = info?.executionPeriod?.endDateTime ?? ""
        expireLabel.text = "Expires in" + " \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).0)h  \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).1)min"
    }
    
    func onLock(info: Games?) {
        
        let date = info?.executionPeriod?.startDateTime ?? ""
        expireLabel.text = "Available in" + " \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).0)h  \(Utility.secondsToHoursMinutesSeconds(seconds: Utility.convertStringIntoDate(date: date)).1)min"
    }
}
