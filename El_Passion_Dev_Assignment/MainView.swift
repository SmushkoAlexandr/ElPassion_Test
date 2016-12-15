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
    
    var items: [GitObject] = []
    
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
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text != ""){
            createRequest(query: searchBar.text!)
        }else {
            items = []
            self.mTableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: true)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle,reuseIdentifier: "cell")
        cell.textLabel?.text = self.items[indexPath.row].NAME
        cell.detailTextLabel?.text = ("User = " + "\(self.items[indexPath.row].USER)")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(items[indexPath.row].USER){
            print("You selected cell #\(indexPath.row)!")
            print(items[indexPath.row].ID)
            self.performSegue(withIdentifier: "InfoViewSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "InfoViewSegue"){
            let infoVc = segue.destination as! InfoView
            
            let ind = mTableView.indexPathForSelectedRow?.row
            //(mTableView.indexPathForSelectedRow?.row)!
            //infoVc.lblName.text = items[ind!].NAME
            infoVc.name = items[ind!].NAME
        }
    }
    
    func createRequest(query: String)
    {
        self.items = []
        //TODO repositories
        Alamofire.request("https://api.github.com/search/users?q=" + query).responseJSON {
            response in
            if let JSON = response.result.value {
                print("JSON:  \(JSON)")
                
                let limitResponse = JSON as! NSDictionary
                if limitResponse["message"] != nil
                {
                    self.alertShow(title: "Error", message: (limitResponse["message"] as! String), titleOk: "Ok")
                }
                    
                else{
                    if let items = (JSON as! [String: Any])["items"]{
                        
                        for anItem in items as! [Dictionary<String, AnyObject>] {
                            let personName = anItem["login"] as! String
                            let personId = anItem["id"] as! Int
                            
                            self.items.append(GitObject(login: personName, id: personId))
                        }
                        self.items.sort{
                            $0.ID < $1.ID
                        }
                        self.mTableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: true)
                    }
                }
            }
        }
        
        Alamofire.request("https://api.github.com/search/repositories?q=" + query).responseJSON {
            response in
            if let JSON = response.result.value {
                print("JSON:  \(JSON)")
                
                let limitResponse = JSON as! NSDictionary
                if limitResponse["message"] == nil
                {
                    if let items = (JSON as! [String: Any])["items"]{
                        for anItem in items as! [Dictionary<String, AnyObject>] {
                            let personName = anItem["name"] as! String
                            let personId = anItem["id"] as! Int
                            
                            self.items.append(GitObject(title: personName, id: personId))
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
    
    func alertShow(title: String, message: String, titleOk: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: titleOk, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
