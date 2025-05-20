//
//  ViewController.swift
//  GoogleBooks
//
//  Created by Rohit Kowadkar on 20/05/25.
//

import UIKit
/*BookModel
  - imageLinks
 - title
 - authers[]
 - pageCount
  ListVM
*/
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let booksListVM = BooksListViewModel()
    
    @IBOutlet weak var activityIndication: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialiseViews()
        initialiseViewModel()
        fetchBookListData()
        
    }
    
    func initialiseViews() {
        self.title = "Books"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BookListTableViewCell", bundle: .main), forCellReuseIdentifier: "BookListTableViewCell")
        activityIndication.hidesWhenStopped = true
    }
    

    func initialiseViewModel() {
        booksListVM.delegates = self
    }
    
    func fetchBookListData(){
        booksListVM.getInitialBookList()
    }
    
    func presentDetailViewControllerFor(bookModelObj: BookModel ){
        let bookDetailsVC = BookDetailsViewController.init(nibName: "BookDetailsViewController", bundle: .main)
        bookDetailsVC.bookModelObj = bookModelObj
        bookDetailsVC.modalPresentationStyle = .popover
        
        self.present(bookDetailsVC, animated: true)
        
    }

}


extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksListVM.getNumberOfBooksInList()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookListTableViewCell", for: indexPath) as! BookListTableViewCell
        cell.configureCell(for: booksListVM.getBookItem(at: indexPath), index: indexPath.row)
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentDetailViewControllerFor(bookModelObj: booksListVM.getBookItem(at: indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension ViewController : BookListDelegate {
    
    func isLoading(showLoader: Bool) {
        
        DispatchQueue.main.async {
            if showLoader {
                self.activityIndication.startAnimating()
                self.activityIndication.isHidden = false
            }else {
                self.activityIndication.stopAnimating()
            }

        }
        

        
    }
    
    func didReceiveBookList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailToReceiveBookList(with errorMessage: String) {
        DispatchQueue.main.async {
            
            let alertView = UIAlertController.init(title: "Oops!", message: errorMessage, preferredStyle: .alert)
            let retryAction = UIAlertAction.init(title: "Retry", style: .cancel) { action in
                self.fetchBookListData()
            }
            alertView.addAction(retryAction)
            self.present(alertView, animated: true)
        }
    }
    


}

