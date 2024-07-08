//
//  SBHomeViewControllerTest.swift
//  iNewsTests
//
//  Created by Sanjay Bhanagade on 08/07/24.
//

@testable import iNews
import XCTest
import Foundation

class SBHomeViewControllerTest: XCTestCase {
    var objectTest: SBHomeViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupHomeViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    func setupHomeViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        objectTest = storyboard.instantiateViewController(withIdentifier: "SBHomeViewController") as? SBHomeViewController
    }
    
    func loadView()
    {
        window.addSubview(objectTest.view)
        RunLoop.current.run(until: Date())
    }
    
    class SBHomeInteractorLogicInjectible: SBHomeInteractorLogic {
        func fetchArticles(pageNo: Int) {
            fetchArticlesGotCalled = true
        }
        
        func getScreenTitle() {
            ScreenTitleGotCalled = true
        }
        
        func navigateDetailArticle(articleIndex: Int) {
            navigateDetailArticleGotCalled = true
        }
        
        func loadMoreArticles() {
            loadMoreArticlesGotCalled = true
        }
        
        
        var articleData:[Article]?
        var fetchArticlesGotCalled:Bool = false
        var ScreenTitleGotCalled: Bool = false
        var navigateDetailArticleGotCalled: Bool = false
        var loadMoreArticlesGotCalled:Bool = false
        
        
        
    }
    
    class TableViewInjectible: UITableView {
        var reloadDataCalled = false
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    func testShouldFetchArticlesWhenViewDidAppear(){
        //Given
        let homeInteractorLogicInjectible = SBHomeInteractorLogicInjectible()
        objectTest.interactor = homeInteractorLogicInjectible
        loadView()
        //When
        objectTest.viewDidLoad()
        //Then
        
    }
}


