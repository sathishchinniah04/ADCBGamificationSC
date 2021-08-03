//
//  String+Extension.swift
//  Gamification
//
//  Created by SKY on 19/06/21.
//

import Foundation
extension String {
    func isValidPhone() -> Bool {
            let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: self)
        }
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailTest.evaluate(with: self)
    }
    
    var isNumeric: Bool {
         return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
    }
    
    func localized() -> String{
        
        let path = Bundle.main.path(forResource: StoreManager.shared.language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!,      value: "", comment: "")
    }
}
