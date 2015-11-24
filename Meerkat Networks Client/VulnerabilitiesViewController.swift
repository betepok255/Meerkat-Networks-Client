//
//  VulnerabilitiesViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 24.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class VulnerabilitiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var vulnerabilities : [[String]] = [
        ["1.1 - Apache HTTP Server mod_cgid module denial of service","Medium","A flaw was found in mod_cgid. If a server using mod_cgid hosted CGI scripts which did not consume standard input, a remote attacker could cause child processes to hang indefinitely, leading to denial of service.","pgrade to the latest version of Apache HTTP Server (2.4.10-dev or later), available from the Apache Web site:http://httpd.apache.org/security/vulnerabilities_24.html"],
        ["1.2 - Apache HTTP Server mod_cgid module denial of service","Medium","A flaw was found in mod_cgid. If a server using mod_cgid hosted CGI scripts which did not consume standard input, a remote attacker could cause child processes to hang indefinitely, leading to denial of service.","pgrade to the latest version of Apache HTTP Server (2.4.10-dev or later), available from the Apache Web site:http://httpd.apache.org/security/vulnerabilities_24.html"]
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
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vulnerabilities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! VulnerabilityListCell
        
        cell.addBorderBottom(size: 1, color: UIColor.lightGrayColor())
        
        cell.titleLabel.text = vulnerabilities[indexPath.row][0]
        cell.levelLabel.text = vulnerabilities[indexPath.row][1]
        cell.shortDescriptionLabel.text = vulnerabilities[indexPath.row][2]
        cell.longDescriptionLabel.text = vulnerabilities[indexPath.row][3]
        
        return cell
    }
}
