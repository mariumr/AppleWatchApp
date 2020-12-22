//
//  ProgramObject.swift
//  Marium_Assignment2
//
//  Created by Xcode User on 2020-11-27.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class ProgramObject: NSObject {

    var Make : String?
    var Model : String?
    var Year : String?
    var Colour : String?
    var NewOrUsed : String?
    var Price : String?
    
    func initWithData( Make: String,
                       Model: String,
                       Year: String,
                       Colour: String,
                       NewOrUsed : String,
                       Price: String) {
        self.Make = Make
        self.Model = Model
        self.Year = Year
        self.Colour = Colour
        self.NewOrUsed = NewOrUsed
        self.Price = Price
    }
   
    required convenience init?(coder decoder: NSCoder) {
        guard let Make = decoder.decodeObject(forKey: "Make") as? String,
            let Model = decoder.decodeObject(forKey: "Model") as? String,
            let Year = decoder.decodeObject(forKey: "Year") as? String,
            let Colour = decoder.decodeObject(forKey: "Colour") as? String,
            let NewOrUsed = decoder.decodeObject(forKey: "newOrUsed") as? String,
            let Price = decoder.decodeObject(forKey: "price") as? String
            else { return nil }
    
        self.init()
        self.initWithData(
            Make: Make as String,
            Model : Model as String,
            Year: Year as! String,
            Colour : Colour as! String,
            NewOrUsed : NewOrUsed as String,
            Price : Price as String
        )
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.Make, forKey: "Make")
        coder.encode(self.Model, forKey: "Model")
        coder.encode(self.Year , forKey: "Year")
        coder.encode(self.Colour , forKey: "Colour")
        coder.encode(self.NewOrUsed, forKey: "NewOrUsed")
        coder.encode(self.Price, forKey: "Price")
    }
    
    
    
}
