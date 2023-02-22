//
//  RoundedButton.swift
//  SB_11_Custom_UI_Component
//
//  Created by Maria Nosova on 8/17/22.
//  Copyright © 2022 Andrey Nosov. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {
    var isSetuped = false
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layoutIfNeeded()
        }
    }
    @IBInspectable public var borderColor: UIColor? = nil {
        didSet {
            layer.borderColor = borderColor?.cgColor ?? tintColor.cgColor
        }
    }

    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor ?? tintColor.cgColor
        if cornerRadius > 0 {
                   layer.masksToBounds = true
               }
        //we check if we already added the elements, if not, we add them once
        if isSetuped {return}
        isSetuped = true
        //this code only performces once
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
