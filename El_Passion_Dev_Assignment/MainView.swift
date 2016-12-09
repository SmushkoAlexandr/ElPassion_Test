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


    
}
