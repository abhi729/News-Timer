//
//  ArticleViewController.swift
//  News
//
//  Created by Abhishek Agarwal on 03/09/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    var article: NewsArticle!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
        self.navigationItem.title = article.title
        if let author = article.author {
            self.authorLabel.text = "Author: " + author
        } else {
            self.authorLabel.text = ""
        }
        
        if let content = article.storyText {
            webView.loadHTMLString(String(describing: content), baseURL: nil)
        } else {
            if let url = article.url {
                let request = URLRequest(url: url)
                webView.loadRequest(request)
            }
        }
    }
    
}

extension ArticleViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Finished")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error)
    }
    
}
