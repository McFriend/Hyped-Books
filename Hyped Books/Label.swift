//
//  Label.swift
//  Hyped Books
//
//  Created by George Sabanov on 01.01.2018.
//  Copyright © 2018 Georgiy Sabanov. All rights reserved.
//

import UIKit

class Label: NSObject {
    var kind: String
    var title: String
    init(kind: String, title: String) {
        self.kind = kind
        self.title = title
    }
}
