//
//  AutoscanSettingsTable.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 16.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

//
//  AutoscanSettingsTable.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 16.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit
import Alamofire

class AutoscanSettingsTable: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var stateSwitch: UISwitch!
    
    weak var delegate: HostStateDelegate?
    
    // Data
    var hostID = ""
    var state = ""
    var hostIndex = -1
    var sDays = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    var timesScan: [[String]] = [[],[],[],[],[],[],[]]
    
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        editButton.image = UIImage.fontAwesomeIconWithName(FontAwesome.Edit, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        
        if state == "on" || state == "On" {
            stateSwitch.on = true
        } else {
            stateSwitch.on = false
        }
        
        collectionView!.dataSource = self
        collectionView!.delegate = self
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: 90, height: 90)
//        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//        collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
//        collectionView!.backgroundColor = UIColor.whiteColor()
//        self.view.addSubview(collectionView!)
        
        self.myActivityIndicator.center = self.view.center
        view.addSubview(myActivityIndicator)
        
        self.myActivityIndicator.startAnimating()
        
        let parameters = ["token": SingletonDB.sharedInstance.token, "id": String(hostID)]
        
        Alamofire.request(.POST, APIUrl.EALoadHost.rawValue, parameters: parameters)
            .responseJSON { response in
                self.myActivityIndicator.stopAnimating()
                
                if (response.response?.statusCode == 200){
                    self.convertValueToArray(response.result.value!)
                    self.collectionView.reloadData()
                } else {
                    let alert = UIAlertController(title: "Error", message: "Request error.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
        }
        
    }
    
    func convertValueToArray(days: AnyObject) {
        for dayTable in days as! NSArray {
            if dayTable["day7"] as! String != "" {
                timesScan[0].append(dayTable["day7"] as! String)
            }
            if dayTable["day1"] as! String != "" {
                timesScan[1].append(dayTable["day1"] as! String)
            }
            if dayTable["day2"] as! String != "" {
                timesScan[2].append(dayTable["day2"] as! String)
            }
            if dayTable["day3"] as! String != "" {
                timesScan[3].append(dayTable["day3"] as! String)
            }
            if dayTable["day4"] as! String != "" {
                timesScan[4].append(dayTable["day4"] as! String)
            }
            if dayTable["day5"] as! String != "" {
                timesScan[5].append(dayTable["day5"] as! String)
            }
            if dayTable["day6"] as! String != "" {
                timesScan[6].append(dayTable["day6"] as! String)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! WeektableCollectionViewCell
        cell.labelDay.text = sDays[indexPath.row]
        
        cell.labelTime.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
        cell.labelTime.numberOfLines = timesScan[indexPath.row].count
        
        cell.labelTime.text = multilineTextFromArray(timesScan[indexPath.row])
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func multilineTextFromArray(array: [String]) -> String
    {
        var text = ""
        for first in array {
            if text != ""{
                text += "\n"
            }
            
            text += first
        }
        
        return text
    }
    
    @IBAction func OnStateChanged(sender: AnyObject) {        
        self.state = stateSwitch.on ? "on" : "off"
        self.delegate?.HostStateChanged(self.hostIndex, state: self.state)
        
        let parameters = ["token": SingletonDB.sharedInstance.token, "id": String(hostID), "state": self.state as String ]
        
        Alamofire.request(.POST, APIUrl.EASaveHost.rawValue, parameters: parameters)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if (segue.identifier == "ScheduleSegue") {
            let viewController = segue.destinationViewController as! SheduleViewController
            viewController.hostId = self.hostID
            viewController.timesScan = self.timesScan
            viewController.hostState = self.state
        }
    }
}




