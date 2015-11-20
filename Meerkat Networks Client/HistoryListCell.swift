//
//  HistoryCell.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 16.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class HistoryListCell: UITableViewCell {
    
    @IBOutlet weak var labelUrl: UILabel!
    @IBOutlet weak var labelCritical: UILabel!
    @IBOutlet weak var labelInformational: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
