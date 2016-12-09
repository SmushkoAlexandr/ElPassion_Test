//
//  MainView.swift
//  El_Passion_Dev_Assignment
//
//  Created by Alex on 09/12/16.
//  Copyright © 2016 AlexandrSmushko. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class MainView: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var mTableView: UITableView!
    var searchBar = UISearchBar()
    
    var items: [GitUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        mTableView.delegate = self
        self.mTableView.dataSource = self
        
        createSearchBar()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func createSearchBar() -> Void {
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Type to find"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text != ""){
            createRequest(query: searchBar.text!)
        }else{
            items = []
            self.mTableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: true)
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row].NAME
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        print(items[indexPath.row].ID)
        self.performSegue(withIdentifier: "InfoViewSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "InfoViewSegue"){
            let infoVc = segue.destination as! InfoView
            
           let ind = mTableView.indexPathForSelectedRow?.row
            //(mTableView.indexPathForSelectedRow?.row)!
            //infoVc.lblName.text = items[ind!].NAME
            infoVc.name = items[ind!].NAME
            infoVc.avatar = items[ind!].AVATAR
            infoVc.followers = items[ind!].FOLLOWERS
            infoVc.stars = items[ind!].STARRED
        }
    }
    
    func createRequest(query: String)
    {
        //TODO
        Alamofire.request("https://api.github.com/search/users?q=" + query).responseJSON {
            responce in
            if let JSON = responce.result.value {
                print("JSON:  \(JSON)")
                self.items = []
                if let items = (JSON as! [String: Any])["items"]{
                    for anItem in items as! [Dictionary<String, AnyObject>] {
                        let personName = anItem["login"] as! String
                        let personId = anItem["id"] as! Int
                        let personAvatar = anItem["avatar_url"] as! String
                        let personFollowers = anItem["followers_url"] as! String
                        let personStarred = anItem["starred_url"] as! String
                        
                        self.items.append(GitUser(login: personName, id: personId, avatarurl: personAvatar,
                                                  followersurl: personFollowers, starredurl: personStarred))
                    }
                    self.items.sort{
                        $0.ID < $1.ID
                    }
                    self.mTableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: true)
                }
            }
        }
    }
    
}
