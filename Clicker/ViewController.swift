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
    
    //MARK: Outlets
    // << outlets >>
    
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
    
    //MARK: WCSessionDelegate
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print(message.description)
        
//        DispatchQueue.main.async {
//            tappedButton.setTitle(nameString, for: .normal)
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            tappedButton.setTitle(oldTitle, for: .normal)
//        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        guard activationState == .activated else {
            print("WCSession in not activated")
            return
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
//        session.sendMessage(messageDict, replyHandler: { (content: [String : Any]) -> Void in
//            print("Our counterpart sent something back. This is optional.")
//        }) { (error) -> Void in
//            print("We got an error from our watch device: \(error.localizedDescription)")
//        }
    }


}

