//
//  ViewController.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/8/21.
//

import UIKit

///ViewController - allows the user to search for events and display the results into a TableView
class ViewController: UIViewController {
    private var eventResults = [Event]()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.searchBarStyle = UISearchBar.Style.minimal
            searchBar.placeholder = "Search events"
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: UIControl.State.normal)
            searchBar.showsCancelButton = true
        
            if #available(iOS 13.0, *) {
                searchBar.searchTextField.leftView?.tintColor = .white
                searchBar.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            } else {
            //TODO: - For versions below 13.0 make the searchBar design in white tint
            }
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
            let tableView = UITableView()
                tableView.delegate = self
                tableView.dataSource = self
                tableView.keyboardDismissMode = .onDrag
                tableView.showsVerticalScrollIndicator = false
                tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
                tableView.translatesAutoresizingMaskIntoConstraints = false
                return tableView
    }()

//MARK: - ViewController Lifecycle
    override func loadView() {
        super.loadView()
        setupUserInterface()
        
        let networkManager = NetworkManager()
        networkManager.fetch(type: .events)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.eventResults = networkManager.fetchedEvents
            print("eventResults count: \(self.eventResults.count)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.rowHeight = 200
    }
    
//MARK: - User Interface
    private func setupUserInterface(){
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        navigationItem.titleView = searchBar
        layoutConstraints()
    }
//MARK: - AutoLayout
    private func layoutConstraints(){
        var constraints = [NSLayoutConstraint]()

        //TableView
        constraints.append(tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor))
        constraints.append(tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor))
        constraints.append(tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
     
        //Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
}

//MARK: - TableView Delegates
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.selectionStyle = .none
        let eventInfo = eventResults[indexPath.row]
        
        cell.eventTitleLabel.text = eventInfo.name
        //FIXME: - Retrieve image
        cell.eventImageView.image = UIImage(named: "testImage.jpg")
        cell.eventLocationLabel.text = "\(eventInfo.city), \(eventInfo.state)"
        cell.eventDateLabel.text = "\(eventInfo.date)"
        //FIXME: - Placeholder time
        cell.eventTimeLabel.text = "Placeholder time"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

//MARK: - SearchBar Delegates
extension ViewController: UISearchBarDelegate {
}
