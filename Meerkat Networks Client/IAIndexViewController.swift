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
    
    var hosts: NSMutableDictionary = NSMutableDictionary()
    var hostNames: [String] = ["Host 1", "Host 2", "Host 3", "Host 4"]
    
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
                    let dict = response.result.value as! NSArray
                    for var i = 0; i < dict.count; i++ {
                        self.hosts.setValue(dict[i], forKey: String(i))
                    }
                    
//                    self.hosts = response.result.value
                    print(self.hosts)
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
        
        let host = hosts.valueForKey(String(indexPath.row))!
        
        cell.textLabel!.text = host["host"] as? String
        //        cell.textLabel!.text = hostNames[indexPath.row]
        
        cell.imageView!.image = UIImage.fontAwesomeIconWithName(FontAwesome.CheckCircle, textColor: UIColor.greenColor(), size: CGSizeMake(30, 30))
        
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if (segue.identifier == "ComponentsSegue") {
            let index = tableView.indexPathForSelectedRow!.row
            let viewController = segue.destinationViewController as! ComponentsViewController
            
            let host = hosts.valueForKey(String(index))!
            
            viewController.hostName = (host["host"] as? String)!
            viewController.hostId = (host["id"] as? String)!
            viewController.projectId = (host["project"] as? String)!
        }
    }
    
}
