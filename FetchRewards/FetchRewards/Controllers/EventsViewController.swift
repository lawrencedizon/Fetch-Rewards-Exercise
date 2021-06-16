//
//  ViewController.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/8/21.
//

import UIKit

///ViewController - allows the user to search for events and display the results into a TableView
class EventsViewController: UIViewController {
    private var networkManager = NetworkManager()
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
                tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
                tableView.translatesAutoresizingMaskIntoConstraints = false
                return tableView
    }()

//MARK: - ViewController Lifecycle
    override func loadView() {
        super.loadView()
        setupUserInterface()
        
        networkManager.fetch(type: .events)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.eventResults = self.networkManager.fetchedEvents
            print("eventResults count: \(self.eventResults.count)")
            
            self.retrieveFavoriteEvents()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        retrieveFavoriteEvents()
        
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
extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as! EventTableViewCell
        cell.likeButton.addTarget(self, action: #selector(likeButtonPressed(sender:)), for: .touchUpInside)
        cell.selectionStyle = .none
        cell.likeButton.tag = indexPath.row
        let eventInfo = eventResults[indexPath.row]
        let dateInfoSplit =  eventInfo.date.components(separatedBy: "T")
        if eventInfo.isFavorite {
            cell.likeButton.setImage(UIImage(named: "heart_fill.png"), for: .normal)
        }else{
            cell.likeButton.setImage(UIImage(named: "heart.png"), for: .normal)
        }
        cell.eventTitleLabel.text = eventInfo.eventTitle
        cell.eventImageView.url(eventInfo.performerImages[0])
        cell.eventLocationLabel.text = "\(eventInfo.city), \(eventInfo.state)"
        cell.eventDateLabel.text = convertDateToString(dateInfoSplit[0])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventDetailVC = EventsDetailViewController()
        eventDetailVC.event = eventResults[indexPath.row]
        navigationController?.pushViewController(eventDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func favoriteButtonPressed(index: Int){
        let event = eventResults[index]
        if !event.isFavorite {
            //favoriting a song
            event.isFavorite = true
            if let storedFavorites = userDefaults.data(forKey: Constants.favorites),
                var favorites = try? decoder.decode([Event].self, from: storedFavorites){
                favorites.append(event)
                
                if let encodedFavorites = try? encoder.encode(favorites) {
                userDefaults.set(encodedFavorites, forKey: Constants.favorites)
                }
            
            }else{
                //no favorites in userdefaults yet
                let favorites = [event]
                if let encodedFavorites = try? encoder.encode(favorites){
                    userDefaults.set(encodedFavorites, forKey: Constants.favorites)
                }
            }
            
        }else{
            event.isFavorite = false
            if let storedFavorites = userDefaults.data(forKey: Constants.favorites),
               var favorites = try? decoder.decode([Event].self, from: storedFavorites){
                favorites.removeAll(where: { $0.eventTitle == event.eventTitle})
                
                if let encodedFavorites = try? encoder.encode(favorites){
                    userDefaults.set(encodedFavorites, forKey: Constants.favorites)
                }
            }
        }
        tableView.reloadData()
    }
    //MARK: - Functions
    @objc func likeButtonPressed(sender: AnyObject){
        favoriteButtonPressed(index: sender.tag)
        if eventResults[sender.tag].isFavorite {
            sender.setImage(UIImage(named: "heart_fill.png"), for: .normal)
        }else{
            sender.setImage(UIImage(named: "heart.png"), for: .normal)
        }
    }
    
    func retrieveFavoriteEvents(){
        if let storedFavorites = userDefaults.data(forKey: Constants.favorites),
           let favorites = try? decoder.decode([Event].self, from: storedFavorites){
            for event in self.eventResults {
                if favorites.contains(where: { $0.eventTitle == event.eventTitle}){
                    event.isFavorite = true
                }
            }
        }
        tableView.reloadData()
    }
}

//MARK: - SearchBar Delegates
extension EventsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        eventResults = self.networkManager.fetchedEvents
        //API Network call
        if let query = searchBar.text?.lowercased()  {
            eventResults = eventResults.filter { $0.eventTitle.lowercased().contains(query)
            }
            DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
            }
        }else{
            print("No text was inputted into the search bar")
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = nil
        eventResults = self.networkManager.fetchedEvents
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}


