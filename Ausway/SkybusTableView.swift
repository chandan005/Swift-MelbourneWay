//
//  SkybusTableView.swift
//  Ausway
//
//  Created by Chandan Singh on 21/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
// // A Custom Table view for all the Skybus Data

import UIKit
class SkybusTableView: UITableViewCell {
    
    
    

    @IBOutlet weak var mainLabel: UILabel!

    
    @IBOutlet weak var subtitleLabel: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated:animated)
    }
}

