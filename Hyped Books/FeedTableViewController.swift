//
//  FeedTableViewController.swift
//  Hyped Books
//
//  Created by George Sabanov on 02.01.2018.
//  Copyright © 2018 Georgiy Sabanov. All rights reserved.
//

import UIKit
import SafariServices

class FeedTableViewController: UITableViewController {
    var books = [Book]()
    var nextPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNewPage()
    }
    
    func loadNewPage()
    {
        FeedManager.getBooks(page: nextPage, success: { [weak self] (books) in
            DispatchQueue.main.async {
                self?.books.append(contentsOf: books)
                self?.tableView.reloadData()
                self?.nextPage += 1
            }
        }) { [weak self] (failureMessage) in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: failureMessage)
            }
        }
    }
    
    func showErrorAlert(message: String)
    {
        let alert = UIAlertController(title: "Произошла ошибка", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == books.count - 1)
        {
            self.loadNewPage()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        let book = self.books[indexPath.row]
        cell.authorLabel.text = book.authors
        cell.titleLabel.text = book.title
        cell.typeLabel.text = book.labels.first?.title ?? "Стандарт"
        cell.annotationLabel.text = String.removingHTMLTags(fromString: book.annotation).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        cell.coverImageView.sd_setImage(with: book.cover.small, completed: nil)
        cell.readersLabel.text = String.abbreviateNumber(num: NSNumber(value: book.readersCount))
        cell.quotesLabel.text = String.abbreviateNumber(num: NSNumber(value: book.quotesCount))
        cell.impressionsLabel.text = String.abbreviateNumber(num: NSNumber(value: book.impressionsCount))
        cell.bookshelvesLabel.text = String.abbreviateNumber(num: NSNumber(value: book.bookshelvesCount))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let book = self.books[indexPath.row]
        let svc = SFSafariViewController(url: API_Wrapper.bookURL(uuid: book.uuid))
        self.present(svc, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat 
    {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat 
    {
        return 165
    }
}
