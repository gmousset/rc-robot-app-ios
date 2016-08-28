//
//  RCViewModel.swift
//  rc-robot
//
//  Created by Gwendal Mousset on 03/08/2016.
//  Copyright © 2016 com.github.gmousset. All rights reserved.
//

import RxSwift

public class RCViewModel {
    
    private let robot = Robot()
    public let rightSpeedObs: Observable<Int>
    public let leftSpeedObs: Observable<Int>
    
    init() {
        self.rightSpeedObs = self.robot.rightSpeed
        self.leftSpeedObs = self.robot.leftSpeed
    }
    
    public func setSpeed(leftSpeed: Int, rightSpeed: Int) {
        self.robot.setEnginesSpeed(leftSpeed, rightSpeed: rightSpeed)
    }
}
