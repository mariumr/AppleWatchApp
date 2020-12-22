//
//  ProgramInterfaceController.swift
//  Marium_Assignment2 WatchKit Extension
//
//  Created by Xcode User on 2020-11-29.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class ProgramInterfaceController: WKInterfaceController, WCSessionDelegate {
    @IBOutlet var progTable : WKInterfaceTable!
    var programs : [ProgramObject] = []
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        var replyValues = Dictionary<String, AnyObject>()
        
        let loadedData = message["progData"]
        
        let loadedPerson = NSKeyedUnarchiver.unarchiveObject(with: loadedData as! Data) as? [ProgramObject]
        
        programs = loadedPerson!
        
        replyValues["status"] = "Program Received" as AnyObject?
        replyHandler(replyValues)
    }
    
    // step 6b - check to see if watch can connect with iPhone
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            
            
        }
        
    }
    
    override func willActivate() {
        super.willActivate()
        
        if (WCSession.default.isReachable) {
            
            let message = ["getProgData": [:]]
            WCSession.default.sendMessage(message, replyHandler: { (result) -> Void in
               
                
                if result["progData"] != nil
                {
                    let loadedData = result["progData"]
                    
                
                    NSKeyedUnarchiver.setClass(ProgramObject.self, forClassName: "ProgramObject")
                   
                    let loadedPerson = NSKeyedUnarchiver.unarchiveObject(with: loadedData as! Data) as? [ProgramObject]
                    
                    self.programs = loadedPerson!
                    
                    self.progTable.setNumberOfRows(self.programs.count,
                                                   withRowType: "ProgRowController")
                
                    for (index,prog) in self.programs.enumerated() {
                        let row = self.progTable.rowController(at: index) as! ProgRowController
                        
                        row.lblMake.setText(prog.Make)
                        row.lblModel.setText(prog.Model)
                        row.lblYear.setText(prog.Year)
                        row.lblColor.setText(prog.Colour)
                        
                        
                    }
                }
                
            }, errorHandler: { (error) -> Void in
                
                print(error)
            })
            
        }
        
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
}

