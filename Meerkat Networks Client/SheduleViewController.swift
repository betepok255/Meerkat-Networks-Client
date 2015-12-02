//
//  SheduleViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 23.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit
import Alamofire

class SheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // Data
    var hostId = ""
    var hostState = ""
    var requestUrlSave = ""
    var postIdParameter = "" // "id" or "project"
    var timesScan: [[String]] = [[],[],[],[],[],[],[]]
    weak var EADelegate: EASchedulerDelegate?
    
    var activeDayTimes = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.activeDayTimes = timesScan[0]
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setEditing(true, animated: false)
        
        self.addButton.image = UIImage.fontAwesomeIconWithName(FontAwesome.Plus, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnClickAddButton(sender: AnyObject) {
        let pickerTime = self.datePicker.date
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.stringFromDate(pickerTime)
        
        self.timesScan[self.segmentControl.selectedSegmentIndex].append(dateString)
        self.activeDayTimes = self.timesScan[self.segmentControl.selectedSegmentIndex]
        self.tableView.reloadData()
        
        self.SaveSchedule()        
    }
    
    func SaveSchedule() {
        let parameters = ["token": SingletonDB.sharedInstance.token, postIdParameter: self.hostId, "state": self.hostState as String, "data": self.convertTimescanToDataString().description]
        
        self.EADelegate?.TimetableChanged(timesScan)
        
        Alamofire.request(.POST, requestUrlSave, parameters: parameters)
    }
    
    func convertTimescanToDataString() -> [[String]] {
        // FIX: Monday / Sunday
        var arrForSave: [[String]] = [[],[],[],[],[],[],[]]
        for var i = 0; i < arrForSave.count; i++ {
            if i + 1 != 7 {
                arrForSave[i] = timesScan[i+1]
            } else {
                arrForSave[i] = timesScan[0]
            }
            
        } //
                
        var converted: [[String]] = []
        
        for var i = 0; i < arrForSave.count; i++ {
            for var j = 0; j < 3 /*self.timesScan[i].count*/; j++ {
                var temp: [String] = []
                temp.append(String(j+1))
                temp.append(String(i+1))
                if arrForSave[i].count < j + 1 {
                    temp.append("")
                } else {
                    temp.append(arrForSave[i][j])
                }
                
                converted.append(temp)
            }
        }
        
        return converted
    }
    
    @IBAction func SegmentControlValueChanged(sender: AnyObject) {
        self.activeDayTimes = self.timesScan[self.segmentControl.selectedSegmentIndex]
        self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activeDayTimes.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.addBorderBottom(size: 1, color: UIColor.lightGrayColor())
        
        cell.textLabel!.text = self.activeDayTimes[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            timesScan[segmentControl.selectedSegmentIndex].removeAtIndex(indexPath.row)
            activeDayTimes = timesScan[segmentControl.selectedSegmentIndex]
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            SaveSchedule()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
}