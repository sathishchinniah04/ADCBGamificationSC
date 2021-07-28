//
//  UIColor+Extension.swift
//  Gamification
//
//  Created by SKY on 19/06/21.
//

import UIKit
extension UIColor {
    
        public class func uiColor(from rgbValue: UInt, alpha: CGFloat = 1.0) -> UIColor {
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(alpha)
            )
        }

    class func specialBtnColor() -> UIColor {
         return UIColor(red: 34.0/256.0, green: 33.0/256.0, blue: 101.0/256.0, alpha: 1)
     }
    
    class func darkBlueColor() -> UIColor {
         return UIColor(red: 33.0/256.0, green: 32.0/256.0, blue: 97.0/256.0, alpha: 1)
     }
    
   class func newmorphicColor() -> UIColor {
        return UIColor(red: 248.0/256.0, green: 248.0/256.0, blue: 248.0/256.0, alpha: 1)
    }
    class func customYellowColor() -> UIColor {
         return UIColor(red: 255.0/256.0, green: 224.0/256.0, blue: 0.0/256.0, alpha: 1)
     }
}
