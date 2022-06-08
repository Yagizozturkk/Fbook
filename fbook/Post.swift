//
//  Post.swift
//  fbook
//
//  Created by Yagiz Ozturk on 8.06.2022.
//

import Foundation

class Posts {
    var email : String
    var comment : String
    var imageUrl : String
    
    init(email : String,comment : String, imageUrl : String) {
        self.email = email
        self.comment = comment
        self.imageUrl = imageUrl
    }
}
