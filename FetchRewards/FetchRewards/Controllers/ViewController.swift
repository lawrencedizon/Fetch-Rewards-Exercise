//
//  ViewController.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/8/21.
//

import UIKit

///ViewController - allows the user to search for events and display the results into a TableView
class ViewController: UIViewController {
    var testData = [String]()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.searchBarStyle = UISearchBar.Style.minimal
            searchBar.placeholder = "Search events"
            searchBar.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            searchBar.showsCancelButton = true
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
            let tableView = UITableView()
                tableView.delegate = self
                tableView.dataSource = self
                tableView.keyboardDismissMode = .onDrag
                tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
                tableView.translatesAutoresizingMaskIntoConstraints = false
                return tableView
    }()
    
    private func layoutConstraints(){
        var constraints = [NSLayoutConstraint]()
        //SearchBar
        //TableView
        constraints.append(tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor))
        constraints.append(tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor))
        constraints.append(tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
     
        //Activate constraints
        NSLayoutConstraint.activate(constraints)
    }

//MARK: - ViewController Lifecycle
       override func loadView() {
        super.loadView()
        
        for num in 0...99 {
            testData.append("Data \(num)")
        }
        setupUserInterface()
        print("View controller loaded")
    }
    
//MARK: - User Interface
    private func setupUserInterface(){
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        navigationItem.titleView = searchBar
        layoutConstraints()
    }
}

//MARK: - TableView Delegates
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.textLabel?.text = testData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

//MARK: - SearchBar Delegates
extension ViewController: UISearchBarDelegate {
}

