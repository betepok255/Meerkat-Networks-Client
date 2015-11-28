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
    
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.myActivityIndicator.center = self.view.center
        view.addSubview(myActivityIndicator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBAction func OnClickLoginButton(sender: AnyObject) {
        self.myActivityIndicator.startAnimating()
        
        let parameters = ["login": login.text!, "password" :  password.text!]
        
        Alamofire.request(.POST, APIUrl.Login.rawValue, parameters: parameters)
            .responseString { response in
        
                self.myActivityIndicator.stopAnimating()
                
                if (response.response!.statusCode == 200){
                    
                    SingletonDB.sharedInstance.token = response.result.value!
                    SingletonDB.sharedInstance.userEmail = self.login.text!
                    
                    let next = self.storyboard?.instantiateViewControllerWithIdentifier("RootViewController") as! RootViewController
                    self.presentViewController(next, animated: true, completion: nil)
                    
                } else {
                    let alert = UIAlertController(title: "Error", message: "Login or password incorrect!", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
        }
        
        
    }
    
}
