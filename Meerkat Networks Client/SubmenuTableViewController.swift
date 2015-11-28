//
//  SubmenuTableViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 26.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//


import UIKit

class SubmenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let defaultSubmenu = ["Home","External Audit","Internal Audit","Web Security"]
    var defaultSubmenuIcons: [FontAwesome] = [FontAwesome.Home,FontAwesome.Upload,FontAwesome.Download,FontAwesome.FileTextO]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        hostNameLabel.text = hostName
//        
//        submenuButton.titleLabel?.font = UIFont.fontAwesomeOfSize(14)
//        submenuButton.setTitle(String.fontAwesomeIconWithName(FontAwesome.EllipsisV), forState: .Normal)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultSubmenu.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath)
        cell.textLabel?.text = defaultSubmenu[indexPath.row]
        cell.imageView?.image=UIImage.fontAwesomeIconWithName(defaultSubmenuIcons[indexPath.row], textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        return cell
    }
    
}
