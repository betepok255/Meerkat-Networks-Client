//
//  AboutHostCell.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 27.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
