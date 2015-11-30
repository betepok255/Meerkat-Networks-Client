//
//  ComponentsViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 23.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class ComponentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,SubmenuSelectedDelegate {
    
    @IBOutlet weak var hostNameLabel: UILabel!
    @IBOutlet weak var submenuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuContaiter: UIView!
    
    
    var hostName: String = ""
    var hostId: String = ""
    var projectId: String = ""
    var components: [String] = ["Web Server", "Database", "Frameworks", "Code analysis"]
    var componentsSeguesData : [[String]] = [
        ["File permissions","Web server configuration","Benchmark","Server side language configuration"],
        ["Access policies","User privileges / policies","Benchmark","Server type specific","PCI-DSS","Environment Configuration"],
        ["Access policies","File permissions","Environment Configuration","Benchmark"],
        ["Vulnerable functions","SQL injections"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        hostNameLabel.text = hostName
        
        submenuButton.titleLabel?.font = UIFont.fontAwesomeOfSize(14)
        submenuButton.setTitle(String.fontAwesomeIconWithName(FontAwesome.EllipsisV), forState: .Normal)
                
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SubmenuRowSelected(rowIndex: Int) {
        switch rowIndex {
        case 0:
            self.performSegueWithIdentifier("ScanHostNowSegue", sender: self)
            break;
        case 1:
            self.performSegueWithIdentifier("Settings", sender: self)
            break;
        case 2:
            self.performSegueWithIdentifier("AboutHost", sender: self)
            break;
        default: break;
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ComponentsListCell
        
        cell.addBorderBottom(size: 1, color: UIColor.lightGrayColor())
        
        cell.hostLabel.text = components[indexPath.row]
        cell.badgeLabel.text = "0"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if (segue.identifier == "VulnerabilitioesSegue") {
            let index = tableView.indexPathForSelectedRow!.row
            let viewController = segue.destinationViewController as! GroupsViewController
            viewController.title = components[index]
            viewController.componentsSeguesData = componentsSeguesData[index]
        } else if (segue.identifier == "submenuSegue") {
            let controller = segue.destinationViewController as! SubmenuViewController
            controller.delegate = self
        } else if (segue.identifier == "ScanHostNowSegue") {
            let controller = segue.destinationViewController as! ScanNowViewController
            controller.hostId = self.hostId
            controller.projectId = self.projectId
            
        }
    }

}

@objc protocol SubmenuSelectedDelegate {
    func SubmenuRowSelected(rowIndex: Int)
}
