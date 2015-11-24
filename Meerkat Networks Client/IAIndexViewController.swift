//
//  IAIndex.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 16.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class IAIndexViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var hostNames: [String] = ["Host 1", "Host 2", "Host 3", "Host 4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        menuButton.image = UIImage.fontAwesomeIconWithName(FontAwesome.Bars, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
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
        return hostNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.addBorderBottom(size: 1, color: UIColor.lightGrayColor())
        
        cell.textLabel!.text = hostNames[indexPath.row]
        
        cell.imageView!.image = UIImage.fontAwesomeIconWithName(FontAwesome.CheckCircle, textColor: UIColor.greenColor(), size: CGSizeMake(30, 30))
        
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if (segue.identifier == "ComponentsSegue") {
            let index = tableView.indexPathForSelectedRow!.row
            let viewController = segue.destinationViewController as! ComponentsViewController
            
            viewController.hostName = hostNames[index]
        }
    }
    
}
