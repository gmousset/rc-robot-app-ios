//
//  GMThrottle.swift
//  rc-robot
//
//  Created by Gwendal Mousset on 03/08/2016.
//  Copyright © 2016 com.github.gmousset. All rights reserved.
//

import UIKit
import CoreGraphics

@IBDesignable public class GMThrottle: UIControl {
    
    // line
    @IBInspectable public var lineColor: UIColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
    @IBInspectable public var lineWidth: CGFloat = 20.0
    @IBInspectable public var lineRadius: CGFloat = 0.0
    // button
    @IBInspectable public var buttonColor: UIColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
    @IBInspectable public var buttonSize: CGFloat = 20.0
    @IBInspectable public var buttonRadius: CGFloat = 0.0
    @IBInspectable public var buttonMinValue: Float = -1.0
    @IBInspectable public var buttonMaxValue: Float = 1.0
    @IBInspectable public var buttonDefaultValue: Float = 0.0
    
    public var buttonCurrentValue: Float {
        get {
            return self.valueFromY(self.yValue)
        }
        set (newVal) {
            self.yValue = self.yFromValue(newVal)
            self.setNeedsDisplay()
        }
    }
    
    private var coeffDir: Float = -0.5
    private var bDelta: Float = 0.5
    private var yValue: CGFloat = 0.0
    private var defaultYValue: CGFloat = 0.0
    private var minY: CGFloat = 0.0
    private var maxY: CGFloat = 0.0
    
    var viewSize:CGRect {
        get {
            let bounds = self.bounds
            return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width,bounds.size.height)
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func layoutSubviews() {
        self.minY = self.buttonSize / 2.0
        self.maxY = self.bounds.size.height - self.buttonSize / 2
        self.coeffDir = (Float(self.minY - self.maxY)) / (self.buttonMaxValue - self.buttonMinValue)
        self.bDelta = Float(self.maxY) - self.coeffDir * self.buttonMinValue
        self.yValue = CGFloat(self.coeffDir * self.buttonDefaultValue + self.bDelta)
        self.defaultYValue = yFromValue(self.buttonDefaultValue)
    }
    
    public override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextClearRect(ctx,rect)
        drawLine()
        drawButton()
    }
    
    private func yFromValue(value: Float) -> CGFloat {
        return CGFloat(self.coeffDir * self.buttonCurrentValue + self.bDelta)
    }
    
    private func valueFromY(y: CGFloat) -> Float {
        return (Float(y) - self.bDelta) / self.coeffDir
    }
    
    private func drawButton() {
        let rect = CGRectMake(self.bounds.size.width / 2 - self.buttonSize / 2, self.yValue - self.buttonSize / 2, buttonSize, buttonSize);
        let path = UIBezierPath(roundedRect: rect, cornerRadius: self.buttonRadius)
        buttonColor.setFill()
        path.fill()
    }
    
    private func drawLine() {
        let rect = CGRectMake(self.bounds.size.width / 2.0 - self.lineWidth / 2.0, self.minY, self.lineWidth, self.bounds.size.height - self.buttonSize)
        let bgPath = UIBezierPath(roundedRect: rect, cornerRadius: self.lineRadius)
        lineColor.setFill()
        bgPath.fill()
    }
    
    public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let loc = touch.locationInView(self)
            
            let y: CGFloat
            if loc.y < self.minY {
                y = self.minY
            } else if loc.y > self.maxY {
                y = self.maxY
            } else {
                y = loc.y
            }
            
            self.yValue = y
            self.sendActionsForControlEvents(.ValueChanged)
            self.setNeedsDisplay()
            
        }
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.yValue = self.defaultYValue
        self.sendActionsForControlEvents(.ValueChanged)
        self.setNeedsDisplay()
    }
}
