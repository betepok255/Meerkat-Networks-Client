//
//  LoginViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 11/12/15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func OnClickLoginButton(sender: AnyObject) {
        
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("RootViewController") as! RootViewController
        self.presentViewController(next, animated: true, completion: nil)
        
//        let initialViewController = UIStoryboard(name: "Main", bundle:nil).instantiateInitialViewController() as! HomeRootViewController
//        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        appDelegate.window?.rootViewController = initialViewController
    }

}

