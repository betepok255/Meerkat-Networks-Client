//
//  AutoscanSettingsTable.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 16.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

//
//  AutoscanSettingsTable.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 16.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class AutoscanSettingsTable: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    @IBOutlet var collectionView: UICollectionView?
    
    // Data
    var sDays = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    var timesScan: [[String]] = [["10.20","10.30","10.30","10.30"],
        ["10.21","10.30"],
        ["10.22","10.30"],
        ["10.23","10.30"],
        ["10.24","10.30"],
        ["10.25","10.30"],
        ["10.26","10.30","10.30","10.30","10.30","10.30"]
    ]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: 90, height: 90)
//        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate = self
//        collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
//        collectionView!.backgroundColor = UIColor.whiteColor()
//        self.view.addSubview(collectionView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! WeektableCollectionViewCell
        cell.backgroundColor = UIColor.greenColor()
        cell.labelDay.text = sDays[indexPath.row]
        
        cell.labelTime.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
        cell.labelTime.numberOfLines = timesScan[indexPath.row].count
        
        var text = ""
        for first in timesScan[indexPath.row] {
            if text != ""{
                text += "\n"
            }
            
            text += first
        }
        cell.labelTime.text = text
        
//        cell.textLabel?.text = "\(indexPath.section):\(indexPath.row)"
//        cell.imageView?.image = UIImage(named: "circle")
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
}
