//
//  ViewController.swift
//  rc-robot
//
//  Created by Gwendal Mousset on 23/07/2016.
//  Copyright © 2016 com.github.gmousset. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class RCViewController: UIViewController {
    @IBOutlet var throttleLeft: GMThrottle!
    @IBOutlet var throttleRight: GMThrottle!
    @IBOutlet var labelLeft: UILabel!
    @IBOutlet var labelRight: UILabel!
    
    private let viewModel = RCViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tcpClient = TcpClient()
        //self.tcpClient.connect()

        self.viewModel.leftSpeedObs.map { "\($0)%" }.bindTo(self.labelLeft.rx_text).addDisposableTo(self.bag)
        self.viewModel.rightSpeedObs.map { "\($0)%" }.bindTo(self.labelRight.rx_text).addDisposableTo(self.bag)
    }
    
    @IBAction func valueChanged(let throttle: GMThrottle) {
        self.viewModel.setSpeed(Int(self.throttleLeft.buttonCurrentValue), rightSpeed: Int(self.throttleRight.buttonCurrentValue))
    }
    
    @IBAction func closeConnection() {
        //self.tcpClient.close()
    }
}

