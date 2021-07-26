//
//  UIView+Extension.swift
//  Gamification
//
//  Created by SKY on 12/06/21.
//

import UIKit
enum AlertAction {
    case ok
    case cancel
}
extension UIView {
    
    @available(iOS 13.0, *)
    func blurrEffect(alfa: CGFloat = 1.0, blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterial)) {
        var blurEffectView: UIVisualEffectView?
            blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.alpha = alfa
        blurEffectView?.frame = self.bounds//UIScreen.main.bounds
            blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if let effe = blurEffectView {
            self.insertSubview(effe, at: 0)
        }
    }
    
    func showAlert(target: UIViewController? = nil, singelBtn: Bool = true,ok: String = "Ok", cancel: String = "Cancel",title: String = "Alert",message: String, complition:((AlertAction)->Void)?) {
        DispatchQueue.main.async {
            
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ok, style: .default, handler: { (action) in
            complition?(.ok)
        }))
        if !singelBtn {
            alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: { (action) in
            complition?(.cancel)
            }))
        }
            let rootView = UIApplication.shared.windows.last?.rootViewController
            if let tar = target {
                tar.present(alert, animated: true, completion: nil)
            } else {
                rootView?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func addInnerShadowView(lightShadow: CALayer?, darkShadow: CALayer?, cornerRadius: CGFloat = 5, backColor: UIColor? = UIColor.newmorphicColor()) {
        guard let liSha = lightShadow else { return }
        guard let darkSha = darkShadow else { return }
        darkLayer(darkSha: darkSha, cornerRadius: cornerRadius, backColor: backColor!)
        lightShadow1(lightSha: liSha, cornerRadius: cornerRadius, backColor: backColor!)
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
    
    func addShadow(cornerRadius:CGFloat = 5.0,shadowRadius:CGFloat = 4, opacity: CGFloat = 0.1, color:UIColor = UIColor.black) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.0)
        layer.shadowOpacity = Float(opacity)
        layer.shadowRadius = shadowRadius
    }
    
    func addDottedLine() {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineDashPattern = [3, 4]
        shapeLayer.frame = self.bounds
        shapeLayer.fillColor = nil
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds,cornerRadius: 10).cgPath
        self.layer.addSublayer(shapeLayer)
    }
    
    func addCustomShadow(cornerRadius:CGFloat = 5.0,shadowRadius:CGFloat = 4, opacity: CGFloat = 0.1, color:UIColor = UIColor.black, offSet: CGSize) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offSet
        layer.shadowOpacity = Float(opacity)
        layer.shadowRadius = shadowRadius
    }
    func addNeumorphicEffect(darkLayer: CALayer?, lightLayer: CALayer?, cornerRadius: CGFloat = 5, isPressed: Bool = true, backColor: UIColor? = UIColor.newmorphicColor()) {
        guard let darkLayer = darkLayer else { return  }
        guard let lightLayer = lightLayer else { return  }
       
        let darkShadowColor = UIColor.black.withAlphaComponent(1.0).cgColor
        let lightShadow1 = UIColor.white.cgColor
        self.layer.masksToBounds = false
        let shadowRadius: CGFloat = 2
        
        darkLayer.frame = self.bounds
        darkLayer.backgroundColor = backColor?.cgColor//backgroundColor.cgColor
        darkLayer.shadowColor = darkShadowColor
        //darkLayer.t
        darkLayer.cornerRadius = cornerRadius
        let pressedDarkValue = !isPressed ? shadowRadius : -shadowRadius
        darkLayer.shadowOffset = CGSize(width: pressedDarkValue, height: pressedDarkValue)
        darkLayer.shadowOpacity = 0.3
        darkLayer.shadowRadius = shadowRadius
        self.layer.insertSublayer(darkLayer, at: 0)
        
        
        lightLayer.frame = self.bounds
        lightLayer.backgroundColor = backColor?.cgColor//UIColor.newmorphicColor().cgColor//backgroundColor.cgColor
        lightLayer.shadowColor =   lightShadow1//UIColor.red.cgColor
        lightLayer.cornerRadius = cornerRadius
        let pressedLightValue = isPressed ? shadowRadius : -shadowRadius
        lightLayer.shadowOffset = CGSize(width: pressedLightValue, height: pressedLightValue)
        lightLayer.shadowOpacity = 1
        lightLayer.shadowRadius = shadowRadius
        
        self.layer.insertSublayer(lightLayer, at: 0)
    }
    func roundCorners(corners: UIRectCorner,bound:CGRect, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bound, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    
}
