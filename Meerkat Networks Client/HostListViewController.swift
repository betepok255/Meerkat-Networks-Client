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
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var hostNames: [String] = ["Host 1", "Host 2", "Host 3", "Host 4"]
    var hostIps: [String] = ["52.58.119.202","52.58.119.202","52.58.119.202","52.58.119.202"]
    var hostStatuses: [Bool] = [true,false,true,false]
    var hostDates: [String] = ["02/08/2016","02/08/2016","02/08/2016","02/08/2016"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        menuButton.image = UIImage.fontAwesomeIconWithName(.Bars, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
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
        
        cell.addBorderBottom(size: 1, color: UIColor.lightGrayColor())
        
        cell.labelHost.text = hostNames[indexPath.row]
        cell.labelIp.text = hostIps[indexPath.row]
        cell.labelDate.text = hostDates[indexPath.row]
        if hostStatuses[indexPath.row] {
            cell.labelIsConnected.text = "Connected"
        } else {
            cell.labelIsConnected.text = "Disconnected"
        }
        cell.imageViewCheck.image = UIImage.fontAwesomeIconWithName(.Check, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))

        
        return cell
    }
    
    @IBAction func menuButtonTouched(sender: AnyObject) {
        self.findHamburguerViewController()?.showMenuViewController()
    }
    
}

public extension UIView {
    func addBorderTop(size size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    func addBorderBottom(size size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }
    func addBorderLeft(size size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }
    func addBorderRight(size size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }
    private func addBorderUtility(x x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
}



