//
//  BooksListViewModel.swift
//  GoogleBooks
//
//  Created by Rohit Kowadkar on 20/05/25.
//
import UIKit

protocol BookListDelegate : AnyObject {
    
    func didReceiveBookList()
    func didFailToReceiveBookList(with errorMessage:String)
    func isLoading(showLoader: Bool)
    
}

class BooksListViewModel {
    private let apiHandler = BooksAPIHandler.shared
    private(set) var bookListArray : [BookModel] = []
    weak var delegates : BookListDelegate?
    init() {
    }
    
    func getInitialBookList() {
        self.delegates?.isLoading(showLoader: true)
        apiHandler.getBookListFromGoogleAPI { result in
            self.delegates?.isLoading(showLoader: false)
            switch result {
                
            case .success(let books):
                self.bookListArray = books
                self.delegates?.didReceiveBookList()
            case .failure(let error):
                //TODO: parse error
                self.delegates?.didFailToReceiveBookList(with: "")
            }
        }
    }
    
    func getNumberOfBooksInList() -> Int {
        return bookListArray.count
    }
    
    
    func getBookItem(at index:IndexPath) -> BookModel {
        return bookListArray[index.row]
    }
    
}
