//
//  HostListNewViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 11/12/15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit
import Alamofire

class HostListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!    
    
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
//    var hostNames: [String] = ["Host 1", "Host 2", "Host 3", "Host 4"]
//    var hostIps: [String] = ["52.58.119.202","52.58.119.202","52.58.119.202","52.58.119.202"]
//    var hostStatuses: [Bool] = [true,false,true,false]
//    var hostDates: [String] = ["02/08/2016","02/08/2016","02/08/2016","02/08/2016"]
    
    var hosts: AnyObject? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        menuButton.image = UIImage.fontAwesomeIconWithName(.Bars, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        
        self.myActivityIndicator.center = self.view.center
        view.addSubview(myActivityIndicator)
        self.myActivityIndicator.startAnimating()
        
        let parameters = ["token": SingletonDB.sharedInstance.token]
        
        Alamofire.request(.POST, APIUrl.HostList.rawValue, parameters: parameters)
            .responseJSON { response in
                self.myActivityIndicator.stopAnimating()
                
                if (response.response?.statusCode == 200){
                    self.hosts = response.result.value
//                    print(self.hosts![0])
                    self.tableView.reloadData()
                } else {
                    let alert = UIAlertController(title: "Error", message: "Login or password incorrect!", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hosts!.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HostListCell
        
        cell.addBorderBottom(size: 1, color: UIColor.lightGrayColor())
        
        let host: NSDictionary = (hosts![indexPath.row] as? NSDictionary)!
        
        cell.labelHost.text = String(host["name"]!)
        cell.labelIp.text = String(host["ip"]!)
        
        let dateString = String(host["exp_date"]!)
        cell.labelDate.text = dateString
        
        if String(host["connected"]!) == "1" {
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




