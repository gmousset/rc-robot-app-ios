//
//  LayerViewController.swift
//  rc-robot
//
//  Created by Gwendal Mousset on 04/08/2016.
//  Copyright © 2016 com.github.gmousset. All rights reserved.
//

import UIKit

class LayerViewController: UIViewController {

//    @IBOutlet weak var someView: UIView!
    
//    var l: CALayer {
//        return viewForLayer.layer
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    func setUpLayer() {
//        // 1
//        let layer = CALayer()
//        layer.frame = someView.bounds
//        
//        // 2
//        layer.contents = UIImage(named: "star")?.CGImage
//        layer.contentsGravity = kCAGravityCenter
//        
//        // 3
//        layer.magnificationFilter = kCAFilterLinear
//        layer.geometryFlipped = false
//        
//        // 4
//        layer.backgroundColor = UIColor(red: 11/255.0, green: 86/255.0, blue: 14/255.0, alpha: 1.0).CGColor
//        layer.opacity = 1.0
//        layer.hidden = false
//        layer.masksToBounds = false
//        
//        // 5
//        layer.cornerRadius = 100.0
//        layer.borderWidth = 12.0
//        layer.borderColor = UIColor.whiteColor().CGColor
//        
//        // 6
//        layer.shadowOpacity = 0.75
//        layer.shadowOffset = CGSize(width: 0, height: 3)
//        layer.shadowRadius = 3.0
//        someView.layer.addSublayer(layer)
//    }
    
//    func setUpLayer() {
//        l.backgroundColor = UIColor.blueColor().CGColor
//        l.borderWidth = 100.0
//        l.borderColor = UIColor.redColor().CGColor
//        l.shadowOpacity = 0.7
//        l.shadowRadius = 10.0
//        l.contents = UIImage(named: "star")?.CGImage
//        l.contentsGravity = kCAGravityCenter
//    }
    
//    @IBAction func didTap(sender: UITapGestureRecognizer) {
//        l.shadowOpacity = l.shadowOpacity == 0.7 ? 0.0 : 0.7
//    }
//    
//    @IBAction func didPinch(sender: UIPinchGestureRecognizer) {
//        let offset: CGFloat = sender.scale < 1 ? 5.0 : -5.0
//        let oldFrame = l.frame
//        let oldOrigin = oldFrame.origin
//        let newOrigin = CGPoint(x: oldOrigin.x + offset, y: oldOrigin.y + offset)
//        let newSize = CGSize(width: oldFrame.width + (offset * -2.0), height: oldFrame.height + (offset * -2.0))
//        let newFrame = CGRect(origin: newOrigin, size: newSize)
//        if newFrame.width >= 100.0 && newFrame.width <= 300.0 {
//            l.borderWidth -= offset
//            l.cornerRadius += (offset / 2.0)
//            l.frame = newFrame
//        }
//    }
}
