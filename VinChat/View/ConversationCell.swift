//
//  ConversationCell.swift
//  VinChat
//
//  Created by Vincent Angelo on 12/06/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit
import SDWebImage

class ConversationCell: UITableViewCell {
    
    // MARK: - Properties
    
    var conversation: Conversation? {
        didSet {
            configure()
        }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .systemBlue
        iv.tintColor = .white
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Username Test"
        
        return label
    }()
    
    lazy var messageTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        
        
        return label
    }()
    
    lazy var timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, paddingLeft: 12)
        profileImageView.setDimensions(height: 50, width: 50)
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.centerY(inView: self)
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, messageTextLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 16)
        
        addSubview(timestampLabel)
        timestampLabel.anchor(top: topAnchor, right:rightAnchor, paddingTop: 20, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Helpers
    
    func configure(){
        guard let conversation = conversation else { return }
        let viewModel = ConversationViewModel(conversation: conversation)
        
        usernameLabel.text = viewModel.username
        messageTextLabel.text = viewModel.lastMessage
        
        timestampLabel.text = viewModel.timestamp
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
    }
}
