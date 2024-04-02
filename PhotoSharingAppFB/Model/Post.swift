//
//  Post.swift
//  PhotoSharingAppFB
//
//  Created by Cihan on 25.01.2024.
//

import Foundation

class Post {
    var email:String
    var comment:String
    var imageUrl:String
    
    init(email: String, comment: String, imageUrl: String) {
        self.email = email
        self.comment = comment
        self.imageUrl = imageUrl
    }
}
