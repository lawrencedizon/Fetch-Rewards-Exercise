//
//  CustomTableViewCell.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/8/21.
//

import UIKit

/// - CustomTableViewCell manages the ViewController's tableView cell
class EventTableViewCell: UITableViewCell {
    static let identifier: String = "EventTableViewCell"
    
    //MARK: - Properties
    lazy var eventLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventTitleLabel, eventLocationAndDateStackView])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var eventLocationAndDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventLocationLabel, eventDateLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
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
        constraints.append(eventImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 45 ))
        constraints.append(eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45))
        constraints.append(eventImageView.heightAnchor.constraint(equalToConstant: 100))
        constraints.append(eventImageView.widthAnchor.constraint(equalToConstant: 100))
        
        //eventLabels StackView
        constraints.append(eventLabelsStackView.leftAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: 20))
        constraints.append(eventLocationLabel.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor))
        constraints.append(eventLabelsStackView.topAnchor.constraint(equalTo: eventImageView.topAnchor))
        
        constraints.append(eventTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200))
        
        //Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
}
