//
//  NewsCell.swift
//  News
//
//  Created by QuangTH on 2/24/20.
//  Copyright © 2020 quangth. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var newsImage: UIImageView!
    
    private let placeHolderImage = UIImage(named: "placeholder.jpg")
    
    var news: News? {
        didSet {
            guard let news = news else { return }
            titleLabel.text = news.title
            newsImage.image = placeHolderImage
            if let urlString = news.imageUrl, let url = URL(string: urlString) {
                newsImage.sd_setImage(with: url, placeholderImage: placeHolderImage)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        newsImage.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
