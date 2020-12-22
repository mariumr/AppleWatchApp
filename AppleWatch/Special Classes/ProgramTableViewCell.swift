//
//  ProgramTableViewCell.swift
//  Marium_Assignment2
//
//  Created by Xcode User on 2020-11-27.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class ProgramTableViewCell: UITableViewCell {

    @IBOutlet var make : UILabel!
    @IBOutlet var model : UILabel!
    @IBOutlet var year : UILabel!
    @IBOutlet var color : UILabel!
    @IBOutlet var newOrUsed : UILabel!
    @IBOutlet var price : UILabel!
    @IBOutlet var img : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
