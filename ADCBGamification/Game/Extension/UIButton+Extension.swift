//
//  UIButton+Extension.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit
extension UIButton {
    func addCustomShadow(cornerRadius:CGFloat = 5.0,shadowRadius:CGFloat = 4, opacity: CGFloat = 0.1, color:UIColor = UIColor.black, offset: CGSize) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset//CGSize(width: 0, height: 0.0)
        layer.shadowOpacity = Float(opacity)
        layer.shadowRadius = shadowRadius
    }
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
    
    func addBtnInnerShadowView(lightShadow: CALayer?, darkShadow: CALayer?, cornerRadius: CGFloat = 5, backColor: UIColor? = UIColor.newmorphicColor()) {
        guard let liSha = lightShadow else { return }
        guard let darkSha = darkShadow else { return }
        darkLayer(darkSha: darkSha, cornerRadius: cornerRadius, backColor: backColor!)
        lightShadow1(lightSha: liSha, cornerRadius: cornerRadius, backColor: backColor!)
    }
    
    func customShadow(lightSha: CALayer, cornerRadius: CGFloat, backColor: UIColor, shadowColor: UIColor, shadowRadius: CGFloat = 2.0, opacity: CGFloat = 1.0,dx: CGFloat = 2.0, dy: CGFloat = 2.0) {
        
        lightSha.frame = self.bounds
        let path = UIBezierPath(roundedRect: lightSha.bounds.insetBy(dx: dx, dy:dy), cornerRadius:cornerRadius)
        let cutout = UIBezierPath(roundedRect: lightSha.bounds, cornerRadius:cornerRadius).reversing()
        path.append(cutout)
        lightSha.shadowPath = path.cgPath
        lightSha.masksToBounds = true
        self.layer.backgroundColor = backColor.cgColor
        self.layer.cornerRadius = cornerRadius
        lightSha.shadowColor = shadowColor.cgColor
        lightSha.shadowOffset = CGSize(width: -dx, height: -dy)
        lightSha.shadowOpacity = Float(opacity)
        lightSha.shadowRadius = shadowRadius
        lightSha.cornerRadius = cornerRadius
        layer.addSublayer(lightSha)
    }
    
    
    
    
    private func lightShadow1(lightSha: CALayer, cornerRadius: CGFloat, backColor: UIColor) {
        lightSha.frame = self.bounds
        let path = UIBezierPath(roundedRect: lightSha.bounds.insetBy(dx: 2, dy:2), cornerRadius:cornerRadius)
        let cutout = UIBezierPath(roundedRect: lightSha.bounds, cornerRadius:cornerRadius).reversing()
        path.append(cutout)
        lightSha.shadowPath = path.cgPath
        lightSha.masksToBounds = true
        self.layer.backgroundColor = backColor.cgColor
        self.layer.cornerRadius = cornerRadius
        lightSha.shadowColor = UIColor.white.cgColor
        lightSha.shadowOffset = CGSize(width: -2, height: -2)
        lightSha.shadowOpacity = 1
        lightSha.shadowRadius = 2
        lightSha.cornerRadius = cornerRadius
        layer.addSublayer(lightSha)
    }
    
    private func darkLayer(darkSha: CALayer, cornerRadius: CGFloat, backColor: UIColor) {
        darkSha.frame = self.bounds
        let roundedRect1 = darkSha.bounds.insetBy(dx: -2, dy: -2)
        let path1 = UIBezierPath(roundedRect: roundedRect1, cornerRadius:cornerRadius)
        let cutout1 = UIBezierPath(roundedRect: darkSha.bounds, cornerRadius:cornerRadius).reversing()
        path1.append(cutout1)
        darkSha.shadowPath = path1.cgPath
        darkSha.masksToBounds = true
        //darkSha.backgroundColor = UIColor.green.cgColor
        self.layer.backgroundColor = backColor.cgColor
        self.layer.cornerRadius = cornerRadius
        darkSha.shadowColor = UIColor.black.cgColor
        darkSha.shadowOffset = CGSize(width: 2, height: 2)
        darkSha.shadowOpacity = 0.3
        darkSha.shadowRadius = 2
        darkSha.cornerRadius = cornerRadius
        layer.addSublayer(darkSha)
    }
    
    
    //    func addCustomNeumorphicBtnStyle(darkLayer: CALayer?, lightLayer: CALayer?, color1 : UIColor = UIColor.white, color2 : UIColor = UIColor.newmorphicColor(),bgColor : UIColor = UIColor.newmorphicColor(),cornerRadius: CGFloat = 5, isPressed: Bool = true) {
    //        guard let darkLayer = darkLayer else { return  }
    //        guard let lightLayer = lightLayer else { return  }
    //       // let backgroundColor = UIColor(red: 248.0/256.0, green: 248.0/256.0, blue: 248.0/256.0, alpha: 1)
    //        let darkShadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
    //        let lightShadow1 = color1.cgColor//UIColor.white.cgColor
    //        self.layer.masksToBounds = false
    //        let shadowRadius: CGFloat = 3
    //
    //        darkLayer.frame = self.bounds
    //        darkLayer.backgroundColor = bgColor.cgColor//color2.cgColor//UIColor.newmorphicColor().cgColor
    //        darkLayer.shadowColor = darkShadowColor
    //        //darkLayer.t
    //        darkLayer.cornerRadius = cornerRadius
    //        let pressedDarkValue = !isPressed ? shadowRadius : -shadowRadius
    //        darkLayer.shadowOffset = CGSize(width: pressedDarkValue, height: pressedDarkValue)
    //        darkLayer.shadowOpacity = 0.15
    //        darkLayer.shadowRadius = shadowRadius
    //        self.layer.insertSublayer(darkLayer, at: 0)
    //
    //
    //        lightLayer.frame = self.bounds
    //        lightLayer.backgroundColor = UIColor.newmorphicColor().cgColor//backgroundColor.cgColor
    //        lightLayer.shadowColor =   lightShadow1//UIColor.red.cgColor
    //        lightLayer.cornerRadius = cornerRadius
    //        let pressedLightValue = isPressed ? shadowRadius : -shadowRadius
    //        lightLayer.shadowOffset = CGSize(width: pressedLightValue, height: pressedLightValue)
    //        lightLayer.shadowOpacity = 1
    //        lightLayer.shadowRadius = shadowRadius/2
    //
    //        self.layer.insertSublayer(lightLayer, at: 0)
    //    }
}
