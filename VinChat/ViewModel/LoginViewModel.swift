//
//  LoginViewModel.swift
//  VinChat
//
//  Created by Vincent Angelo on 10/06/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

protocol AuthenticationProtocol {
    var formIsValid: Bool { get }
}

struct LoginViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
