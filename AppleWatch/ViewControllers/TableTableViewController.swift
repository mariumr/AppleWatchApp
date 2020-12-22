//
//  TableTableViewController.swift
//  Marium_Assignment2
//
//  Created by Xcode User on 2020-11-30.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit
import WatchConnectivity

class TableTableViewController: UITableViewController,WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        <#code#>
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        <#code#>
    }
    

    let getData = GetData()
    var timer : Timer!
    @IBOutlet var myTable : UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.refreshTable), userInfo: nil, repeats: true);
        
        getData.jsonParser()
        
        
    }
    @objc func refreshTable(){
        if(getData.dbData != nil)
        {
            if (getData.dbData?.count)! > 0
            {
                self.myTable.reloadData()
                self.timer.invalidate()
            }
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
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
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if getData.dbData != nil
        {
            return (getData.dbData?.count)!
        }
        else
        {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // step 11 - configure cell, then move on to DetailsViewController
        // don't forget cell identifier in sb
        let tableCell : MyDataTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? MyDataTableViewCell ?? MyDataTableViewCell(style: .default, reuseIdentifier: "myCell")
        
        let row = indexPath.row
        let rowData = (getData.dbData?[row])! as NSDictionary
        
        tableCell.myimg.image = UIImage(named: "3.png")
        tableCell.carModel.text = rowData["Model"] as? String
        tableCell.carMake.text = rowData["Make"] as? String
        tableCell.carYear.text = rowData["Year"] as? String
        tableCell.carPrice.text = rowData["Price"] as? String
        tableCell.carUsedOrUsed.text = rowData["New/Used"] as? String
        tableCell.carColor.text = rowData["Color"] as? String
        
        
        return tableCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            let detailViewController = controllers[controllers.count-1]
                as? DetailsViewController
            detailViewController?.updateCar(getData : getData , select: indexPath.row)
        }
        
    }

}
