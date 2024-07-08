//
//  SBHomeInteractor.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 07/07/24.
//

import Foundation

protocol SBHomeInteractorLogic {
    func fetchArticles(pageNo:Int)
    func getScreenTitle()
    func navigateDetailArticle(articleIndex: Int)
    func loadMoreArticles()
}
class SBHomeInteractor: SBHomeInteractorLogic  {
    func loadMoreArticles() {
        var totalNumberOfPages = totalArticles / articlesPerPage
        let extraArticles = totalArticles % articlesPerPage
        if (extraArticles > 0){
            totalNumberOfPages = totalNumberOfPages + 1
        }
        if (pageNo < totalNumberOfPages){
            pageNo = pageNo + 1
            self.fetchArticles(pageNo: pageNo)
        }
    }
    
    
    func navigateDetailArticle(articleIndex: Int) {
        if let articles = articleData{
            self.presenter?.navigateDetailArticle(article: articles[articleIndex])
        }
    }
    
    func getScreenTitle() {
        self.presenter?.displayScreenTitle(screenTitle: "Home".localize())
    }
    
    let APIKey = "5cbf67bbf9424e0598d619d12b92c9af"
    let articlesPerPage = 20
    var pageNo:Int = 1
    var presenter: SBHomePresentationLogic?
    var articleData:[Article]?
    var totalArticles:Int = 0
    
    func fetchArticles(pageNo: Int) {
        if let articles = articleData {
            if (articles.count == 0){
                self.presenter?.showLoaderView()
            }
        }else{
            self.presenter?.showLoaderView()
        }
        
        let articleResource = Articles.urlQueryItemForAllArticles(apiKey: APIKey, page: "\(pageNo)")
        
        NetworkManager.shared.loadArticleData(articleResource) { response in
            switch response {
            case .success(let results):
                print("\(results)")
                if let articles = results as? Articles {
                    if(pageNo == 1){
                        self.articleData = []
                        self.presenter?.hideLoaderView()
                    }
                    self.articleData?.append(contentsOf: articles.articles)
                    self.totalArticles = articles.totalResults
                    self.presenter?.displayArticles(articles: articles.articles)
                }
                
            case .failure(let error):
                print("\(error)")
            }
        }
    }   
}
