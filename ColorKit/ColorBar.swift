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
    @IBInspectable var step: CGFloat = 0.2
    @IBInspectable var horizontal: Bool = true
    
    override func drawRect(rect: CGRect) {
        let size = self.bounds.size
        UIGraphicsGetCurrentContext()
        
        var bezierPath: UIBezierPath?
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        
        
        let limit = horizontal ? size.width : size.height
        for var i: CGFloat = 0; i < limit; i = i + step {
            
            var slice: CGRect
            var hue: CGFloat
            if horizontal {
                slice = CGRect(x: i, y: 0, width: i, height: size.height)
                hue = i / size.width
            } else {
                slice = CGRect(x: 0, y: i, width: size.width, height: i)
                hue = i / size.height
            }
            
            bezierPath = UIBezierPath(rect: slice)
            
            bezierPath?.addLineToPoint(center)
            bezierPath?.closePath()
            
            
            let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
            
            color.setFill()
            bezierPath?.fill()
        }
    }
}
