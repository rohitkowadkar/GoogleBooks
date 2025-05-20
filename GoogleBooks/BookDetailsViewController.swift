//
//  BookDetailsViewController.swift
//  GoogleBooks
//
//  Created by Rohit Kowadkar on 20/05/25.
//

import UIKit

class BookDetailsViewController: UIViewController {

    @IBOutlet weak var bookMainImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var autherNameBtn: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var getButton: UIButton!
    
    @IBOutlet weak var pagesLabel: UILabel!
    @IBOutlet weak var buttonsDetailsView: UIView!
    var bookModelObj : BookModel? = nil
    
    @IBOutlet weak var closeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialiseViews()
    }
    
    func initialiseViews(){
        guard let bookModelObj = bookModelObj else {
            //todo display message for no data
            return
        }
        
        if let thumbnailUrlStr = bookModelObj.imageLinks["thumbnail"] {
            bookMainImageView.sd_setImage(with: URL.init(string: thumbnailUrlStr))
        }
        
        bookNameLabel.text = bookModelObj.title
        subtitleLabel.text = bookModelObj.subTitle
        autherNameBtn.setTitle(bookModelObj.auther, for: .normal)
        categoryLabel.text = bookModelObj.category
        pagesLabel.text = "\(bookModelObj.pageCount) Pages"
        
        closeButton.layer.cornerRadius = 20
        closeButton.layer.masksToBounds = true
        
        buttonsDetailsView.layer.cornerRadius = 15
        buttonsDetailsView.layer.masksToBounds = true
        
        getButton.layer.cornerRadius = 5
        getButton.layer.masksToBounds = true

        
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
