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
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBAction func ProfileButtonClick(sender: AnyObject) {
        if activeMenu.elementsEqual(defaultMenu)
        {
            activeMenu = profileMenu
            activeIcons = profileMenuIcons
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Left)
            profileButton.setTitle(String.fontAwesomeIconWithName(.CaretUp), forState: .Normal)
            
        } else {
            activeMenu = defaultMenu
            activeIcons = defaultMenuIcons
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Right)
            profileButton.setTitle(String.fontAwesomeIconWithName(.CaretDown), forState: .Normal)
        }
    }
    
    // defaultMenu
    let defaultMenu = ["Home","External Audit","Internal Audit","Web Security","Database Security","Monitoring","Support","Settings"]
    var defaultMenuIcons:[FontAwesome
    ] = [FontAwesome.Home,FontAwesome.Upload,FontAwesome.Download,FontAwesome.FileTextO,FontAwesome.Database,FontAwesome.Tv,FontAwesome.Wechat,FontAwesome.Cogs]
    var defaultMenuSelection = 0
    
    // profileMenu
    let profileMenu = ["Account Info","Change password","Switch account","Exit"]
    var profileMenuIcons:[FontAwesome
    ] = [FontAwesome.ListAlt,FontAwesome.Unlock,FontAwesome.Refresh,FontAwesome.SignOut]
    var profileMenuSelection = 0
    
    // activeMenu
    var activeMenu = [""]
    var activeIcons:[FontAwesome] = []
    
    override func viewDidLoad() {
        activeMenu = defaultMenu
        activeIcons = defaultMenuIcons
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let indexPath = NSIndexPath(forRow: 0, inSection: 0);
        self.tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
        self.tableView(self.tableView, didSelectRowAtIndexPath: indexPath)
        
        profileButton.titleLabel?.font = UIFont.fontAwesomeOfSize(20)
        profileButton.setTitle(String.fontAwesomeIconWithName(FontAwesome.CaretDown), forState: .Normal)
        
        usernameLabel.text = SingletonDB.sharedInstance.userName
        emailLabel.text = SingletonDB.sharedInstance.userEmail
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
        cell.imageView?.image=UIImage.fontAwesomeIconWithName(activeIcons[indexPath.row], textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
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
                        let nav = self.storyboard?.instantiateViewControllerWithIdentifier("EAController")
                        hamburguerViewController.contentViewController = nav
                        break
                    case 2:
                        let nav = self.storyboard?.instantiateViewControllerWithIdentifier("IANavigationViewController")
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
