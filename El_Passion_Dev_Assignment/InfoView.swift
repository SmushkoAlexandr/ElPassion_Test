//
//  InfoView.swift
//  El_Passion_Dev_Assignment
//
//  Created by Alex on 09/12/16.
//  Copyright © 2016 AlexandrSmushko. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class InfoView: UIViewController {
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFoll: UILabel!
    @IBOutlet weak var lblStars: UILabel!
    
    var name: String = ""
    var stars: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followersRequest()
    }
    
    func followersRequest()
    {
        Alamofire.request("https://api.github.com/users/" + name).responseJSON {
            responce in
            if let JSON = responce.result.value {
                let response = JSON as! NSDictionary
                self.loadAvatar(url: (response.object(forKey: "avatar_url") as? String)!)
                self.lblFoll.text = "Followers: " + String(describing: response.object(forKey: "followers") as! Int)
                self.lblName.text = response.object(forKey: "login") as? String
            }
        }
    }
    
    func loadAvatar(url: String){
        let fileUrl = Foundation.URL(string: url)
        let imgData = NSData(contentsOf:fileUrl!)
        if (imgData?.length)! > 0 {
        imgAvatar.image = UIImage(data:imgData as! Data)
     }
    }
}

