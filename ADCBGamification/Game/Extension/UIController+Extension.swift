//
//  UIController+Extension.swift
//  Gamification
//
//  Created by SKY on 19/06/21.
//

import UIKit

extension UIViewController{
    func openActivityController(text: String) {
    let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
    self.present(activityVC, animated: true, completion: nil)
    }
}
