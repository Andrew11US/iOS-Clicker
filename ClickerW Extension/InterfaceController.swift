//
//  InterfaceController.swift
//  ClickerW Extension
//
//  Created by Andrew on 5/23/18.
//  Copyright © 2018 Andrii Halabuda. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var outputLbl: WKInterfaceLabel!
    @IBOutlet var clickBtn: WKInterfaceButton!
    
    var value: Int? = defaults.integer(forKey: "Stored")
    
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
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func clicked() {
        
        if value != nil {
            value! -= 1
            self.outputLbl.setText(String(value!))
            defaults.set(value!, forKey: "Stored")
        }
        
    }
    
    @IBAction func added() {
        
        if value != nil {
            value! += 1
            self.outputLbl.setText(String(value!))
            defaults.set(value!, forKey: "Stored")
        }
        
    }
    

}
