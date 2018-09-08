//
//  CustomInterfaceButton.swift
//  Clicker
//
//  Created by Andrew on 9/7/18.
//  Copyright © 2018 Andrii Halabuda. All rights reserved.
//

import WatchKit

@IBDesignable
class CustomInterfaceButton: WKInterfaceButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
//        self.layer.cornerRadius = cornerRadius
//        self.layer.borderWidth = borderWidth
        
    }
    
    
}
