//
//  EventsDetailViewController.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/11/21.
//

import UIKit
import SafariServices

class EventsDetailViewController: UIViewController, SFSafariViewControllerDelegate {
    
    //MARK: - Properties
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

    let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "testImage.jpg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let eventTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.preferredMaxLayoutWidth = 220
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 21)
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = "Washington Football Team at Dallas Cowboys"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    let eventVenueLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.font = UIFont(name: "Helvetica", size: 15)
        locationLabel.text = "Budweiser Events Center"
        return locationLabel
    }()
    
    let eventLocationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.font = UIFont(name: "Helvetica", size: 15)
        locationLabel.text = "LA, CA"
        return locationLabel
    }()
    
    let eventDateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont(name: "Helvetica", size: 15)
        dateLabel.text = "June 11, 2021"
        return dateLabel
        
    }()
    
    let eventTimeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "9:00 AM"
        timeLabel.font = UIFont(name: "Helvetica", size: 15)
        return timeLabel
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "heart.png")
        button.setImage(buttonImage , for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    let performersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        label.text = "Fort Wayne Komets, Wichita Thunder"
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - AutoLayout
        private func layoutConstraints(){
            var constraints = [NSLayoutConstraint]()
            constraints.append(mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20))
            constraints.append(mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50))
            constraints.append(mainStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
            
            constraints.append(eventImageView.heightAnchor.constraint(equalToConstant: 260))
            constraints.append(eventImageView.widthAnchor.constraint(equalToConstant: 320))
            
            constraints.append(dateTimeStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor))
     
            constraints.append(eventTitleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50))
            constraints.append(eventTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 220))
            
            constraints.append(buyTicketsButton.heightAnchor.constraint(equalToConstant: 50))
            constraints.append(buyTicketsButton.widthAnchor.constraint(equalTo: eventImageView.widthAnchor))
            
            constraints.append(likeButton.heightAnchor.constraint(equalToConstant: 30))
            constraints.append(likeButton.widthAnchor.constraint(equalToConstant: 30))
            
            //Activate constraints
            NSLayoutConstraint.activate(constraints)
        }
    
    override func loadView() {
        super.loadView()
        print("Viewloaded")
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .white
        view.addSubview(mainStackView)
        layoutConstraints()
        
    }

    @objc func buyTicketsButtonPressed(){
        let url = "https://seatgeek.com/joe-rogan-tickets/comedy/2021-06-09-8-pm/5420211"
        let safariVC = SFSafariViewController(url: URL(string: url)!)
        safariVC.delegate = self
        navigationController?.present(safariVC, animated: true)
    }
}
