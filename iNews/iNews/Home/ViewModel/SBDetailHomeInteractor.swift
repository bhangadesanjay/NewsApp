//
//  SBDetailHomeInteractor.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 07/07/24.
//

import Foundation

protocol SBDetailHomeInteractorLogic {
    func setArticle(article: Article?)
    func getScreenTitle()
    func getArticleURL()
}
class SBDetailHomeInteractor: SBDetailHomeInteractorLogic  {
    func setArticle(article: Article?) {
        self.article = article
    }
    
    
    func getArticleURL() {
        self.presenter?.getArticleURL(articleURL: self.article?.url ?? "http://google.com")
    }
    
    var presenter: SBDetailHomePresentationLogic?
    var article:Article?
    func getScreenTitle() {
        self.presenter?.displayScreenTitle(screenTitle: "Detail Article".localize())
    }
}
