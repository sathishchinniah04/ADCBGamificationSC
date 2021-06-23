//
//  UIButton+Extension.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit
extension UIButton {
    func addInnerShadowBtn(lightShadow: CALayer?, darkShadow: CALayer?, cornerRadius: CGFloat = 5) {
        guard let darkSha = darkShadow else { return }
        guard let lightSha = lightShadow else { return }
        darkSha.frame = self.bounds
        let roundedRect1 = darkSha.bounds.insetBy(dx: -2, dy: -2)
        //let radius1 = self.frame.size.height/2
        let path1 = UIBezierPath(roundedRect: roundedRect1, cornerRadius:cornerRadius)
        let cutout1 = UIBezierPath(roundedRect: darkSha.bounds, cornerRadius:cornerRadius).reversing()
        path1.append(cutout1)
        darkSha.shadowPath = path1.cgPath
        darkSha.masksToBounds = true
        darkSha.shadowColor = UIColor.black.cgColor
        darkSha.shadowOffset = CGSize(width: 2, height: 2)
        darkSha.shadowOpacity = 0.5
        darkSha.shadowRadius = 2
        darkSha.cornerRadius = cornerRadius
        layer.addSublayer(darkSha)
        
        
        
        lightShadow?.frame = self.bounds
        
        // Shadow path (1pt ring around bounds)
       // let radius = self.frame.size.height/2
        let path = UIBezierPath(roundedRect: lightSha.bounds.insetBy(dx: 2, dy:2), cornerRadius:cornerRadius)
        let cutout = UIBezierPath(roundedRect: lightSha.bounds, cornerRadius:cornerRadius).reversing()
        path.append(cutout)
        lightSha.shadowPath = path.cgPath
        lightSha.masksToBounds = true
        
        // Shadow properties
        lightSha.shadowColor = UIColor.white.cgColor
        lightSha.shadowOffset = CGSize(width: -2, height: -2)
        lightSha.shadowOpacity = 1
        lightSha.shadowRadius = 3
        lightSha.cornerRadius = cornerRadius
        layer.addSublayer(lightSha)
    }
    
    func addNeumorphicBtnStyle(darkLayer: CALayer?, lightLayer: CALayer?, cornerRadius: CGFloat = 5, isPressed: Bool = true) {
        guard let darkLayer = darkLayer else { return  }
        guard let lightLayer = lightLayer else { return  }
       // let backgroundColor = UIColor(red: 248.0/256.0, green: 248.0/256.0, blue: 248.0/256.0, alpha: 1)
        let darkShadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        let lightShadow1 = UIColor.white.cgColor
        self.layer.masksToBounds = false
        let shadowRadius: CGFloat = 3
        
        darkLayer.frame = self.bounds
        darkLayer.backgroundColor = UIColor.newmorphicColor().cgColor
        darkLayer.shadowColor = darkShadowColor
        //darkLayer.t
        darkLayer.cornerRadius = cornerRadius
        let pressedDarkValue = !isPressed ? shadowRadius : -shadowRadius
        darkLayer.shadowOffset = CGSize(width: pressedDarkValue, height: pressedDarkValue)
        darkLayer.shadowOpacity = 0.15
        darkLayer.shadowRadius = shadowRadius
        self.layer.insertSublayer(darkLayer, at: 0)
        
        
        lightLayer.frame = self.bounds
        lightLayer.backgroundColor = UIColor.newmorphicColor().cgColor//backgroundColor.cgColor
        lightLayer.shadowColor =   lightShadow1//UIColor.red.cgColor
        lightLayer.cornerRadius = cornerRadius
        let pressedLightValue = isPressed ? shadowRadius : -shadowRadius
        lightLayer.shadowOffset = CGSize(width: pressedLightValue, height: pressedLightValue)
        lightLayer.shadowOpacity = 1
        lightLayer.shadowRadius = shadowRadius/2
        
        self.layer.insertSublayer(lightLayer, at: 0)
    }
}
