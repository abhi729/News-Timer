//
//  Constants.swift
//  News
//
//  Created by Abhishek Agarwal on 02/09/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

extension NewsClient {
    
    struct Constants {
        static let ApiScheme = "http"
        static let ApiHost = "hn.algolia.com"
    }
    
    struct Methods {
        static let News = "/api/v1/search"
    }
    
    struct ParameterKeys {
        static let Query = "query"
    }
    
    struct JSONResponseKeys {
        
        static let Hits = "hits"
        static let Title = "title"
        static let Url = "url"
        static let Author = "author"
        static let Points = "points"
        static let NumberOfComments = "num_comments"
        static let HighlightedResult = "_highlightResult"
        static let Value = "value"
        static let MatchLevel = "matchLevel"
        static let FullyHighlighted = "fullyHighlighted"
        static let MatchedWords = "matchedWords"
        static let Tags = "_tags"
        static let StoryText = "story_text"
        
    }
}

struct TimerConstants {
    static let TimerDuration = 20
}
