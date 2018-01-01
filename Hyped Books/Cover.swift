//
//  Cover.swift
//  Hyped Books
//
//  Created by George Sabanov on 01.01.2018.
//  Copyright © 2018 Georgiy Sabanov. All rights reserved.
//

import UIKit

class Cover: NSObject {
    var small: URL?
    var large: URL?
    var placeholder: String
    var ratio: Double
    
    init(small: URL?, large: URL?, placeholder: String, ratio: Double) {
        self.small = small
        self.large = large
        self.placeholder = placeholder
        self.ratio = ratio
    }
}
