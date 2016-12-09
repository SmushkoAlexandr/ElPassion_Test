//
//  InfoView.swift
//  El_Passion_Dev_Assignment
//
//  Created by Alex on 09/12/16.
//  Copyright © 2016 AlexandrSmushko. All rights reserved.
//

import Foundation
import UIKit

class InfoView: UIViewController {
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tbvFollowers: UITableView!
    
    var name: String = ""
    var avatar: String = ""
    var followers: String = ""
    var stars: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = name
        
        let fileUrl = Foundation.URL(string: avatar)
        
        let imgData = NSData(contentsOf:fileUrl!)
        
        if (imgData?.length)! > 0 {
            imgAvatar.image = UIImage(data:imgData as! Data)
        }
    }
}
