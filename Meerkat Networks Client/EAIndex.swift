//
//  EAIndex.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 11/14/15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class EAIndexViewController: UITabBarController {
    @IBOutlet weak var EATabBar: UITabBar!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tabBar.items?[0].image = UIImage.fontAwesomeIconWithName(.History, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        self.tabBar.items?[1].image = UIImage.fontAwesomeIconWithName(.Search, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        self.tabBar.items?[2].image = UIImage.fontAwesomeIconWithName(.Cogs, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        
        menuButton.image = UIImage.fontAwesomeIconWithName(.Bars, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuButtonTouched(sender: AnyObject) {
        self.findHamburguerViewController()?.showMenuViewController()
    }
    
}
