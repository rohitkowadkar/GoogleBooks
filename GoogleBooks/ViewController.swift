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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialiseViews()
        initialiseViewModel()
        
    }
    
    func initialiseViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BookListTableViewCell", bundle: .main), forCellReuseIdentifier: "BookListTableViewCell")
    }
    

    func initialiseViewModel() {
        
    }

}


extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksListVM.getNumberOfBooksInList()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookListTableViewCell", for: indexPath) as! BookListTableViewCell
        
        return cell
    }
    

    
    
    
}

