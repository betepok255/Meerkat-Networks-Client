//
//  ScanHostViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 16.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit
import Alamofire

class ScanHostViewController: UIViewController {
    
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var scanNowButton: UIButton!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        menuButton.image = UIImage.fontAwesomeIconWithName(.Bars, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func menuButonTouched(sender: AnyObject) {
        self.findHamburguerViewController()?.showMenuViewController()
    }
    
    @IBAction func OnClickScanButton(sender: AnyObject) {
        let parameters = ["token": SingletonDB.sharedInstance.token, "url": url.text!]
        
        Alamofire.request(.POST, APIUrl.EAScan.rawValue, parameters: parameters)
        
        let alert = UIAlertController(title: "Success", message: "Request sent", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
