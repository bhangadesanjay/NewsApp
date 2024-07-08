//
//  UIViewController+Alert.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 05/07/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showDefautAlert(message : String)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "AppName".localize(), message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK".localize(), style: .default, handler:nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
