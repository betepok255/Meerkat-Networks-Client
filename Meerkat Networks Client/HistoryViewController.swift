//
//  HistoryViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 16.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit
import Alamofire

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    var hosts: AnyObject? = []
    
    var hostUrl: [String] = ["Url 1", "Url 2"]
    var hostCritical: [String] = ["1", "0"]
    var hostInformational: [String] = ["0", "1"]
    var hostDate: [String] = ["26.07.2015", "26.07.2015"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        menuButton.image = UIImage.fontAwesomeIconWithName(.Bars, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        
        
        self.myActivityIndicator.startAnimating()
        
        let parameters = ["token": SingletonDB.sharedInstance.token]
        
        Alamofire.request(.POST, APIUrl.EAHistory.rawValue, parameters: parameters)
            .responseJSON { response in
                self.myActivityIndicator.stopAnimating()
                
                if (response.response?.statusCode == 200){
                    self.hosts = response.result.value
                    print(self.hosts![0])
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
    
    @IBAction func menuButtonTouched(sender: AnyObject) {
        self.findHamburguerViewController()?.showMenuViewController()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hosts!.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HistoryListCell
        
        cell.addBorderBottom(size: 1, color: UIColor.lightGrayColor())
        
        let host: NSDictionary = (hosts![indexPath.row] as? NSDictionary)!
        
        cell.labelUrl.text = String(host["host"]!)
        cell.labelCritical.text = String(host["crit"]!)
//        if hostCritical[indexPath.row] != "0" {
//            let color = UIColor(MNColor.Red)
//            cell.labelCritical.textColor = color
//        } else {
//        }
        cell.labelInformational.text = String(host["info"]!)
        cell.labelDate.text = String(host["date"]!)
        cell.imageIcon.image = UIImage.fontAwesomeIconWithName(.InfoCircle, textColor: UIColor.grayColor(), size: CGSizeMake(28, 28))
                
        return cell
    }
    
}
