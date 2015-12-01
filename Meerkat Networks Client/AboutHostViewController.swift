//
//  AboutHostViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 27.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit
import Alamofire

class AboutHostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var projectId = ""
    var categories: [String] = ["Web", "Database", "Framework", "Code analysis"]
    var titles: [[String]] = [[],[],[],[]]
    var descriptions: [[String]] = [[],[],[],[]]
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
//    var hosts: NSMutableDictionary = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        self.myActivityIndicator.center = self.view.center
        view.addSubview(myActivityIndicator)
        
        self.myActivityIndicator.startAnimating()
        
        let parameters = ["token": SingletonDB.sharedInstance.token, "project": self.projectId]
        
        Alamofire.request(.POST, APIUrl.IAAboutHost.rawValue, parameters: parameters)
            .responseJSON { response in
                self.myActivityIndicator.stopAnimating()
                
                if (response.response?.statusCode == 200){
                    let result = response.result.value as! NSMutableDictionary
                    self.categories.removeAll()
                    self.titles.removeAll()
                    self.descriptions.removeAll()
                    
                    for (key, value) in result {
                        self.categories.append(key as! String)
                        
                        var nTitle: [String] = []
                        var nDesc: [String] = []
                        
                        for (key2, value2) in value as! NSDictionary {
                            nTitle.append(key2 as! String)
                            nDesc.append(value2 as! String)
                        }
                        
                        self.titles.append(nTitle)
                        self.descriptions.append(nDesc)
                    }
                    
                    self.tableView.reloadData()
                } else {
                    let alert = UIAlertController(title: "Error", message: "Request error.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles[section].count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DetailCell
        
        cell.addBorderBottom(size: 1, color: UIColor.lightGrayColor())
        
        cell.titleLabel.text = titles[indexPath.section][indexPath.row]
        cell.descriptionLabel.text = descriptions[indexPath.section][indexPath.row]
        
        return cell
    }
    
}