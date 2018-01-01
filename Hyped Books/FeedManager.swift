//
//  FeedManager.swift
//  Hyped Books
//
//  Created by George Sabanov on 01.01.2018.
//  Copyright © 2018 Georgiy Sabanov. All rights reserved.
//

import UIKit

class FeedManager: NSObject {
    static var feedOperationQueue = OperationQueue()
    
    class func getBooks(page : Int, success:@escaping ((_ posts : [Book]) -> ()), failure:@escaping ((_ errorMessage: String) -> ()))
    {
        feedOperationQueue.cancelAllOperations()
        let operation = BooksOperation(page: page, success: success, failure: failure)
        operation.qualityOfService = .userInitiated
        
        feedOperationQueue.addOperation(operation)
    }
}
