//
//  UIFont+Custom.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 05/07/24.
//

import Foundation
import UIKit

public enum FontType: String {
    case body,regular,medium,heading,title,bold
    
}

extension UIFont {
    class func preferredFont(forTextStyle style: UIFont.TextStyle, fontName: String? = nil, weight: Weight = .regular, size: CGFloat? = nil) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let descriptor = preferredFont(forTextStyle: style).fontDescriptor
        let defaultSize = descriptor.pointSize
        let fontToScale: UIFont
        if let fontName = fontName,
        let font = UIFont(name: fontName, size: size ?? defaultSize)
        {
          fontToScale = font
        } else {
          fontToScale = UIFont.systemFont(ofSize: size ?? defaultSize, weight: weight)
        }
        return metrics.scaledFont(for: fontToScale)
    }
    
    class func bodyFont() -> UIFont{
        return UIFont.preferredFont(forTextStyle: .body,weight: .regular,size: 14)
    }
    
    class func regularFont() -> UIFont{
        return UIFont.preferredFont(forTextStyle: .body,weight: .regular,size: 16)
    }
    
    class func mediumFont() -> UIFont{
        return UIFont.preferredFont(forTextStyle: .body,weight: .medium,size: 16)
    }
    
    class func headingFont()->UIFont{
        return UIFont.preferredFont(forTextStyle: .headline,weight: .bold,size: 22)
    }
    
    class func titleFont()->UIFont{
        return UIFont.preferredFont(forTextStyle: .title1,weight: .bold,size: 20)
    }
    
    class func boldFont() -> UIFont{
        return UIFont.preferredFont(forTextStyle: .body,weight: .bold,size: 16)
    }
}
