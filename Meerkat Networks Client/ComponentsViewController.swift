//
//  ComponentsViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 23.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class ComponentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var hostNames: [String] = ["Web Server", "Database", "Frameworks", "Code analysis"]
    var componentsSeguesData : [[String]] = [["x"],["xy"],["xyy"],["xyy"]]
    var valueToPass: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        menuButton.image = UIImage.fontAwesomeIconWithName(FontAwesome.Bars, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func menuButtonTouched(sender: AnyObject) {
//        self.findHamburguerViewController()?.showMenuViewController()
//    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hostNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ComponentsListCell
        
        cell.addBorderBottom(size: 1, color: UIColor.lightGrayColor())
        
        cell.hostLabel.text = hostNames[indexPath.row]
        cell.badgeLabel.text = "0"
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        valueToPass = componentsSeguesData[indexPath.row]
        performSegueWithIdentifier("VulnerabilitioesSegue", sender: self)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "VulnerabilitioesSegue") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destinationViewController as! VulnerabilitiesViewController
            // your new view controller should have property that will store passed value
            viewController.componentsSeguesData = valueToPass
        }
        
    }
    
}
