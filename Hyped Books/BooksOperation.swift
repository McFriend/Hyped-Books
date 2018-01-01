//
//  BooksOperationQueue.swift
//  Hyped Books
//
//  Created by George Sabanov on 01.01.2018.
//  Copyright © 2018 Georgiy Sabanov. All rights reserved.
//

import UIKit

class BooksOperation: Operation {
    var task : URLSessionDataTask?
    let semaphore = DispatchSemaphore(value: 0)
    var page : Int
    var success : ((_ books : [Book]) -> ())
    var failure : ((_ errorMessage: String) -> ())
    
    init(page: Int, success:@escaping ((_ books : [Book]) -> ()), failure:@escaping ((_ errorMessage: String) -> ()))
    {

        self.page = page
        self.success = success
        self.failure = failure
    }
    
    override func cancel() {
        super.cancel()
        task?.cancel()
        semaphore.signal()
    }
    
    override func main() -> Void
    {
        task = API_Wrapper.getBooks(page: page, success: { (jsonResponse, urlResponse) in
            let statusCode = urlResponse.statusCode
            if(statusCode == 200)
            {
                var books = [Book]()
                let booksJSON = jsonResponse["books"].arrayValue
                for book in booksJSON
                {
                    var labels = [Label]()
                    for labelJSON in book["labels"].arrayValue
                    {
                        let labelObject = Label(kind: labelJSON["kind"].stringValue, title: labelJSON["title"].stringValue)
                        labels.append(labelObject)
                    }
                    let inLibrary = book["in_library"].boolValue
                    let authors = book["authors"].stringValue
                    let readersCount = book["readers_count"].intValue
                    let language = book["language"].stringValue
                    let uuid = book["uuid"].stringValue
                    let impressionsCount = book["impressions_count"].intValue
                    let paperPages = book["paper_pages"].intValue
                    var authorsObjects = [Author]()
                    for authorJSON in book["authors_objects"].arrayValue
                    {
                        let worksCount = authorJSON["works_count"].intValue
                        let name = authorJSON["name"].stringValue
                        let authorUUID = authorJSON["uuid"].stringValue
                        let locale = authorJSON["locale"].stringValue
                        let authorObject = Author(worksCount: worksCount, name: name, uuid: authorUUID, locale: locale)
                        authorsObjects.append(authorObject)
                    }
                    let inWishlist = book["in_wishlist"].boolValue
                    let bookshelvesCount = book["bookshelves_count"].intValue
                    let title = book["title"].stringValue
                    let quotesCount = book["quotes_count"].intValue
                    let annotation = book["annotation"].stringValue
                    let canBeRead = book["can_be_read"].boolValue
                    let coverJSON = book["cover"]
                    let smallCover = coverJSON["small"].stringValue
                    let ratioCover = coverJSON["ratio"].doubleValue
                    let placeholderCover = coverJSON["placeholder"].stringValue
                    let largeCover = coverJSON["large"].stringValue
                    let cover = Cover(small: URL(string: smallCover), large: URL(string: largeCover), placeholder: placeholderCover, ratio: ratioCover)
                    
                    let bookObject = Book(labels: labels, inLibrary: inLibrary, authors: authors, readersCount: readersCount, language: language, uuid: uuid, impressionsCount: impressionsCount, paperPages: paperPages, authorsArray: authorsObjects, inWishlist: inWishlist, bookshelvesCount: bookshelvesCount, title: title, quotesCount: quotesCount, annotation: annotation, canBeRead: canBeRead, cover: cover)
                    books.append(bookObject)
                }
                
                
                guard !self.isCancelled else
                {
                    self.semaphore.signal()
                    return
                }
                self.success(books)
                self.semaphore.signal()
            }
            else
            {
                guard !self.isCancelled else
                {
                    self.semaphore.signal()
                    return
                }
                
                self.failure("Error \(statusCode)")
                self.semaphore.signal()
            }
        }, failure: { 
            guard !self.isCancelled else
            {
                self.semaphore.signal()
                return
            }
            self.failure("Operation failed")
            self.semaphore.signal()
        })        
        _ = self.semaphore.wait(timeout: DispatchTime.distantFuture)
    }
    
    
}
