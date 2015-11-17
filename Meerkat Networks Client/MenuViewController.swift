//
//  MenuViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 11/12/15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func ProfileButtonClick(sender: AnyObject) {
        if activeMenu.elementsEqual(defaultMenu)
        {
            activeMenu = profileMenu
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Bottom)
            
        } else {
            activeMenu = defaultMenu
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Top)
        }
    }
    
    // data
    let defaultMenu = ["Home","External Audit","Internal Audit"]
    var defaultMenuSelection = 0
    let profileMenu = ["Profile","Second"]
    var profileMenuSelection = 0
    
    var activeMenu = [""]
    
    override func viewDidLoad() {
        activeMenu = defaultMenu
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let indexPath = NSIndexPath(forRow: 0, inSection: 0);
        self.tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
        self.tableView(self.tableView, didSelectRowAtIndexPath: indexPath)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDelegate&DataSource methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeMenu.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) 
        cell.textLabel?.text = activeMenu[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let hamburguerViewController = self.findHamburguerViewController() {
            hamburguerViewController.hideMenuViewControllerWithCompletion({ () -> Void in
                // Default Menu
                if self.activeMenu.elementsEqual(self.defaultMenu)
                {
                    switch indexPath.row
                    {
                    case 0:
                        let nav = self.storyboard?.instantiateViewControllerWithIdentifier("HostListNavigationViewController") as! DLHamburguerNavigationController
                        hamburguerViewController.contentViewController = nav
                        break
                    case 1:
                        let nav = self.storyboard?.instantiateViewControllerWithIdentifier("EANavigationViewController") as! DLHamburguerNavigationController
                        hamburguerViewController.contentViewController = nav
                        break
                    case 2:
                        let nav = self.storyboard?.instantiateViewControllerWithIdentifier("IANavigationViewController") as! DLHamburguerNavigationController
                        hamburguerViewController.contentViewController = nav
                        break
                    default:
                        break
                    }
                    self.defaultMenuSelection = indexPath.row
                } else {
                    // Profile Menu
                    switch indexPath.row
                    {
                    case 0:
                        let nav = self.storyboard?.instantiateViewControllerWithIdentifier("HostListNavigationViewController") as! DLHamburguerNavigationController
                        hamburguerViewController.contentViewController = nav
                        break
                    default:
                        break
                    }
                    self.profileMenuSelection = indexPath.row
                }
                // switch...
                
                
//                nvc.visibleViewController!.performSegueWithIdentifier(self.segues[indexPath.row], sender: nil)
//                hamburguerViewController.contentViewController = nvc
            })
        }
    }
    
    // MARK: - Navigation    
    func mainNavigationController() -> DLHamburguerNavigationController {
        return self.storyboard?.instantiateViewControllerWithIdentifier("HostListNavigationViewController") as! DLHamburguerNavigationController
    }
    
}
