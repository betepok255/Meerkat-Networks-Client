//
//  IAIndex.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 16.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit
import Alamofire

class IAIndexViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    var hosts: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        menuButton.image = UIImage.fontAwesomeIconWithName(FontAwesome.Bars, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        
        self.myActivityIndicator.center = self.view.center
        view.addSubview(myActivityIndicator)
        
        self.myActivityIndicator.startAnimating()
        
        let parameters = ["token": SingletonDB.sharedInstance.token]
        
        Alamofire.request(.POST, APIUrl.IAHistory.rawValue, parameters: parameters)
            .responseJSON { response in
                self.myActivityIndicator.stopAnimating()
                
                if (response.response?.statusCode == 200){
                    self.hosts.removeAllObjects()
                    
                    let dict = response.result.value as! NSMutableArray
                    var mutableElem = NSMutableDictionary()
                    for var i = 0; i < dict.count; i++ {
                        mutableElem = NSMutableDictionary(dictionary: dict[i] as! [NSObject : AnyObject])
                        self.hosts.addObject(mutableElem)
                    }
                    
                    self.tableView.reloadData()
                } else {
                    let alert = UIAlertController(title: "Error", message: "Request error.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuButtonTouched(sender: AnyObject) {
        self.findHamburguerViewController()?.showMenuViewController()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hosts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.addBorderBottom(size: 1, color: UIColor.lightGrayColor())
        
        let host = hosts[indexPath.row] as! NSDictionary
        
        cell.textLabel!.text = host["host"] as? String
        
        cell.imageView!.image = UIImage.fontAwesomeIconWithName(FontAwesome.CheckCircle, textColor: UIColor.greenColor(), size: CGSizeMake(30, 30))
        
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if (segue.identifier == "ComponentsSegue") {
            let index = tableView.indexPathForSelectedRow!.row
            let controller = segue.destinationViewController as! ComponentsViewController
            
            let host = hosts[index] as! NSDictionary
            
            controller.hostName = (host["host"] as? String)!
            controller.hostId = (host["id"] as? String)!
            controller.projectId = (host["project"] as? String)!
            controller.hosts = self.hosts
            
        }
    }
    
}
