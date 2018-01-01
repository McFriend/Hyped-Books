//
//  Book.swift
//  Hyped Books
//
//  Created by George Sabanov on 01.01.2018.
//  Copyright © 2018 Georgiy Sabanov. All rights reserved.
//

import UIKit

class Book: NSObject {
    var labels: [Label]
    var inLibrary: Bool
    var authors: String
    var readersCount: Int
    var language: String
    var uuid: String
    var impressionsCount: Int
    var paperPages: Int
    var authorsArray: [Author]
    var inWishlist: Bool
    var bookshelvesCount: Int
    var title: String
    var quotesCount: Int
    var annotation: String
    var canBeRead: Bool
    var cover: Cover
    
    init(labels: [Label], inLibrary: Bool, authors: String, readersCount: Int, language: String, uuid: String, impressionsCount: Int, paperPages: Int, authorsArray: [Author], inWishlist: Bool, bookshelvesCount: Int, title: String, quotesCount: Int, annotation: String, canBeRead: Bool, cover: Cover) {
        self.labels = labels
        self.inLibrary = inLibrary
        self.authors = authors
        self.readersCount = readersCount
        self.language = language
        self.uuid = uuid
        self.impressionsCount = impressionsCount
        self.paperPages = paperPages
        self.authorsArray = authorsArray
        self.inWishlist = inWishlist
        self.bookshelvesCount = bookshelvesCount
        self.title = title
        self.quotesCount = quotesCount
        self.annotation = annotation
        self.canBeRead = canBeRead
        self.cover = cover
    }
}
