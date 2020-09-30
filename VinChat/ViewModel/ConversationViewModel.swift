//
//  ConversationViewModel.swift
//  VinChat
//
//  Created by Vincent Angelo on 12/06/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

struct ConversationViewModel {
    
    private let conversation: Conversation
    
    var profileImageURL: URL? {
        return URL(string: conversation.user.profileImageURL)
    }
    
    var timestamp: String {
        let date = conversation.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    var username: String {
        return conversation.user.username
    }
    
    var lastMessage: String {
        return conversation.message.text
    }
    
    init(conversation: Conversation) {
        self.conversation = conversation
    }
}
