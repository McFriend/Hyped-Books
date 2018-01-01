//
//  API_Wrapper.swift
//  Hyped Books
//
//  Created by George Sabanov on 01.01.2018.
//  Copyright © 2018 Georgiy Sabanov. All rights reserved.
//

import UIKit
//MARK: Base

class API_Wrapper: NSObject {
    static var kBaseURLScheme = "https"
    static var kBaseURLHost = "api.bookmate.com"
    static var kBaseURLPath = "/api/v5"
    static var kBooksEndpoint = "/books/popular"
    
    private class func composeHTTPRequestWithParameters (parameters : [URLQueryItem] , endpoint : String ) -> URLRequest
    {
        let components = NSURLComponents()
        components.scheme = kBaseURLScheme
        components.host = kBaseURLHost
        components.path = kBaseURLPath + endpoint
        components.queryItems = parameters
        return URLRequest(url: components.url!)
    }

    class func genericCompletetionHandler ( data : Data? , response : HTTPURLResponse? , error : NSError? ,  success : ( _ jsonResponse : JSON, _ sessionResponse:HTTPURLResponse) -> () , failure : ()-> ()  )
    {
        guard data != nil else { failure(); return }
        
        do{
            let jsonResponse = try JSON(data: data!, options: JSONSerialization.ReadingOptions())
            /* конверсия NSData в JSON для дальнейшего парсинга */
            print("data answer : \(String(describing: NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)))")
            
            print("JSON answer : \(jsonResponse)")
            /* возвращаем результат в success block */
            success ( jsonResponse, response!)
        }
        catch
        {
            failure()
        }
    }
}

//MARK: Methods
extension API_Wrapper
{
    class func getBooks(page: Int, success : @escaping ( _ jsonResponse : JSON, _ sessionResponse:HTTPURLResponse) -> () , failure : @escaping ()-> ()) -> URLSessionDataTask
    {
        var parameters = [URLQueryItem]()
        let pageParameter = URLQueryItem(name: "page", value: "\(page)")
        parameters.append(pageParameter)
        let request = API_Wrapper.composeHTTPRequestWithParameters(parameters: parameters, endpoint: kBooksEndpoint)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            
            API_Wrapper.genericCompletetionHandler(data : data, response: response as? HTTPURLResponse, error: error as NSError?, success: success , failure: failure)
        }
        
        task.resume()
        return task
    }
}
