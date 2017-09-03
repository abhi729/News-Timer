//
//  NewsArticle.swift
//  News
//
//  Created by Abhishek Agarwal on 02/09/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import Foundation

struct NewsArticle {
    
    let title: String?
    let url: URL?
    let author: String?
    let points: Int?
    let storyText: String?
    let numberOfComments: Int?
    let tags: [String]?
    let highlightedTitle: HighlightedObject?
    let highlightedUrl: HighlightedObject?
    let highlightedAuthor: HighlightedObject?
    let highlightedStoryText: HighlightedObject?
    
    init(dictionary: [String:AnyObject]) {
        title = dictionary[NewsClient.JSONResponseKeys.Title] as? String
        if let urlString = dictionary[NewsClient.JSONResponseKeys.Url] as? String {
            url = URL(string: urlString)
        } else {
            url = nil
        }
        author = dictionary[NewsClient.JSONResponseKeys.Author] as? String
        points = dictionary[NewsClient.JSONResponseKeys.Points] as? Int
        storyText = dictionary[NewsClient.JSONResponseKeys.StoryText] as? String
        numberOfComments = dictionary[NewsClient.JSONResponseKeys.NumberOfComments] as? Int
        tags = dictionary[NewsClient.JSONResponseKeys.Tags] as? [String]
        if let highlightedResult = dictionary[NewsClient.JSONResponseKeys.HighlightedResult] as? [String: AnyObject] {
            if let titleDict = highlightedResult[NewsClient.JSONResponseKeys.Title] as? [String: AnyObject] {
                highlightedTitle = HighlightedObject(dictionary: titleDict)
            } else {
                highlightedTitle = nil
            }
            if let urlDict = highlightedResult[NewsClient.JSONResponseKeys.Url] as? [String: AnyObject] {
                highlightedUrl = HighlightedObject(dictionary: urlDict)
            } else {
                highlightedUrl = nil
            }
            if let authorDict = highlightedResult[NewsClient.JSONResponseKeys.Author] as? [String: AnyObject] {
                highlightedAuthor = HighlightedObject(dictionary: authorDict)
            } else {
                highlightedAuthor = nil
            }
            if let storyTextDict = highlightedResult[NewsClient.JSONResponseKeys.StoryText] as? [String: AnyObject] {
                highlightedStoryText = HighlightedObject(dictionary: storyTextDict)
            } else {
                highlightedStoryText = nil
            }
        } else {
            highlightedTitle = nil
            highlightedUrl = nil
            highlightedAuthor = nil
            highlightedStoryText = nil
        }
    }
    
    static func articlesFromHits(_ hits: [[String:AnyObject]]) -> [NewsArticle] {
        var articles = [NewsArticle]()
        
        for hit in hits {
            articles.append(NewsArticle(dictionary: hit))
        }
        
        return articles
    }
}

struct HighlightedObject {
    
    let value: String?
    let matchLevel: String?
    let fullyHighlighted: Bool?
    let matchedWords: [String]?
    
    init(dictionary: [String:AnyObject]) {
        value = dictionary[NewsClient.JSONResponseKeys.Value] as? String
        matchLevel = dictionary[NewsClient.JSONResponseKeys.MatchLevel] as? String
        fullyHighlighted = dictionary[NewsClient.JSONResponseKeys.FullyHighlighted] as? Bool
        matchedWords = dictionary[NewsClient.JSONResponseKeys.MatchedWords] as? [String]
    }
    
}

