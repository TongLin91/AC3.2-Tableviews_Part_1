//
//  Actor.swift
//  Tableviews_Part_1
//
//  Created by Louis Tur on 9/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal struct Actor {
    internal var firstName: String = ""
    internal var lastName: String = ""
    
    init(from data: String) {
        let nameComponets: [String] = data.components(separatedBy: " ")
        
        if let firstName: String = nameComponets.first,
            let lastName: String = nameComponets.last{
            self.firstName = firstName
            self.lastName = lastName
        } else {
            self.firstName = "unset"
            self.lastName = "unset"
        }
    }
}
