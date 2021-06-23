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
    
    var lightGra = UIColor(red: 220.0/256.0, green: 220.0/256.0, blue: 220.0/256.0, alpha: 1)
    var offWhite = UIColor(red: 253.0/256.0, green: 253.0/256.0, blue: 253.0/256.0, alpha: 1)
    
    public var backgroundColor: UIColor? {
        switch style {
        case .brickRed: return UIColor.lightText//TTUtils.uiColor(from:0xE27230)
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
        switch style {
        case .brickRed: return UIFont(name: "Montserrat-Bold", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 15)
            //UIFont.boldSystemFont(ofSize: 25)
        case .sandYellow: return UIFont(name: "Montserrat-Bold", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 15)
            //UIFont.boldSystemFont(ofSize: 25)
        case .babyBlue: return UIFont(name: "Montserrat-Bold", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 15)
            //UIFont.boldSystemFont(ofSize: 25)
        case .deepBlue: return UIFont(name: "Montserrat-Bold", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 15)
            
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
