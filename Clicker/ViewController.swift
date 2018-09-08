//
//  ViewController.swift
//  Clicker
//
//  Created by Andrew on 5/23/18.
//  Copyright © 2018 Andrii Halabuda. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    //MARK: Properties
    let session: WCSession!
    var value: Int? = IOS_DEFAULTS.integer(forKey: "Stored")
    
    //MARK: Outlets
    @IBOutlet weak var dataLbl: UILabel!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    //MARK: Init
    required init?(coder aDecoder: NSCoder) {
        self.session = WCSession.default
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if value != nil {
            self.dataLbl.text = String(value!)
            
        } else {
            IOS_DEFAULTS.set(0, forKey: "Stored")
            self.dataLbl.text = String(value!)
        }
    }
    
    //MARK: WCSessionDelegate
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print(message.description)
        
        print(message.description)
        
        let value = message["value"] as! String
        let valueInt = Int(value)
        
        DispatchQueue.main.async {
            self.dataLbl.text = String(value)
            IOS_DEFAULTS.set(valueInt!, forKey: "Stored")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dataLbl.text = String(value)
            IOS_DEFAULTS.set(valueInt!, forKey: "Stored")
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        guard activationState == .activated else {
            print("WCSession in not activated")
            return
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session become Inactive!")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Session has been deactivated!")
    }
    
    @IBAction func minusTapped(_ sender: UIButton) {
        
        var messageDictionary = [String : String]()
        
        if value != nil {
            value! -= 1
            self.dataLbl.text = String(value!)
            IOS_DEFAULTS.set(value!, forKey: "Stored")
            
            messageDictionary = ["value" : String(value!)]
        }
        
        session.sendMessage(messageDictionary, replyHandler: { (content: [String : Any]) -> Void in
            print("Our counterpart sent something back. This is optional.")
        }) { (error) -> Void in
            print("We got an error from our watch device: \(error.localizedDescription)")
        }
    }
    
    @IBAction func addTapped(_ sender: UIButton) {
        
        var messageDictionary = [String : String]()
        
        if value != nil {
            value! += 1
            self.dataLbl.text = String(value!)
            IOS_DEFAULTS.set(value!, forKey: "Stored")
            
            messageDictionary = ["value" : String(value!)]
        }
        
        session.sendMessage(messageDictionary, replyHandler: { (content: [String : Any]) -> Void in
            print("Our counterpart sent something back. This is optional.")
        }) { (error) -> Void in
            print("We got an error from our watch device: \(error.localizedDescription)")
        }
    }


}

