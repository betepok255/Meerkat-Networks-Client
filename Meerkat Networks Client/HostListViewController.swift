//
//  HostListNewViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 11/12/15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class HostListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var hostNames: [String] = ["Host 1", "Host 2", "Host 3", "Host 4"]
    var hostIps: [String] = ["52.58.119.202","52.58.119.202","52.58.119.202","52.58.119.202"]
    var hostStatuses: [Bool] = [true,false,true,false]
    var hostDates: [String] = ["02/08/2016","02/08/2016","02/08/2016","02/08/2016"]
    
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hostNames.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HostListCell
        
        cell.labelHost.text = hostNames[indexPath.row]
        cell.labelIp.text = hostIps[indexPath.row]
        cell.labelDate.text = hostDates[indexPath.row]
        if hostStatuses[indexPath.row] {
            cell.labelIsConnected.text = "Connected"
        } else {
            cell.labelIsConnected.text = "Disconnected"
        }
        //cell.icon.image = UIImage(named: "check")
        
        return cell
    }
    
    @IBAction func menuButtonTouched(sender: AnyObject) {
        self.findHamburguerViewController()?.showMenuViewController()
    }
    
}
