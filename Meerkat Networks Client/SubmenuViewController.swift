//
//  SubmenuViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 26.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class SubmenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var upView: UIView!
    
    weak var delegate: SubmenuSelectedDelegate?
    
    let defaultSubmenu = ["Scan host now","Autoscan settings","Information about host"]
    
    var defaultSubmenuIcons: [FontAwesome] = [FontAwesome.Home,FontAwesome.Upload,FontAwesome.Download]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let gesture = UITapGestureRecognizer(target: self, action: "closeMenu:")
        self.upView.addGestureRecognizer(gesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closeMenu(gestureRecognizer: UITapGestureRecognizer){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultSubmenu.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SubmenuCell", forIndexPath: indexPath)
        cell.textLabel?.text = defaultSubmenu[indexPath.row]
        cell.imageView?.image = UIImage.fontAwesomeIconWithName(defaultSubmenuIcons[indexPath.row], textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.SubmenuRowSelected(indexPath.row)
        }
    }
    
}



