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
    let segues = ["Home","ea"]
    
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
    
//    func ChangeNavigationController(index: Int)
//    {
//        
//        switch index{
//        case 1:
//            let next = self.storyboard?.instantiateViewControllerWithIdentifier("EARootViewController") as! EARootViewController
//            self.presentViewController(next, animated: false, completion: nil)
//            break
//        case 2:
//            break
//        default: break;
//        }
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        if let hamburgerViewController = self.findHamburguerViewController() {
//            self.ChangeNavigationController(indexPath.row)
////            hamburgerViewController.hideMenuViewControllerWithCompletion({ () -> Void in
////                self.ChangeNavigationController(indexPath.row)
////            })
//        }
        
        let nvc = self.mainNavigationController()
        if let hamburguerViewController = self.findHamburguerViewController() {
            hamburguerViewController.hideMenuViewControllerWithCompletion({ () -> Void in
                nvc.visibleViewController!.performSegueWithIdentifier(self.segues[indexPath.row], sender: nil)
                hamburguerViewController.contentViewController = nvc
            })
        }
    }
    
    // MARK: - Navigation    
    func mainNavigationController() -> DLHamburguerNavigationController {
        return self.storyboard?.instantiateViewControllerWithIdentifier("HostListNavigationViewController") as! DLHamburguerNavigationController
    }
    
}
