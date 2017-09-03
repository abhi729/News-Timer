//
//  NewsVC+Delegates.swift
//  News
//
//  Created by Abhishek Agarwal on 03/09/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = newsArticles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        cell.article = article
        cell.titleLabel.text = article.title
        var urlOrStoryLabelText = ""
        if let urlString = article.url?.absoluteString, urlString != "" {
            urlOrStoryLabelText = urlString
        }
        if let storyText = article.highlightedStoryText?.value, storyText != "" {
            if urlOrStoryLabelText != "" {
                urlOrStoryLabelText += "\n\n"
            }
            urlOrStoryLabelText += storyText
                
        }
        cell.urlOrStoryLabel.text = urlOrStoryLabelText
        if let tags = article.tags {
            cell.tagsLabel.text = "Tags: " + tags.joined(separator: ", ")
        } else {
            cell.tagsLabel.text = ""
        }
        if let points = article.points {
            cell.pointsLabel.text = "Points: \(points)"
        } else {
            cell.pointsLabel.text = ""
        }
        if let numberOfComments = article.numberOfComments {
            cell.commentsLabel.text = "Comments: \(numberOfComments)"
        } else {
            cell.commentsLabel.text = ""
        }
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell {
            performSegue(withIdentifier: "SegueToArticle", sender: cell.article)
        }
    }
}

extension NewsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.newsArticles = []
        self.newsTableView.reloadData()
        if let query = searchBar.text {
            fetchNews(forCategory: query)
        }
    }
    
}
