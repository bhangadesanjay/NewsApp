//
//  SBHomeViewController.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 07/07/24.
//

import Foundation
import UIKit

protocol HomeViewDisplayLogic:AnyObject {
    func displayArticles(articles:[Article])
    func setScreenTitle(screenTitle:String)
    func showDetailArticle(article:Article)
    func hideLoaderView()
    func showLoaderView()
}

class SBHomeViewController: UIViewController, HomeViewDisplayLogic{
    func showLoaderView() {
        self.articlesLoaderView.isHidden = false
        self.articleLoadIndicator.startAnimating()
    }
    
    func hideLoaderView() {
        self.articleLoadIndicator.stopAnimating()
        self.articlesLoaderView.isHidden = true
    }
    
    func showDetailArticle(article: Article) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailArticleController = storyboard.instantiateViewController(withIdentifier: "SBDetailHomeViewController") as? SBDetailHomeViewController {
            detailArticleController.article = article
            self.navigationController?.pushViewController(detailArticleController, animated: true)
        }        
    }
    
    
    
    @IBOutlet weak var articlesLoaderView: UIView!
    @IBOutlet weak var loadLabel: SBCustomLabel!
    
    
    @IBOutlet weak var articleLoadIndicator: UIActivityIndicatorView!
    var articleData:[Article]?
    let threshold = 100.0 // threshold from bottom of tableView
    var isLoadingMore = false // flag
    @IBOutlet weak var homeTableView: UITableView!{
        didSet{
            homeTableView.sectionFooterHeight = 1.0
            homeTableView.rowHeight = UITableView.automaticDimension
            homeTableView.separatorStyle = .none
            homeTableView.separatorColor = .clear
            
            homeTableView.register(UINib(nibName: "ArticleTableCell", bundle: nil), forCellReuseIdentifier: "ArticleTableCell")
            
            homeTableView.delegate = self
            homeTableView.dataSource = self
        }
    }
    var interactor: SBHomeInteractorLogic?
    
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
        let viewController = self
        let interactor = SBHomeInteractor()
        let presenter = SBHomePresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        self.interactor?.getScreenTitle()
        self.loadLabel.text = "Loading Articles".localize()
        fetchArticles()
        addRefreshControl()
    }
    
    func addRefreshControl(){
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh".localize())
        refreshControl.addTarget(self, action: #selector(refreshArticles), for: .valueChanged)
        self.homeTableView.refreshControl = refreshControl
    }
    
    @objc func refreshArticles(refreshControl: UIRefreshControl) {
        interactor?.fetchArticles(pageNo: 1)
        refreshControl.endRefreshing()
    }
    
    func fetchArticles(){
        interactor?.fetchArticles(pageNo: 1)
    }
    
    func displayArticles(articles: [Article]) {
        articleData = articles
        homeTableView.reloadData()
    }
    
    func setScreenTitle(screenTitle: String) {
        self.title = screenTitle
    }
    
}

extension SBHomeViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
}

extension SBHomeViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;

        if !isLoadingMore && (maximumOffset - contentOffset <= threshold) {
            // Get more data - API call
            self.isLoadingMore = true

            // Update UI
            DispatchQueue.main.async {
                self.interactor?.loadMoreArticles()
                self.isLoadingMore = false
            }
        }
    }
}

extension SBHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       let count = articleData?.count ?? 0
        
        if (count == 0){
            tableView.placeholderMessage("Articles not available")
        }else {
            tableView.restore()
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.navigateDetailArticle(articleIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let articles = articleData else {
            return UITableViewCell()
        }
        
        let article = articles[indexPath.row]
        let articleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableCell") as! ArticleTableCell
        articleCell.load(article: article)
        return articleCell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
