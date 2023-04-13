//
//  ArticleTableViewCell.swift
//  RusikApp
//
//  Created by ANTON on 19.01.2023.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleNameLabel: UILabel!
    @IBOutlet weak var articleIDLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fill(with model: Article)  {
        
        articleNameLabel.text = model.articleName ?? "1"
        articleIDLabel.text = model.articleId ?? "2"
        countLabel.text = String(describing: model.articleCount)
    }
}
