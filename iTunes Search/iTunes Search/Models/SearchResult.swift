//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Bohdan Tkachenko on 5/6/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SerachResults: Codable {
    let results: [SearchResult]
}



//Set up the HTTP request with URLSession

//Make the request with URLSessionDataTask
//Quickly print the returned response data
//Properly validate the response data
//Convert the response data to JSON


