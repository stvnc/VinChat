//
//  ProfileFooterView.swift
//  VinChat
//
//  Created by Vincent Angelo on 13/06/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit


protocol ProfileFooterDelegate: class {
    func handleLogout()
}
class ProfileFooterView: UIView {
    
    // MARK: - Properties
    weak var delegate: ProfileFooterDelegate?
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoutButton)
        logoutButton.anchor(left: leftAnchor, right:rightAnchor, paddingLeft: 32, paddingRight: 32)
        logoutButton.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleLogout() {
        delegate?.handleLogout()
    }
}
