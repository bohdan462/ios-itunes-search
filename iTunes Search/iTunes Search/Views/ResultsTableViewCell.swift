//
//  ResultsTableViewCell.swift
//  iTunes Search
//
//  Created by Bohdan Tkachenko on 5/7/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    @IBOutlet var titleName: UILabel!
    @IBOutlet var subtitleName: UILabel!
    
    var searchResults: SearchResult? {
        didSet{
            updateViews()
        }
    }
    
    
    
    private func updateViews() {
        guard let searchedResultes = searchResults else { return }
        
        titleName.text = searchedResultes.title
        subtitleName.text = searchedResultes.creator
    }
}
