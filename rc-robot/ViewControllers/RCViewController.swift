//
//  ViewController.swift
//  rc-robot
//
//  Created by Gwendal Mousset on 23/07/2016.
//  Copyright © 2016 com.github.gmousset. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import FOGMJPEGImageView


class RCViewController: UIViewController {
    
    @IBOutlet var throttleLeft: GMThrottle!
    @IBOutlet var throttleRight: GMThrottle!
    @IBOutlet var labelLeft: UILabel!
    @IBOutlet var labelRight: UILabel!
    @IBOutlet var mjpegView: FOGMJPEGImageView!
    @IBOutlet var videoSwitch: UISwitch!
    
    private let viewModel = RCViewModel()
    private let bag = DisposeBag()
    private let streamUrl = NSURL(string: "http://192.168.1.203:9000/stream/video.mjpeg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.leftSpeedObs.map { "\($0)%" }.bindTo(self.labelLeft.rx_text).addDisposableTo(self.bag)
        self.viewModel.rightSpeedObs.map { "\($0)%" }.bindTo(self.labelRight.rx_text).addDisposableTo(self.bag)
        
        self.videoSwitch.rx_value.bindNext { isOn in
            if isOn {
                if let url = self.streamUrl {
                    self.mjpegView.startWithURL(url)
                    self.mjpegView.hidden = false
                } else {
                    self.mjpegView.hidden = true
                    self.mjpegView.stop()
                }
            } else {
                self.mjpegView.hidden = true
                self.mjpegView.stop()
            }
        }.addDisposableTo(self.bag)
    }
    
    @IBAction func valueChanged(let throttle: GMThrottle) {
        self.viewModel.setSpeed(Int(self.throttleLeft.buttonCurrentValue), rightSpeed: Int(self.throttleRight.buttonCurrentValue))
    }
    
    @IBAction func closeConnection() {
        
    }
}


