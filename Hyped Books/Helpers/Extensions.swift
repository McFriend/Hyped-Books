//
//  Extensions.swift
//  Hyped Books
//
//  Created by George Sabanov on 01.01.2018.
//  Copyright © 2018 Georgiy Sabanov. All rights reserved.
//

import Foundation
extension String
{
    static func abbreviateNumber(num: NSNumber) -> String {
        // less than 1000, no abbreviation
        if num < 1000 {
            return "\(num)"
        }
        // less than 1 million, abbreviate to thousands
        if num < 1000000 {
            var n = Double(truncating: num);
            n = Double( floor(n/100)/10 )
            return "\(n.description)K"
        }
        // more than 1 million, abbreviate to millions
        var n = Double(truncating: num)
        n = Double( floor(n/100000)/10 )
        return "\(n.description)M"
    }
    static func removingHTMLTags(fromString firstString: String) -> String
    {
        guard let attrStr = try? NSAttributedString(
            data: firstString.data(using: .unicode, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil) else { return "" }
        return attrStr.string
    }
}

