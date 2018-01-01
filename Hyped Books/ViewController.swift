//
//  ViewController.swift
//  Hyped Books
//
//  Created by George Sabanov on 01.01.2018.
//  Copyright © 2018 Georgiy Sabanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FeedManager.getBooks(page: 0, success: { (books) in
            
        }) { (failureString) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

