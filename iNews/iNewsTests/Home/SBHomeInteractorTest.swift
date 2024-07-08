//
//  SBHomeInteractorTest.swift
//  iNewsTests
//
//  Created by Sanjay Bhanagade on 08/07/24.
//

@testable import iNews
import XCTest
import Foundation

class SBHomeInteractorTest: XCTestCase {
    var objectTest: SBHomeInteractor!
    
    override func setUp() {
        super.setUp()
        setupSearchInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func setupSearchInteractor(){
        objectTest = SBHomeInteractor()
    }
    
    class SBHomePresentationLogicInjectible:SBHomePresentationLogic {
        func hideLoaderView() {
            isHideLoader = true
        }
        
        func showLoaderView() {
            isShowLoader = true
        }
        
        func displayArticles(articles: [iNews.Article]) {
            self.articles = articles
            self.isDisplayTable = true
        }
        
        func displayScreenTitle(screenTitle: String) {
            isDisplayTitle = true
        }
        
        func navigateDetailArticle(article: iNews.Article) {
            isNavigateDetail = false
        }
        
        
        var articles:[Article]?
        var isDisplayTable: Bool = true
        var isDisplayTitle:Bool = false
        var isShowLoader:Bool = false
        var isHideLoader:Bool = false
        var isNavigateDetail:Bool = false
        
    }
}
