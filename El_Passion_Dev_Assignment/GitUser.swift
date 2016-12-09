//
//  GitUser.swift
//  El_Passion_Dev_Assignment
//
//  Created by Alex on 09/12/16.
//  Copyright © 2016 AlexandrSmushko. All rights reserved.
//

import Foundation

class GitUser {
    
    var NAME = ""
    var ID = 0
    var AVATAR = ""
    var FOLLOWERS = ""
    var STARRED = ""
    
    init(login:String, id: Int, avatarurl: String, followersurl: String, starredurl: String){
        self.NAME = login
        self.ID = id
        self.AVATAR = avatarurl
        self.FOLLOWERS = followersurl
        self.STARRED = starredurl
    }
    
}
