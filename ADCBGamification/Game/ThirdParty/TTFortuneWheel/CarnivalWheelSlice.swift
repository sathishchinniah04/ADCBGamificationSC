//
//  CarnivalWheelSlice.swift
//  TTFortuneWheelSample
//
//  Created by Efraim Budusan on 11/1/17.
//  Copyright © 2017 Tapptitude. All rights reserved.
//

import UIKit
//import TTFortuneWheel

public class CarnivalWheelSlice: FortuneWheelSliceProtocol {
    
    public enum Style {
        case brickRed
        case sandYellow
        case babyBlue
        case deepBlue
    }
    
    public var title: String
    public var degree: CGFloat = 0.0
    
    var lightGra = TTUtils.uiColor(from:0xDDDDDD)
    //UIColor(red: 220.0/256.0, green: 220.0/256.0, blue: 220.0/256.0, alpha: 1)
    var offWhite = TTUtils.uiColor(from:0xFFFFFF)//UIColor(red: 253.0/256.0, green: 253.0/256.0, blue: 253.0/256.0, alpha: 1)
    
    public var backgroundColor: UIColor? {
        switch style {
        case .brickRed: return TTUtils.uiColor(from:0xE27230)
        case .sandYellow: return lightGra//TTUtils.uiColor(from:0xFFF7C2)
        case .babyBlue: return UIColor.blue//TTUtils.uiColor(from:0x93D0C4)
        case .deepBlue: return offWhite//TTUtils.uiColor(from:0xDF190D)
        }
    }
    
    public var fontColor: UIColor {
        switch style {
        case .sandYellow: return UIColor.darkBlueColor()//UIColor.red
        case .deepBlue: return UIColor.darkBlueColor()
        case .brickRed: return UIColor.darkBlueColor()
        case .babyBlue: return UIColor.darkBlueColor()
        }
    }
    
    public var offsetFromExterior:CGFloat {
        return 10.0
    }
        
    public var font: UIFont {
        let font = (StoreManager.shared.language == GameLanguage.AR.rawValue) ? UIFont(name: "Tajawal-Bold", size: 10.0) : UIFont(name: "OpenSans-Bold", size: 10.0)
        
       // let font = UIFont(name: "OpenSans-ExtraBold", size: 1.0) ?? UIFont.boldSystemFont(ofSize: 1.5)
        switch style {
        
        case .brickRed: return font ?? UIFont.boldSystemFont(ofSize: 1.5)
            //UIFont.boldSystemFont(ofSize: 25)
        case .sandYellow: return font ?? UIFont.boldSystemFont(ofSize: 1.5)
            //UIFont.boldSystemFont(ofSize: 25)
        case .babyBlue: return font ?? UIFont.boldSystemFont(ofSize: 1.5)
            //UIFont.boldSystemFont(ofSize: 25)
        case .deepBlue: return font ?? UIFont.boldSystemFont(ofSize: 1.5)
            
        }
    }
    
    public var stroke: StrokeInfo? {
        return StrokeInfo(color: UIColor.white, width: 0.0)
    }
    
    public var style:Style = .brickRed
    
    public init(title:String) {
        self.title = title
        
    }
    
    public convenience init(title:String, degree:CGFloat) {
        self.init(title:title)
        self.degree = degree
    }
    
}
