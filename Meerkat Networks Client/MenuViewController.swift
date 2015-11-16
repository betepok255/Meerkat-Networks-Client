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
    
    // data
    let segues = ["Home","External Audit","Internal Audit"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDelegate&DataSource methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segues.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) 
        cell.textLabel?.text = segues[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        navigationController?.pushViewController(vc, animated: true)
//        
//        if let hamburgerViewController = self.findHamburguerViewController() {
//            self.ChangeNavigationController(indexPath.row)
////            hamburgerViewController.hideMenuViewControllerWithCompletion({ () -> Void in
////                self.ChangeNavigationController(indexPath.row)
////            })
//        }
//        
//        let nvc = self.mainNavigationController()
        if let hamburguerViewController = self.findHamburguerViewController() {
            hamburguerViewController.hideMenuViewControllerWithCompletion({ () -> Void in
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
