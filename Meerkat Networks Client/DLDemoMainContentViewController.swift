//
//  DLDemoMainContentViewController.swift
//  DLHamburguerMenu
//
//  Created by Nacho on 5/3/15.
//  Copyright (c) 2015 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

class DLDemoMainContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var hostNames: [String] = ["Host 1", "Host 2", "Host 3", "Host 4"]
    var hostIps: [String] = ["52.58.119.202","52.58.119.202","52.58.119.202","52.58.119.202"]
    var hostStatuses: [Bool] = [true,false,true,false]
    var hostDates: [String] = ["02/08/2016","02/08/2016","02/08/2016","02/08/2016"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func menuButtonTouched(sender: AnyObject) {
        self.findHamburguerViewController()?.showMenuViewController()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hostNames.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell 	{
        
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
}
