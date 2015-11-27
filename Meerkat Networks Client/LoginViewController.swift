//
//  LoginViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 11/12/15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import Alamofire
import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        var wait = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
//        self.viewActivityIndicator = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
//        self.viewActivityIndicator.backgroundColor = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 51.0/255.0, alpha: 0.5)
//        self.viewActivityIndicator.layer.cornerRadius = 10
//        
//        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        self.activityIndicator.color = UIColor.blackColor()
//        self.activityIndicator.hidesWhenStopped = false
//        
//        let titleLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
//        titleLabel.text = "Processing..."
//        
//        self.viewActivityIndicator.addSubview(self.activityIndicator)
//        self.viewActivityIndicator.addSubview(titleLabel)
//        
//        self.view.addSubview(self.viewActivityIndicator)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func OnClickLoginButton(sender: AnyObject) {
        
//        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
//            .responseJSON { response in
//
////                print(response.request)  // original URL request
////                print(response.response) // URL response
////                print(response.data)     // server data
////                print(response.result)   // result of response serialization
//                
//                if (response.response?.statusCode == 2050){
//                    
//                } else {
//                    let alert = UIAlertController(title: "Error", message: "Login or password incorrect!", preferredStyle: UIAlertControllerStyle.Alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                    self.presentViewController(alert, animated: true, completion: nil)
//                }
//        }
        
        
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("RootViewController") as! RootViewController
        self.presentViewController(next, animated: true, completion: nil)
        
    }

}
