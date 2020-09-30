//
//  User.swift
//  VinChat
//
//  Created by Vincent Angelo on 11/06/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let username: String
    let email: String
    let profileImageURL: String
    let fullname: String
    
    init(dictionary: [String:Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
}
