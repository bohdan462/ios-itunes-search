//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Bohdan Tkachenko on 5/7/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var iTunesSegmentedController: UISegmentedControl!
    
    
    var searchResultsController = SearchResultController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    @IBAction func segmentedControllerTapped(_ sender: Any) {
        switch iTunesSegmentedController.selectedSegmentIndex {
        case 0: searchResultsController.dataFromSegmentedController = ResultType.software.rawValue ;
        case 1: searchResultsController.dataFromSegmentedController = ResultType.movie.rawValue ;
        case 2: searchResultsController.dataFromSegmentedController = ResultType.musicTrack.rawValue ;
        default: break;
        }
        print(iTunesSegmentedController.selectedSegmentIndex)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultsController.searchResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath) as? ResultsTableViewCell else { fatalError() }
        let searchedItem = searchResultsController.searchResults[indexPath.row]
        cell.searchResults = searchedItem
        
        return cell
    }
    
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchIteam = searchBar.text else { return }
        searchBar.resignFirstResponder()
        self.searchResultsController.performSearch(searchTeam: searchIteam) {
            
            // code to be run when search is finished
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

