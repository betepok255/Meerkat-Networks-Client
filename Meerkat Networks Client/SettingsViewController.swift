//
//  SettingsViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 16.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    var hostUrl: [String] = ["Url 1", "Url 2"]
    var hostStatus: [String] = ["On", "Off"]
    
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
        return hostUrl.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SettingsListCell
        
        cell.labelUrl.text = hostUrl[indexPath.row]
        cell.labelStatus.text = hostStatus[indexPath.row]
        
        return cell
    }
    
}
