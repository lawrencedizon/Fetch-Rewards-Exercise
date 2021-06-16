//
//  CustomTableViewCell.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/8/21.
//

import UIKit

/// - EventTableViewCell manages the EventViewController's TableView cell
class EventTableViewCell: UITableViewCell {
    static let identifier: String = "EventTableViewCell"
    
//MARK: - Properties
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventImageView, eventLabelsStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var eventLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventTitleLabel, eventLocationAndDateStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var eventLocationAndDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventLocationLabel, eventDateLabel, likeButton])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fill
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
        let label = UILabel()
        label.textAlignment = .center
        label.preferredMaxLayoutWidth = 200
        label.font = UIFont(name: "Helvetica-Bold", size: 21)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let eventLocationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
     
        return label
    }()
    
    let eventDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "heart.png")
        button.setImage(buttonImage , for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
//MARK: - View LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(mainStackView)
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - AutoLayout
    private func layoutConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(mainStackView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 30))
        constraints.append(mainStackView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor))
        
        constraints.append(mainStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor))
        constraints.append(mainStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor))
      
        constraints.append(eventImageView.heightAnchor.constraint(equalToConstant: 125))
        constraints.append(eventImageView.widthAnchor.constraint(equalToConstant: 125))
        
        constraints.append(likeButton.heightAnchor.constraint(equalToConstant: 20))
        constraints.append(likeButton.widthAnchor.constraint(equalToConstant: 20))
        
        //Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
}
