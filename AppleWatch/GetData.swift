//
//  GetData.swift
//  Marium_Assignment2
//
//  Created by Xcode User on 2020-11-30.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class GetData: NSObject {
    
    var dbData : [NSDictionary]?
    let myUrl = "http://rameezm.dev.fast.sheridanc.on.ca/mydata/sqlTojson.php" as String
    
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    func jsonParser() {
        
        guard let endpoint = URL(string: myUrl) else {
            print("Error creating endpoint")
            return
        }
       
        let request = URLRequest(url: endpoint)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let datastring = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(datastring!)
                guard let data = data else {
                    throw JSONError.NoData
                }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] else {
                    throw JSONError.ConversionFailed
                }
                print(json)
                self.dbData = json
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
            }.resume()
    }

}
