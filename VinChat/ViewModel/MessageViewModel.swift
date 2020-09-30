//
//  MessageViewModel.swift
//  VinChat
//
//  Created by Vincent Angelo on 12/06/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation
import UIKit

struct MessageViewModel {
    
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? .lightGray : .systemBlue
    }
    
    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .black : .white
    }
    
    init(message: Message) {
        self.message = message
    }
    
    var rightAnchorActive: Bool {
        return message.isFromCurrentUser
    }
    
    var leftAnchorActive: Bool {
        return !message.isFromCurrentUser
    }
    
    var shouldHideProfileImage: Bool {
        return message.isFromCurrentUser
    }
    
    var profileImageURL: URL? {
        guard let user = message.user else { return nil }
        
        return URL(string: user.profileImageURL)
    }
    
    
}
