//
//  Convenience.swift
//  News
//
//  Created by Abhishek Agarwal on 03/09/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import Foundation

extension NewsClient {
    
    func getNewsArticles(forSearchQuery queryString: String, completionHandlerForArticles: @escaping (_ result: [NewsArticle]?, _ error: NSError?) -> Void) {
        
        let parameters = [
            ParameterKeys.Query: queryString,
        ]
        
        let _ = taskForGETMethod(Methods.News, parameters: parameters as [String: AnyObject]) { (result, error) in
            if let error = error {
                completionHandlerForArticles(nil, error)
            } else {
                if let result = result as? [String: AnyObject], let hits = result[JSONResponseKeys.Hits] as? [[String: AnyObject]] {
                    let articles = NewsArticle.articlesFromHits(hits)
                    completionHandlerForArticles(articles, nil)
                } else {
                    completionHandlerForArticles(nil, NSError(domain: "getNewsArticles parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getNewsArticles"]))
                }
            }
        }
    }

}
