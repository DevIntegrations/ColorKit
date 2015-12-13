//
//  ColorBar.swift
//  ColorKit
//
//  Created by James Wilson on 12/13/15.
//  Copyright © 2015 Interactive Relativity LLC. All rights reserved.
//

import UIKit

@IBDesignable
class ColorBar: UIView {
    var step: CGFloat = 0.2
    
    
    override func drawRect(rect: CGRect) {
        let size = self.bounds.size
        UIGraphicsGetCurrentContext()
        
        var bezierPath: UIBezierPath?
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        
        for var i: CGFloat = 0; i < size.width; i = i + step {

            bezierPath = UIBezierPath(rect: CGRect(x: CGFloat(i), y: 0, width: 1, height: size.height))
            
            bezierPath?.addLineToPoint(center)
            bezierPath?.closePath()
            
            let hue = i / size.width
            let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
            
            color.setFill()
            bezierPath?.fill()
        }
    }
}
