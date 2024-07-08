//
//  SBLanguageManager.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 05/07/24.
//

import Foundation

public enum Languages: String {
    case en
}

public class SBLanguageManager {
    
    /// Returns the singleton LanguageManager instance.
    public static let shared: SBLanguageManager = SBLanguageManager()
    
    public var currentLanguage: Languages {
        get {
                return Languages(rawValue: "en")!
        }
    }
}

public extension String {
    
    ///
    /// Localize the current string to the selected language
    /// - returns: The localized string
    ///
    
    func localize(comment: String = "", tableName: String = "SBLocalization") -> String {
        let language = SBLanguageManager.shared.currentLanguage.rawValue
        guard let bundle = Bundle.main.path(forResource: language, ofType: "lproj") else {
            return NSLocalizedString(self, comment: comment)
        }
        
        let langBundle = Bundle(path: bundle)
        return NSLocalizedString(self, tableName: tableName, bundle: langBundle!, comment: comment)
    }
}
