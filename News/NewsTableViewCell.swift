//
//  NewsTableViewCell.swift
//  News
//
//  Created by Abhishek Agarwal on 03/09/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlOrStoryLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    var article: NewsArticle!
    
}
