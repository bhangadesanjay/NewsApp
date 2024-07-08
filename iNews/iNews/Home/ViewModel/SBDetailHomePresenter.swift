//
//  SBDetailHomePresenter.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 07/07/24.
//

import Foundation

import UIKit

protocol SBDetailHomePresentationLogic {
    func displayScreenTitle(screenTitle:String)
    func getArticleURL(articleURL:String)
}

class SBDetailHomePresenter:SBDetailHomePresentationLogic{
    func getArticleURL(articleURL: String) {
        DispatchQueue.main.async {
            self.viewController?.loadArticleURL(articleString: articleURL)
        }
    }
    
    weak var viewController:DetailHomeViewDisplayLogic?
    func displayScreenTitle(screenTitle: String) {
        self.viewController?.setScreenTitle(screenTitle: screenTitle)
    }
}
