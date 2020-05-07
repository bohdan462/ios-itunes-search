//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Bohdan Tkachenko on 5/6/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import Foundation


class SearchResultController {
    
    private let baseURL = URL(string: "https://itunes.apple.com/search?")!
    
    var searchResults: [SearchResult] = []
    var dataFromSegmentedController: String = "software"
    
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    
    //    var searchedValue = String(typpedByUser)
 
    
//    enum ResultType: String {
//        case software
//        case musicTrack
//        case movie
//    }
  
    
    
    func performSearch(searchTeam: String, completion: @escaping () -> Void) {
        
        // step 1 build endpoint url with query iteam
        var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryIteam = URLQueryItem(name: "term", value: searchTeam)
        urlComponent?.queryItems = [searchTermQueryIteam]
        
        guard let requestURL = urlComponent?.url else {
            print("request url is nil")
            completion() // calles at the very end...?? //???????
            return
        }
        // step 2 create url request
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        //step 3 create url task
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in //weak self avoid retain sycle ?
            
            //handle error first
            if let error = error {
                print("Error fetchmg data \(error)")
                completion() //we want to call back who is waitnig for this request
                return
            }
            
            guard let self = self else { completion(); return } //self is person controller //????
            
            //handle data optionality
            
            guard let data = data else {
                print("no data return from data task")
                completion()
                return
            }
            //decode data
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            // decode and adding objects into the array
            do {
                let itemSerach = try jsonDecoder.decode(SerachResults.self, from: data)
                self.searchResults.append(contentsOf: itemSerach.results)
            } catch {
                print("Unable to decode data into object of type PersonSearch: \(error)")
            }
            completion()
        }
        //step 4 run url task
        task.resume()
    }
}



