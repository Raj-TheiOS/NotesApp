//
//  UIViewControllerExtension.swift
//  NotesApp
//
//  Created by Raj_iLS on 06/07/22.
//

import Foundation
import  UIKit

extension UIViewController {
    static func topMostViewController() -> UIViewController? {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return keyWindow?.rootViewController?.topMostViewController()
        }
        
        return UIApplication.shared.keyWindow?.rootViewController?.topMostViewController()
    }
    
    func topMostViewController() -> UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.topMostViewController()
        }
        else if let tabBarController = self as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return selectedViewController.topMostViewController()
            }
            return tabBarController.topMostViewController()
        }
            
        else if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        }
        
        else {
            return self
        }
    }
    
    func showAlert(withTitle title: String, andMessage message:String) {
        let alert = UIAlertController(title: title, message: message,
                                  preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style:
        UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
