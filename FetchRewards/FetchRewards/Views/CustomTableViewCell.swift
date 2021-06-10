//
//  CustomTableViewCell.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/8/21.
//

import UIKit

/// - CustomTableViewCell manages the ViewController's tableView cell
class CustomTableViewCell: UITableViewCell {
    static let identifier: String = "CustomTableViewCell"
    
    //MARK: - Properties
    lazy var eventLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventTitleLabel,eventLocationLabel, eventDateAndTimeStackView])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .top
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var eventDateAndTimeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventDateLabel, eventTimeLabel])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .top
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let eventTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.preferredMaxLayoutWidth = 220
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 21)
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let eventLocationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.font = UIFont(name: "Helvetica", size: 15)
        return locationLabel
    }()
    
    let eventDateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .gray
        dateLabel.font = UIFont(name: "Helvetica", size: 15)
        return dateLabel
    }()
    
    let eventTimeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = .gray
        timeLabel.font = UIFont(name: "Helvetica", size: 15)
        return timeLabel
    }()
    
    //MARK: - View LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(eventImageView)
        contentView.addSubview(eventLabelsStackView)
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AutoLayout
    private func layoutConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        //eventImageView
        constraints.append(eventImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30 ))
        constraints.append(eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20))
        constraints.append(eventImageView.heightAnchor.constraint(equalToConstant: 100))
        constraints.append(eventImageView.widthAnchor.constraint(equalToConstant: 100))
        
        //eventLabels StackView
        constraints.append(eventLabelsStackView.leftAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: 20))
        constraints.append(eventLocationLabel.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor))
        constraints.append(eventLabelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20))
        constraints.append(eventTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 220))
        
        //Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
}
