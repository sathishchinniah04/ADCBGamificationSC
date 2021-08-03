//
//  UIController+Extension.swift
//  Gamification
//
//  Created by SKY on 19/06/21.
//

import UIKit

extension UIViewController{
    func openActivityController(text: String) {
        DispatchQueue.main.async {
            let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func getTopController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
            if let nav = base as? UINavigationController {
                return getTopController(base: nav.visibleViewController)
            }
            if let tab = base as? UITabBarController {
                if let selected = tab.selectedViewController {
                    return getTopController(base: selected)
                }
            }
            if let presented = base?.presentedViewController {
                return getTopController(base: presented)
            }
            return base
        }
    
    func checkLeftToRight() {
        let sementicAttribute: UISemanticContentAttribute = (StoreManager.shared.language.lowercased() == "en") ? .forceLeftToRight : .forceRightToLeft
            self.navigationController?.navigationBar.semanticContentAttribute = sementicAttribute
            self.navigationController?.view.semanticContentAttribute = sementicAttribute
            UIView.userInterfaceLayoutDirection(for: sementicAttribute)
            UIView.appearance().semanticContentAttribute = sementicAttribute
            
        }

}
extension UINavigationController {
    func getTopController1(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
            if let nav = base as? UINavigationController {
                return getTopController1(base: nav.visibleViewController)
            }
            if let tab = base as? UITabBarController {
                if let selected = tab.selectedViewController {
                    return getTopController1(base: selected)
                }
            }
            if let presented = base?.presentedViewController {
                return getTopController1(base: presented)
            }
            return base
        }
}
