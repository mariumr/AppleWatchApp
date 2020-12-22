//
//  DetailsViewController.swift
//  Marium_Assignment2
//
//  Created by Xcode User on 2020-11-30.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var lblMake : UILabel!
    @IBOutlet var lblModel : UILabel!
    @IBOutlet var lblYear : UILabel!
    @IBOutlet var lblColor : UILabel!
    @IBOutlet var lblNewOrused : UILabel!
    @IBOutlet var lblPrice : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func updateCar(getData : GetData, select : Int)
    {
        let rowData = (getData.dbData?[select])! as NSDictionary
        
        self.lblMake.text = rowData["Make"] as? String
        self.lblModel.text = rowData["Model"] as? String
        self.lblYear.text = rowData["Year"] as? String
        self.lblColor.text = rowData["Color"] as? String
        self.lblNewOrused.text = rowData["New/Used"] as? String
        self.lblPrice.text = rowData["Price"] as? String

        
    }
 
}
