//
//  ColorDonut.swift
//  ColorKit
//
//  Created by James Wilson on 12/13/15.
//  Copyright © 2015 Interactive Relativity LLC. All rights reserved.
//

import UIKit

public class ColorDonut: UIView, ColorCircular {

    let borderWidth: CGFloat = 2.0
    public var sectors = 360
    public var radius: CGFloat = 0
    
    var innerRadius: CGFloat = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupColorWheelView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupColorWheelView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.calculateRadius(self.bounds.size)
        self.innerRadius = self.radius - 20
        
        print("Radius: \(radius) and Inner: \(self.innerRadius)")
    }
    
    public override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        self.drawRadial(context, size: self.bounds.size)
        
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor);
        CGContextSetBlendMode(context, CGBlendMode.Clear);
        
        let innerPoint = self.radius - self.innerRadius + borderWidth
        let innerSize = self.innerRadius * 2
        let hole = CGRect(x: innerPoint, y: innerPoint, width: innerSize, height: innerSize)
        CGContextFillEllipseInRect(context, hole);
        
        UIGraphicsEndImageContext()
    }
    
    func colorWheelPointDistance(pointOne: CGPoint, pointTwo: CGPoint) -> CGFloat {
        let distanceX = exp(pointOne.x - pointTwo.x)
        let distanceY = exp(pointOne.y - pointTwo.y)
        
        return sqrt(distanceX + distanceY)
    }
    
    private func setupColorWheelView() {
        self.backgroundColor = UIColor.clearColor()
    }

}
