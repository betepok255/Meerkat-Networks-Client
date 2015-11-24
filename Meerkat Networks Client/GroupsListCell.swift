//
//  CategoriesListCell.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 23.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//


import UIKit

class GroupsListCell: UITableViewCell {
    
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var vulnerabilityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
