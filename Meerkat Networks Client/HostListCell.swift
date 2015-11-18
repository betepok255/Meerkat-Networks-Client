//
//  HostListCell.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 11/12/15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

class HostListCell: UITableViewCell {
    
    @IBOutlet weak var labelHost: UILabel!
    @IBOutlet weak var labelIsConnected: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelIp: UILabel!
    @IBOutlet weak var imageViewCheck: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
