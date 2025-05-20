//
//  BookListTableViewCell.swift
//  GoogleBooks
//
//  Created by Rohit Kowadkar on 20/05/25.
//

import UIKit

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
    
    func configureCell(for book: BookModel) {
        
        
    }
}
