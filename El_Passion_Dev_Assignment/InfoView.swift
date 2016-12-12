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
    //var num: Int = 0
   // var count: Int = 0
    var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoRequest()
        starredRequest()
        
    }
    
    func userInfoRequest()
    {
        Alamofire.request("https://api.github.com/users/" + name).responseJSON {
            response in
            if let JSON = response.result.value {
                print("JSON:  \(JSON)")
                let response = JSON as! NSDictionary
                self.loadAvatar(url: (response.object(forKey: "avatar_url") as? String)!)
                self.lblFoll.text = "Followers: " + String(describing: response.object(forKey: "followers") as! Int)
                self.lblName.text = response.object(forKey: "login") as? String
            }
        }
    }
    
    func starredRequest()
    {
        //repeat{
            Alamofire.request("https://api.github.com/users/" + name + "/starred?per_page=100&page=" + String(self.page)).responseJSON {
                response in
                if let JSON = response.result.value {
                    let response = JSON as! NSArray
                    //self.count = response.count
                    //self.num = self.num + self.count
                    self.lblStars.text = "Starred: " + String(response.count)
                }
            }
            //self.page += 1
        //}
            //while count != 5
    }
    
    func loadAvatar(url: String){
        let fileUrl = Foundation.URL(string: url)
        let imgData = NSData(contentsOf:fileUrl!)
        if (imgData?.length)! > 0 {
        imgAvatar.image = UIImage(data:imgData as! Data)
     }
    }
}

