//
//  ArticleTableViewCell.swift
//  RusikApp
//
//  Created by ANTON on 19.01.2023.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fill(with model: Order)  {
        
    }
}
