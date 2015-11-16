//
//  AutoscanListCell.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 16.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class SettingsListCell: UITableViewCell {
    
    @IBOutlet weak var labelUrl: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
