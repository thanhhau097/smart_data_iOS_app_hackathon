//
//  Comment.swift
//  Review
//
//  Created by MAC OS on 8/26/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import Foundation

class Comment {
    var id: String?
    var userImageName: String?
    var username: String?
    var text: String?
    var point: Float?
    var date: String?
    
    init(userImageName: String, username: String, text: String, point: Float?) {
        self.userImageName = userImageName
        self.username = username
        self.text = text
        self.point = point
    }
    
    init() {
        
    }
}
