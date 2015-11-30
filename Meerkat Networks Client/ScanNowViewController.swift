//
//  ScanNowViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 27.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

//
//  IASettingsViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 27.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit
import Alamofire

class ScanNowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var hostId = ""
    var projectId = ""
    var categories: [String] = ["Web", "Database", "Framework", "Code analysis"]
    var components: [[String]] = [
        ["File permissions", "Web server configuration", "Benchmark", "Server side language configuration"],
        ["Access policies", "User privileges / policies", "Benchmark", "Server type specific", "PCI-DSS", "Environment Configuration"],
        ["Benchmark", "Environment Configuration", "File permissions", "Access policies"],
        ["SQL injections", "Vulnerable functions"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components[section].count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ScanNowCell
        
        cell.addBorderBottom(size: 1, color: UIColor.lightGrayColor())
        
        cell.component.text = components[indexPath.section][indexPath.row]
        
        return cell
    }
    
    @IBAction func OnClickScanNowButton(sender: AnyObject) {
        print(hostId, projectId)
        
        let parameters = ["token": SingletonDB.sharedInstance.token, "project": projectId, "host": hostId]
        
        Alamofire.request(.POST, APIUrl.EAScan.rawValue, parameters: parameters)
        
        let alert = UIAlertController(title: "Success", message: "Request sent.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler:{ (alertAction:UIAlertAction!) in
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
}