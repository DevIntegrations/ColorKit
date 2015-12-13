//
//  ColorWheel.swift
//  ColorKit
//
//  Created by James Wilson on 12/11/15.
//  Copyright © 2015 Interactive Relativity LLC. All rights reserved.
//

import Foundation
import UIKit

protocol ColorCircular {
    var sectors: Int { get set }
    var radius: CGFloat { get set }
    
    func drawRadial(context: CGContextRef, size: CGSize)
}


extension ColorCircular {
    func drawRadial(context: CGContextRef, size: CGSize) {
        UIColor.whiteColor().setFill()
        
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let angle: CGFloat = CGFloat(2.0 * M_PI) / CGFloat(sectors)
        
        var bezierPath: UIBezierPath?
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        
        for i in 0...self.sectors {
            let startAngle = CGFloat(i) * angle
            let endAngle = CGFloat(i + 1) * angle
            bezierPath = UIBezierPath(arcCenter: center, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            bezierPath?.addLineToPoint(center)
            bezierPath?.closePath()
            
            let hue = CGFloat(Double(i) / Double(self.sectors))
            let color = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
            color.setFill()
            color.setStroke()
            
            bezierPath?.fill()
            bezierPath?.stroke()
        }
    }
}



@IBDesignable
public class ColorWheel : UIView, ColorCircular {
    let borderWidth: CGFloat = 2.0
    public var sectors = 360
    public var radius: CGFloat = 0
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let minValue = min(self.bounds.size.width, self.bounds.size.height) / 2.0
        self.radius = minValue - max(0.0, self.borderWidth)
        
    }
    
    public override func drawRect(rect: CGRect) {
        let size = self.bounds.size
        let context = UIGraphicsGetCurrentContext()
        
        self.drawRadial(context!, size: size)
        
        let transparent = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.000)
        
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [UIColor.whiteColor().CGColor, transparent.CGColor], [0, 1])!
        
        let gradientOvalPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, size.width, size.height))
        CGContextSaveGState(context)
        gradientOvalPath.addClip()
        CGContextDrawRadialGradient(context, gradient,
            CGPointMake(center.x, center.y), 0.0,
            CGPointMake(center.x, center.y), radius,
            [CGGradientDrawingOptions.DrawsBeforeStartLocation, CGGradientDrawingOptions.DrawsAfterEndLocation])
        CGContextRestoreGState(context)
        
        UIGraphicsEndImageContext()
    }
    
    func colorWheelPointDistance(pointOne: CGPoint, pointTwo: CGPoint) -> CGFloat {
        let distanceX = exp(pointOne.x - pointTwo.x)
        let distanceY = exp(pointOne.y - pointTwo.y)
        
        return sqrt(distanceX + distanceY)
    }
    
    func drawRadialImage() {
//        if let imageView = self.colorImageView {
//            imageView.removeFromSuperview()
//            self.colorImageView = nil
//        }
//        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        /*
        Insert drawRect code here
        */

//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        self.colorImageView = UIImageView(image: image)
//        self.addSubview(self.colorImageView!)
    }
    
}