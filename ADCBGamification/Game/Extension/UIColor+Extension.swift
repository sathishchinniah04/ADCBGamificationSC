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
    
    convenience init(hexString:String) {
        let hexString:NSString = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) as NSString
        let scanner            = Scanner(string: hexString as String)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }

        var color:UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}


extension UIImage {
    
    var changeInactiveImageColor: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
            let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
}

