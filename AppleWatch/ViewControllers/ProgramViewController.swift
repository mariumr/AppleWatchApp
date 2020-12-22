//
//  ProgramViewController.swift
//  Marium_Assignment2
//
//  Created by Xcode User on 2020-11-27.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit
import WatchConnectivity

class ProgramViewController: UIViewController, UITableViewDelegate , UITableViewDataSource , WCSessionDelegate{

    var programs : [ProgramObject] = [ ]
    var lastMessage : CFAbsoluteTime = 0
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        var replyValues = Dictionary<String, AnyObject>()
        
        
        if (message["getProgData"] != nil)
        {
            NSKeyedArchiver.setClassName("ProgramObject", for: ProgramObject.self)
            let programData = NSKeyedArchiver.archivedData(withRootObject: programs)
            replyValues["progData"] = programData as AnyObject?
            replyHandler(replyValues)
        }
    }
    
    func initCarDetails()  {
    
    let progObj = ProgramObject()
    progObj.initWithData(Make: "Ford", Model: "Fusion", Year: "2015", Colour: "Red", NewOrUsed: "Used", Price: "50000")
        
    let progObj2 = ProgramObject()
        progObj2.initWithData(Make: "Honda", Model: "Civic", Year: "2013", Colour: "Black", NewOrUsed: "New", Price: "11000")
        
        //Add database objects here....
        programs.insert(progObj, at: 0)
        programs.insert(progObj2, at: 1)
        
    }
    
    func sendWatchMessage(_ msgData:Data) {
        let currentTime = CFAbsoluteTimeGetCurrent()
    
        if lastMessage + 0.5 > currentTime {
            return
        }
        
      
        if (WCSession.default.isReachable) {
            
            let message = ["progData": msgData]
            WCSession.default.sendMessage(message, replyHandler: nil)
        }
        
        lastMessage = CFAbsoluteTimeGetCurrent()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            
            if session.isPaired != true {
                print("Apple Watch is not paired")
            }
            
            if session.isWatchAppInstalled != true {
                print("WatchKit app is not installed")
            }
        } else {
            print("WatchConnectivity is not supported on this device")
        }
        
        
        initCarDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell : ProgramTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProgramCell") as? ProgramTableViewCell ??
            ProgramTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ProgramCell")
        
        var row = indexPath.row
        var rowObj = programs[row]
        
        tableCell.make.text = rowObj.Make as String?
        tableCell.model.text = rowObj.Model as String?
        tableCell.year.text = rowObj.Year as String?
        tableCell.color.text = rowObj.Colour as String?
        tableCell.newOrUsed.text = rowObj.NewOrUsed as String?
        tableCell.price.text = rowObj.Price as String?
        
        return tableCell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        
    }
    
   
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
        
    }
}
