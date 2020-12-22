//
//  MyDataTableViewCell.swift
//  Marium_Assignment2
//
//  Created by Xcode User on 2020-11-30.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class MyDataTableViewCell: UITableViewCell {

     @IBOutlet var carMake : UILabel!
     @IBOutlet var carModel : UILabel!
     @IBOutlet var carColor : UILabel!
     @IBOutlet var carYear : UILabel!
     @IBOutlet var carPrice : UILabel!
     @IBOutlet var carUsedOrUsed : UILabel!
     @IBOutlet var myimg : UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
