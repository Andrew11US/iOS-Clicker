//
//  InterfaceController.swift
//  ClickerW Extension
//
//  Created by Andrew on 5/23/18.
//  Copyright © 2018 Andrii Halabuda. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    // MARK: session property
    let session: WCSession!
    var value: Int? = defaults.integer(forKey: "Stored")

    //MARK: IB Outlets
    @IBOutlet var outputLbl: WKInterfaceLabel!
    @IBOutlet var clickBtn: WKInterfaceButton!
    
    //MARK: Init
    override init() {
        if(WCSession.isSupported()) {
            session =  WCSession.default
        } else {
            session = nil
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if value != nil {
            self.outputLbl.setText(String(value!))
            
        } else {
            defaults.set(0, forKey: "Stored")
            self.outputLbl.setText(String(value!))
        }
    }
    
    override func willActivate() {
        super.willActivate()
        
        //MARK: Checking if session is supported
        if (WCSession.isSupported()) {
            session.delegate = self
            session.activate()
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    // MARK: WCSession Delegate
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        guard activationState == .activated else {
            print("WCSession is not activated")
            return
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("Message from iPhone")
        
        if let valueIOS = message["value"] as! String? {
            let valueInt = Int(valueIOS)
            
            DispatchQueue.main.async {
                self.outputLbl.setText(valueIOS)
                defaults.set(valueInt!, forKey: "Stored")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.outputLbl.setText(String(self.value!))
                defaults.set(valueInt!, forKey: "Stored")
            }
        }
    }
    
    @IBAction func clicked() {
        
        if value != nil {
            value! -= 1
            self.outputLbl.setText(String(value!))
            defaults.set(value!, forKey: "Stored")
        }
        
        if (WCSession.isSupported()) {
            
            let messageDictionary = ["value": String(value!)]
            session.sendMessage(messageDictionary, replyHandler: { (content: [String: Any]) -> Void in
                print("Our counterpart sent something back. This is optional")
            }, errorHandler: { (error) -> Void in
                print("We got an error from our paired device : \(error.localizedDescription)")
            })
        }
    }
    
    @IBAction func added() {
        
        if value != nil {
            value! += 1
            self.outputLbl.setText(String(value!))
            defaults.set(value!, forKey: "Stored")
        }
        
        if (WCSession.isSupported()) {
            
            let messageDictionary = ["value": String(value!)]
            session.sendMessage(messageDictionary, replyHandler: { (content: [String: Any]) -> Void in
                print("Our counterpart sent something back. This is optional")
            }, errorHandler: { (error) -> Void in
                print("We got an error from our paired device : \(error.localizedDescription)")
            })
        }
    }
    

}
