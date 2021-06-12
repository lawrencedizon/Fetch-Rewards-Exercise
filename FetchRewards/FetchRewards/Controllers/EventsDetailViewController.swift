//
//  EventsDetailViewController.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/11/21.
//

import UIKit

class EventsDetailViewController: UIViewController {
    
    //MARK: - Properties
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventTitleLabel, eventImageView,eventInfoStackView])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var eventInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ venueAndLocationStackView, dateTimeStackView])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .leading
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
    
    let likeButton: UIButton = {
        let button = UIButton()
        if #available(iOS 13.0, *) {
            button.imageView?.image = UIImage(systemName: "heart")
        } else {
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        dateLabel.textColor = .gray
        dateLabel.font = UIFont(name: "Helvetica", size: 15)
        dateLabel.text = "June 11, 2021"
        return dateLabel
        
    }()
    
    let eventTimeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = .gray
        timeLabel.text = "9:00 AM"
        timeLabel.font = UIFont(name: "Helvetica", size: 15)
        return timeLabel
    }()
    
    //MARK: - AutoLayout
        private func layoutConstraints(){
            var constraints = [NSLayoutConstraint]()
            constraints.append(mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20))
            constraints.append(mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor))
            constraints.append(mainStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
            
            constraints.append(eventImageView.heightAnchor.constraint(equalToConstant: 260))
            constraints.append(eventImageView.widthAnchor.constraint(equalToConstant: 320))
            
            constraints.append(dateTimeStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor))
     
            constraints.append(eventTitleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50))
            constraints.append(eventTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 220))
            
            //Activate constraints
            NSLayoutConstraint.activate(constraints)
        }
    
    override func loadView() {
        super.loadView()
        print("Viewloaded")
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .white
        view.addSubview(eventTitleLabel)
        view.addSubview(mainStackView)
        layoutConstraints()
        
    }

}
