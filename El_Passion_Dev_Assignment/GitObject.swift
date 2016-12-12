//
//  GitObject.swift
//  El_Passion_Dev_Assignment
//
//  Created by Alex on 12/12/16.
//  Copyright © 2016 AlexandrSmushko. All rights reserved.
//

import Foundation

class GitObject {
    
    var NAME = ""
    var ID = 0
    var USER = true
    
    init(login:String, id: Int){
        self.NAME = login
        self.ID = id
        self.USER = true
    }
    
    init(title:String,id:Int) {
        self.NAME = title
        self.ID = id
        self.USER = false
    }
    
}
