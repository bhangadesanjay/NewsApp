//
//  UITableView+Placeholder.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 07/07/24.
//

import Foundation
import UIKit

extension UITableView {
    func placeholderMessage(_ message:String) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.frame.width, height: self.frame.height))
        let view  = UIView(frame: rect)
        let rect1 = CGRect(origin: CGPoint(x: 20,y :0), size: CGSize(width: self.frame.width - 40, height: self.frame.height))
        let messageLabel = SBCustomLabel(frame: rect1)
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.regularFont()
        messageLabel.textKey = message
        messageLabel.textColor = UIColor.init(named: "TextColor")
        messageLabel.numberOfLines = 0
        
        view.addSubview(messageLabel)
        
        self.backgroundView = view
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
