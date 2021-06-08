//
//  ViewController.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/8/21.
//

import UIKit

///ViewController - allows the user to search for events and display the results into a TableView
class ViewController: UIViewController {

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.searchBarStyle = UISearchBar.Style.minimal
            searchBar.placeholder = "Search events"
            searchBar.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
            let tableView = UITableView()
                tableView.delegate = self
                tableView.dataSource = self
                tableView.keyboardDismissMode = .onDrag
                //tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
                
                tableView.backgroundColor = .black
                tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
                tableView.translatesAutoresizingMaskIntoConstraints = false
                return tableView
        }()

//MARK: - ViewController Lifecycle
       override func loadView() {
            super.loadView()
            print("View controller loaded")
    }
}

//MARK: - TableView Delegates
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            0
    }
}

//MARK: - SearchBar Delegates
extension ViewController: UISearchBarDelegate {
  
}

