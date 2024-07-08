//
//  ArticleTableCell.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 07/07/24.
//

import Foundation
import UIKit

class ArticleTableCell: UITableViewCell {
    
    @IBOutlet weak var articleImageView: UIImageView!    
    @IBOutlet weak var descriptionLabel: SBCustomLabel!
    @IBOutlet weak var titleLabel: SBCustomLabel!
    
    @IBOutlet weak var dateLabel: SBCustomLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func load(article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.articleDescription
        articleImageView.downloadImage(withUrl: article.urlToImage ?? "")
        dateLabel.text = article.convertPublishTimeToString()
    }
}
