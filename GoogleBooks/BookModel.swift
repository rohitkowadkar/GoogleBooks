//
//  BookModel.swift
//  GoogleBooks
//
//  Created by Rohit Kowadkar on 20/05/25.
//
import Foundation

struct BookModel {
    let imageLinks : Dictionary<String,String>
    let title : String
    let auther: String
    let pageCount : Int
    
}

enum  BookApiError : Error {
    case noData
    case badData
    case badUrl
}

class BooksAPIHandler {
    static let shared = BooksAPIHandler()
    
    //api call
    func getBookListFromGoogleAPI(with completionHandler: @escaping(Result<[BookModel],BookApiError>) -> Void) {
        if let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=jkrowling") {
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else {
                    completionHandler(.failure(.noData))
                    return
                }
                do {
                    let decodedBooksData = try JSONSerialization.jsonObject(with: data, options: [])
                    if let parsedBooksDictionary = decodedBooksData as? Dictionary<String,Any> {
                        let booksArray = self.parseBookItemList(from: parsedBooksDictionary)
                        completionHandler(.success(booksArray))
                    }

                }
                catch {
                    completionHandler(.failure(.badData))
                }
            }

            task.resume()
        }
        else{
            completionHandler(.failure(.badUrl))
        }
    }
    
    func parseBookItemList(from parsedBooksDictionary :  Dictionary<String,Any>) -> [BookModel] {
        
        guard let bookItemsArray = parsedBooksDictionary["items"] as? [Dictionary<String,Any>] else{
            return []
        }
        
        for (_,book) in bookItemsArray.enumerated() {
            var bookModelArray : [BookModel] = []
            if let volumeInfo = book["volumeInfo"] as? Dictionary<String,Any> {
                var title = ""
                var imageLinks : [String : String] = [:]
                var auther = ""
                var pageCount = 0
                
                if let bookTitle = volumeInfo["title"] as? String {
                    title = bookTitle
                }
                
                if let bookImageLinks = volumeInfo["imageLinks"] as? Dictionary<String,String> {
                    imageLinks = bookImageLinks
                }
                
                if let authers = volumeInfo["authors"] as? [String] {
                    if !authers.isEmpty {
                        auther = authers.first ?? ""
                    }                    
                }
                
                if let bookPageCount = volumeInfo["pageCount"] as? Int {
                    pageCount = bookPageCount
                }
                
                bookModelArray.append(BookModel(imageLinks: imageLinks, title: title, auther: auther, pageCount: pageCount))
            }
            return bookModelArray
        }
        
        return []
    }
    
}
