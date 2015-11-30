//
//  SheduleViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 23.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class SheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // Data
    var hostId = ""
    var hostState = ""
//    var sDays = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]    
    var timesScan: [[String]] = [[],[],[],[],[],[],[]]
    
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
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

}