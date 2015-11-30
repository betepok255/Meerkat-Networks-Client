//
//  SettingsViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 16.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit
import Alamofire

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HostStateDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
//    var hostUrl: [String] = ["Url 1", "Url 2"]
//    var hostStatus: [String] = ["On", "Off"]
    
// TEMPLATE:    let host = hosts.valueForKey(String(indexPath.row))!
    
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    var hosts: NSMutableDictionary = NSMutableDictionary()
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.myActivityIndicator.center = self.view.center
        view.addSubview(myActivityIndicator)
        
        addButton.image = UIImage.fontAwesomeIconWithName(FontAwesome.Plus, textColor: UIColor.blackColor(), size: CGSizeMake(20, 20))
        
        loadHosts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hosts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SettingsListCell
        
        cell.addBorderBottom(size: 1, color: UIColor.lightGrayColor())
        
        let host = hosts.valueForKey(String(indexPath.row))!
        
        cell.labelUrl.text = host["host"] as? String
        cell.labelStatus.text = host["autoscan"] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let host = hosts.valueForKey(String(indexPath.row))!
//            print("[" + (host["id"] as! String) + "]")
            
            let parameters = ["token": SingletonDB.sharedInstance.token, "ids": "[" + (host["id"] as! String) + "]" ]
            Alamofire.request(.POST, APIUrl.EADeleteHost.rawValue, parameters: parameters)
            
            hosts.removeObjectForKey(String(indexPath.row))
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    @IBAction func doEdit(sender: AnyObject) {
        if (self.tableView.editing) {
            editButton.title = "Edit"
            self.tableView.setEditing(false, animated: true)
        } else {
            editButton.title = "Done"
            self.tableView.setEditing(true, animated: true)
        }
    }
    
    @IBAction func OnClickAddButton(sender: AnyObject) {
        let alert = UIAlertController(title: "Add host", message: "Enter URL", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Url"
            textField.secureTextEntry = false
        })
        alert.addAction(UIAlertAction(title: "Add", style: .Default, handler:{ (alertAction:UIAlertAction!) in
            self.myActivityIndicator.startAnimating()
            
            let textf = alert.textFields![0] as UITextField
            let parameters = ["token": SingletonDB.sharedInstance.token, "host":textf.text!]
            
            Alamofire.request(.POST, APIUrl.EACreateHost.rawValue, parameters: parameters)
                .responseJSON { response in
                    self.myActivityIndicator.stopAnimating()
                    
                    if (response.response?.statusCode == 200){
                        self.loadHosts()
                    } else {
                        let alert = UIAlertController(title: "Error", message: "Request error.", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func loadHosts(){
        self.myActivityIndicator.startAnimating()
        
        let parameters = ["token": SingletonDB.sharedInstance.token]
        
        Alamofire.request(.POST, APIUrl.EAAutoScanSettings.rawValue, parameters: parameters)
            .responseJSON { response in
                self.myActivityIndicator.stopAnimating()
                
                if (response.response?.statusCode == 200){
                    self.hosts.removeAllObjects()
                    let dict = response.result.value as! NSArray
                    for var i = 0; i < dict.count; i++ {
                        self.hosts.setValue(dict[i], forKey: String(i))
                    }
                    
                    self.tableView.reloadData()
                    
                } else {
                    let alert = UIAlertController(title: "Error", message: "Request error.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if (segue.identifier == "EATimetableSegue") {
            let index = tableView.indexPathForSelectedRow!.row
            let host = hosts.valueForKey(String(index))!
            
            let viewController = segue.destinationViewController as! AutoscanSettingsTable
            viewController.hostID = host["id"] as! String
            viewController.state = host["autoscan"] as! String
            viewController.hostIndex = index
            viewController.delegate = self
        }
    }
    
    func HostStateChanged(index: Int, state: String) {
        self.loadHosts()
    }
}

@objc protocol HostStateDelegate {
    func HostStateChanged(index: Int, state: String)
}
