//
//  CustomTableView.swift
//  Ausway
//
//  Created by Chandan Singh on 16/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
// 
// A Custom Table view for Next 5 Skybus Data

import UIKit
class NextTableView: UITableViewCell {
    
    
    @IBOutlet weak var vehicalImage: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated:animated)
    }
}
