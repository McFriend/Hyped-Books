//
//  Author.swift
//  Hyped Books
//
//  Created by George Sabanov on 01.01.2018.
//  Copyright © 2018 Georgiy Sabanov. All rights reserved.
//

import UIKit

class Author: NSObject {
    var worksCount: Int
    var name: String
    var uuid: String
    var locale: String

    init(worksCount: Int, name: String, uuid: String, locale: String) {
        self.worksCount = worksCount
        self.name = name
        self.uuid = uuid
        self.locale = locale
    }
}
