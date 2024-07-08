//
//  SBDetailHomeViewController.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 07/07/24.
//

import Foundation
import UIKit
import WebKit

protocol DetailHomeViewDisplayLogic:AnyObject {
    func setScreenTitle(screenTitle:String)
    func loadArticleURL(articleString:String)
}

class SBDetailHomeViewController: UIViewController, DetailHomeViewDisplayLogic{
    func loadArticleURL(articleString: String) {
        guard let url = URL(string:articleString) else { return  } 
        self.articleDetailWebView.load(URLRequest(url: url))
    }
    
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var articleDetailWebView: WKWebView!
    var article:Article?
    var interactor: SBDetailHomeInteractorLogic?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
    }
    
    private func setup()
    {
        self.articleDetailWebView.navigationDelegate = self
        let viewController = self
        let interactor = SBDetailHomeInteractor()
        let presenter = SBDetailHomePresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        self.loadIndicator.startAnimating()
        self.interactor?.setArticle(article: self.article)
        self.interactor?.getScreenTitle()
        self.interactor?.getArticleURL()
    }
    
    func setScreenTitle(screenTitle: String) {
        self.title = screenTitle
    }
}

extension SBDetailHomeViewController:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        DispatchQueue.main.async {
            self.loadIndicator.startAnimating()
        }
    } // show indicator
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        DispatchQueue.main.async {
            self.loadIndicator.stopAnimating()
        }
    }  // hide indicator
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        DispatchQueue.main.async {
            self.loadIndicator.stopAnimating()
        }
    }  // hide indicator*
}
