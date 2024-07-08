//
//  SBHomePresenter.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 07/07/24.
//

import Foundation
import UIKit

protocol SBHomePresentationLogic {
    func hideLoaderView()
    func showLoaderView()
    func displayArticles(articles:[Article])
    func displayScreenTitle(screenTitle:String)
    func navigateDetailArticle(article: Article)
}

class SBHomePresenter:SBHomePresentationLogic{
    func hideLoaderView() {
        DispatchQueue.main.async {
            self.viewController?.hideLoaderView()
        }
    }
    
    func showLoaderView() {
        DispatchQueue.main.async {
            self.viewController?.showLoaderView()
        }
    }
    
    weak var viewController:HomeViewDisplayLogic?
    func navigateDetailArticle(article: Article) {
        self.viewController?.showDetailArticle(article: article)
    }
    
    func displayScreenTitle(screenTitle: String) {
        self.viewController?.setScreenTitle(screenTitle: screenTitle)
    }
    
    func displayArticles(articles: [Article]) {
        DispatchQueue.main.async {
            self.viewController?.displayArticles(articles: articles)
        }
    }
    
    
}
