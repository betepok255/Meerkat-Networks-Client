//
//  HistoryViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 16.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var tableView: UITableView!
    
    var hostUrl: [String] = ["Url 1", "Url 2"]
    var hostCritical: [String] = ["1", "0"]
    var hostInformational: [String] = ["0", "1"]
    var hostDate: [String] = ["26.07.2015", "26.07.2015"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hostUrl.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HistoryListCell
        
        cell.addBorderBottom(size: 1, color: UIColor.lightGrayColor())
        
        cell.labelUrl.text = hostUrl[indexPath.row]
        cell.labelCritical.text = hostCritical[indexPath.row]
        cell.labelInformational.text = hostInformational[indexPath.row]
        cell.labelDate.text = hostDate[indexPath.row]
                
        return cell
    }
    
}
