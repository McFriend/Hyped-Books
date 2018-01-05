//
//  FeedTableViewCell.swift
//  Hyped Books
//
//  Created by George Sabanov on 05.01.2018.
//  Copyright © 2018 Georgiy Sabanov. All rights reserved.
//

import UIKit
    
class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readersLabel: UILabel!
    @IBOutlet weak var quotesLabel: UILabel!
    @IBOutlet weak var impressionsLabel: UILabel!
    @IBOutlet weak var bookshelvesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var annotationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coverImageView.sd_cancelCurrentImageLoad()
        self.coverImageView.image = nil
        self.authorLabel.text = ""
        self.titleLabel.text = ""
        self.readersLabel.text = ""
        self.quotesLabel.text = ""
        self.impressionsLabel.text = ""
        self.bookshelvesLabel.text = ""
        self.typeLabel.text = ""
        self.annotationLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
