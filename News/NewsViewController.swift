//
//  NewsViewController.swift
//  News
//
//  Created by Abhishek Agarwal on 03/09/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    var newsArticles: [NewsArticle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.estimatedRowHeight = 130
        newsTableView.rowHeight = UITableViewAutomaticDimension
        
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    func fetchNews(forCategory category: String) {
        activityIndicator.startAnimating()
        NewsClient.sharedInstance().getNewsArticles(forSearchQuery: category) { (articles, error) in
            guard error == nil else {
                return
            }
            guard articles != nil else {
                return
            }
            self.newsArticles = articles!
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.newsTableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToArticle" {
            let vc = segue.destination as! ArticleViewController
            let article = sender as! NewsArticle
            vc.article = article
        }
    }
    
}
