//
//  BookListTableViewCell.swift
//  GoogleBooks
//
//  Created by Rohit Kowadkar on 20/05/25.
//

import UIKit
import SDWebImage
class BookListTableViewCell: UITableViewCell {

    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var getButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(for book: BookModel ,index: Int) {
        
        if let thumbnailUrlStr = book.imageLinks["smallThumbnail"] {
            bookCoverImageView.sd_setImage(with: URL.init(string: thumbnailUrlStr))
        }
        
        bookNameLabel.text = "\(index + 1). " + book.title
        autherLabel.text = book.auther
        
        getButton.layer.cornerRadius = 15
        getButton.layer.masksToBounds = true
    }
}
