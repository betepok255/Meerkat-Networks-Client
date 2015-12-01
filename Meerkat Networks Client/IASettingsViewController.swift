//
//  IASettingsViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 27.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit
import Alamofire

class IASettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HostStateDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var hosts: NSMutableArray = []
    
//    var hostUrl: [String] = ["Url 1", "Url 2"]
//    var hostStatus: [String] = ["On", "Off"]
    
//    @IBOutlet weak var editButton: UIBarButtonItem!
//    
//    @IBAction func doEdit(sender: AnyObject) {
//        
//        if (self.tableView.editing) {
//            editButton.title = "Edit"
//            self.tableView.setEditing(false, animated: true)
//            //            self.tableView.s
//        } else {
//            editButton.title = "Done"
//            self.tableView.setEditing(true, animated: true)
//        }
//    }
    
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
        return hosts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SettingsListCell
        
        cell.addBorderBottom(size: 1, color: UIColor.lightGrayColor())
        
        let host = hosts[indexPath.row] as! NSDictionary
        
        cell.labelUrl.text = host["host"] as? String
        cell.labelStatus.text = host["autoscan"] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
//    
////    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
////        if editingStyle == .Delete {
////            hostUrl.removeAtIndex(indexPath.row)
////            hostStatus.removeAtIndex(indexPath.row)
////            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
////        } else if editingStyle == .Insert {
////            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
////        }
////    }
//    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            
//            let host = hosts[indexPath.row] as! NSDictionary
//            
//            let parameters = ["token": SingletonDB.sharedInstance.token, "ids": "[" + (host["id"] as! String) + "]" ]
//            Alamofire.request(.POST, APIUrl.IADeleteHost.rawValue, parameters: parameters)
//            
//            hosts.removeObjectAtIndex(indexPath.row)
//            
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if (segue.identifier == "IATimetableSegue") {
            let index = tableView.indexPathForSelectedRow!.row
            let host = hosts[index] as! NSDictionary
            
            let viewController = segue.destinationViewController as! AutoscanSettingsTable
            viewController.hostID = host["project"] as! String
            viewController.state = host["autoscan"] as! String
            viewController.hostIndex = index
            viewController.senderAudit = "IA"
            viewController.requestUrlLoad = APIUrl.IALoadHost.rawValue
            viewController.requestUrlSave = APIUrl.IASaveHost.rawValue
            viewController.postIdParameter = "project"
            
            viewController.delegate = self
        }
    }
    
    func HostStateChanged(index: Int, state: String) {
        let host = self.hosts[index]
        host.setValue(state, forKey: "autoscan")
        self.hosts.replaceObjectAtIndex(index, withObject: host)
        
        tableView.reloadData()
    }
    
}