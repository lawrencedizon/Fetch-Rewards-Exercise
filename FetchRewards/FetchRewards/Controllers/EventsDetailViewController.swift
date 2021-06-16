//
//  EventsDetailViewController.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/11/21.
//

import UIKit
import SafariServices

/// - EventsDetailViewController shows more information about the selected event
class EventsDetailViewController: UIViewController, SFSafariViewControllerDelegate {
//MARK: - Properties
    var event: Event?

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerStackView, bodyStackView, footerStackView])
        stackView.axis = .vertical
        stackView.spacing = 50
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeButton, eventTitleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bodyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventImageView, eventInfoStackView, performersInfoStackView])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buyTicketsButton])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var eventInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ venueAndLocationStackView, dateTimeStackView])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var performersInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ performersTitleLabel, performersLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var venueAndLocationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventVenueLabel, eventLocationLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var dateTimeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventDateLabel, eventTimeLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .trailing
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.url(event?.performerImages[0])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var eventTitleLabel: UILabel = {
        let label = UILabel()
        label.preferredMaxLayoutWidth = 220
        label.font = UIFont(name: "Helvetica-Bold", size: 21)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = event?.eventTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var eventVenueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-bold", size: 15)
        label.text = event?.venueName
        label.preferredMaxLayoutWidth = 200
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var eventLocationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        if let city = event?.city,
           let state = event?.state {
            label.text = "\(city), \(state)"
        }
        return label
    }()
    
    lazy var eventDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        if let date = event?.date {
            label.text = convertDateToString(splitDate(date: date, index: 0))
        }
        return label
    }()
    
    lazy var eventTimeLabel: UILabel = {
        let label = UILabel()
        if let date = event?.date {
            label.text = formatTimeString(time: splitDate(date: date, index: 1))
        }
        label.font = UIFont(name: "Helvetica", size: 15)
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "heart.png")
        button.setImage(buttonImage , for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(likeButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    let buyTicketsButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red: 143/255, green: 0/255, blue: 64/255, alpha: 1.0)
        button.setTitle("Buy Tickets", for: .normal)
        button.addTarget(self, action: #selector(buyTicketsButtonPressed), for: .allTouchEvents)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let performersTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.text = "Performers"
        label.textAlignment = .center
        return label
    }()
    
    lazy var performersLabel: UILabel = {
        let label = UILabel()
        label.preferredMaxLayoutWidth = 220
        label.font = UIFont(name: "Helvetica", size: 15)
        label.text = event?.performerNames[0]
        label.textAlignment = .center
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    

//MARK: - ViewController Lifecycle
    override func loadView() {
        super.loadView()
        configureView()
    }
    
//MARK: - Functions
    func configureView(){
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .white
        view.addSubview(mainStackView)
        checkIfFavorite()
        layoutConstraints()
    }
    
    @objc func buyTicketsButtonPressed(){
        guard let url = event?.ticketURL else { return }
        let safariVC = SFSafariViewController(url: URL(string: url)!)
        safariVC.delegate = self
        navigationController?.present(safariVC, animated: true)
    }
    
    func checkIfFavorite(){
        if event?.isFavorite == true {
            likeButton.setImage(UIImage(named: "heart_fill.png"), for: .normal)
        }else{
            likeButton.setImage(UIImage(named: "heart.png"), for: .normal)
        }
    }
    
    func favoriteButtonPressed(eventInfo: Event){
        let event = eventInfo
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
    }
    
    @objc func likeButtonPressed(sender: UIButton){
        if let event = self.event {
            favoriteButtonPressed(eventInfo: event)
            if event.isFavorite {
                sender.setImage(UIImage(named: "heart_fill.png"), for: .normal)
            }else{
                sender.setImage(UIImage(named: "heart.png"), for: .normal)
            }
        }
    }
    
    //MARK: - AutoLayout
            private func layoutConstraints(){
                var constraints = [NSLayoutConstraint]()
                constraints.append(mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20))
                constraints.append(mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30))
                constraints.append(mainStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
                
                constraints.append(eventImageView.heightAnchor.constraint(equalToConstant: 220))
                constraints.append(eventImageView.widthAnchor.constraint(equalToConstant: 320))
                
                constraints.append(dateTimeStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor))
         
                constraints.append(eventTitleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50))
                constraints.append(eventTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 230))
                
                constraints.append(buyTicketsButton.heightAnchor.constraint(equalToConstant: 40))
                constraints.append(buyTicketsButton.widthAnchor.constraint(equalTo: eventImageView.widthAnchor))
                constraints.append(performersInfoStackView.heightAnchor.constraint(equalToConstant: 60))
                constraints.append(performersInfoStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 220))
                
                constraints.append(likeButton.heightAnchor.constraint(equalToConstant: 30))
                constraints.append(likeButton.widthAnchor.constraint(equalToConstant: 30))
                
                //Activate constraints
                NSLayoutConstraint.activate(constraints)
            }
}
