//
//  RegistrationViewModel.swift
//  VinChat
//
//  Created by Vincent Angelo on 10/06/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

struct RegistrationViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    var username: String?
    var fullname: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
            && username?.isEmpty == false
            && fullname?.isEmpty == false
    }
}
