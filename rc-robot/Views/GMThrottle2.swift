//
//  GMThrottle2.swift
//  rc-robot
//
//  Created by Gwendal Mousset on 04/08/2016.
//  Copyright © 2016 com.github.gmousset. All rights reserved.
//

import UIKit

@IBDesignable public class GMThrottle2: UIControl {
    
    // line
    @IBInspectable public var lineColor: UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    @IBInspectable public var lineWidth: CGFloat = 20.0
    @IBInspectable public var lineCornerRadius: CGFloat = 0.0
    @IBInspectable public var lineBorderColor: UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    @IBInspectable public var lineBorderWidth: CGFloat = 0.0
    // button
    @IBInspectable public var buttonColor: UIColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
    @IBInspectable public var buttonSize: CGFloat = 20.0
    @IBInspectable public var buttonCornerRadius: CGFloat = 0.0
    @IBInspectable public var buttonBorderColor: UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    @IBInspectable public var buttonBorderWidth: CGFloat = 0.0
    // range
    @IBInspectable public var minValue: Float = -1.0
    @IBInspectable public var maxValue: Float = 1.0
    @IBInspectable public var defaultValue: Float = 0.0
    
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
    
    private var buttonLayer: CAShapeLayer!
    private var lineLayer: CALayer!
    
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
        self.setupParams()
        self.setupLayers()
    }
    
    private func setupParams() {
        self.minY = self.buttonSize / 2.0
        self.maxY = self.bounds.size.height - self.buttonSize / 2
        self.coeffDir = (Float(self.minY - self.maxY)) / (self.maxValue - self.minValue)
        self.bDelta = Float(self.maxY) - self.coeffDir * self.minValue
        self.yValue = CGFloat(self.coeffDir * self.defaultValue + self.bDelta)
        self.defaultYValue = yFromValue(self.defaultValue)
    }
    
    private func setupLayers() {
        self.setupLine()
        self.setupButtonLayer()
    }
    
    private func setupButtonLayer() {
        self.buttonLayer = CAShapeLayer()
        self.refreshButtonPosition()
        self.buttonLayer.backgroundColor = self.buttonColor.CGColor
        self.buttonLayer.fillColor = self.buttonColor.CGColor
        self.buttonLayer.strokeColor = self.buttonBorderColor.CGColor
//        self.buttonLayer.strokeStart = 0.2
//        self.buttonLayer.strokeEnd = 0.8
//        self.buttonLayer.borderColor = self.buttonBorderColor.CGColor
//        self.buttonLayer.borderWidth = self.buttonBorderWidth
        self.buttonLayer.lineWidth = self.buttonBorderWidth
        self.layer.addSublayer(self.buttonLayer)
    }
    
    private func refreshButtonPosition() {
        let rect = CGRectMake(self.bounds.size.width / 2 - self.buttonSize / 2, self.yValue - self.buttonSize / 2, buttonSize, buttonSize);
        let path = UIBezierPath(roundedRect: rect, cornerRadius: self.buttonCornerRadius)
        self.buttonLayer.path = path.CGPath
    }
    
    private func setupLine() {
        self.lineLayer = CALayer()
        let rect = CGRectMake(self.bounds.size.width / 2.0 - self.lineWidth / 2.0, self.minY, self.lineWidth, self.bounds.size.height - self.buttonSize)
        self.lineLayer.frame = rect
        self.lineLayer.cornerRadius = self.lineCornerRadius
        self.lineLayer.backgroundColor = self.lineColor.CGColor
        self.lineLayer.borderColor = self.lineBorderColor.CGColor
        self.lineLayer.borderWidth = self.lineBorderWidth
        self.layer.addSublayer(self.lineLayer)
    }
    
    private func yFromValue(value: Float) -> CGFloat {
        return CGFloat(self.coeffDir * self.buttonCurrentValue + self.bDelta)
    }
    
    private func valueFromY(y: CGFloat) -> Float {
        return (Float(y) - self.bDelta) / self.coeffDir
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
            self.refreshButtonPosition()
        }
    }
}

