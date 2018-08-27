//
//  Place.swift
//  Review
//
//  Created by MAC OS on 8/27/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import Foundation

class Place {
    var id: String!
    var name: String?
    var address: String?
    var phoneNumber: String?
    var type: String?
    var lat: Double?
    var lng: Double?
    var photoUrl: String?
    var rate: Float?
    var website: String?
    var comments: [Comment]?
    
    init(id: String, name: String, address: String, phoneNumber: String, type: String) {
        self.id = id
        self.name = name
        self.address = address
        self.phoneNumber = phoneNumber
        self.type = type
    }
    
    init() {
        
    }
}

enum PlaceType {
    case Restaurant
    case Coffee
    case None
}
