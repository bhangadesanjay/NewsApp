//
//  SBCustomLabel.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 05/07/24.
//

import Foundation
import UIKit

@IBDesignable
final class SBCustomLabel:UILabel{
    @IBInspectable var textKey: String = ""{
        didSet{
            self.text = textKey.localize()
        }
    }
    
    @IBInspectable var fontStyle:String = FontType.regular.rawValue{
        didSet{
            self.adjustsFontForContentSizeCategory = true
            if(fontStyle == FontType.regular.rawValue){
                self.font = UIFont.regularFont()
            }else if(fontStyle == FontType.body.rawValue){
                self.font = UIFont.bodyFont()
            }else if(fontStyle == FontType.heading.rawValue){
                self.font = UIFont.headingFont()
            }else if(fontStyle == FontType.medium.rawValue){
                self.font = UIFont.mediumFont()
            }else if(fontStyle == FontType.bold.rawValue){
                self.font = UIFont.boldFont()
            }else if(fontStyle == FontType.title.rawValue){
                self.font = UIFont.titleFont()
            }
        }
    }
    
    @IBInspectable var accessibilityLabelText:String = ""{
        didSet{
            accessibilityLabel = accessibilityLabelText.localize()
        }
    }
    
    @IBInspectable var accessibilityHintText:String = ""{
        didSet{
            accessibilityHint = accessibilityHintText.localize()
        }
    }
}
