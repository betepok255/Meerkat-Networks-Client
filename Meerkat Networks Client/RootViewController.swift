//
//  HomeRootViewController.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 11/12/15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class RootViewController: DLHamburguerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        self.contentViewController = self.storyboard!.instantiateViewControllerWithIdentifier("HostListNavigationViewController") as UIViewController
        self.menuViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MenuViewController") as UIViewController
    }
}
