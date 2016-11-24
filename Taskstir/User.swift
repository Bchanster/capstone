//
//  User.swift
//  Taskstir
//
//  Created by Sothy Chan on 11/23/16.
//  Copyright © 2016 Foodstir. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var id: Int64
    var email: String
    var firstName: String
    var lastName: String
    var password: String
    
    init(id: Int64, email: String, firstName: String, lastName: String, password: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
    }
    
}
