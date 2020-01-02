//
//  Robot.swift
//  rc-robot
//
//  Created by Gwendal Mousset on 03/08/2016.
//  Copyright © 2016 com.github.gmousset. All rights reserved.
//

import RxSwift

public class Robot {
    
    public let leftSpeed = BehaviorSubject<Int>(value: 0)
    public let rightSpeed = BehaviorSubject<Int>(value: 0)
    
    private let client: TcpClient
    
    init() {
        self.client = TcpClient()
        self.client.connect()
        
        let _ = Observable.combineLatest(
            self.leftSpeed.distinctUntilChanged().debounce(0.05, scheduler: MainScheduler.instance),
            self.rightSpeed.distinctUntilChanged().debounce(0.05, scheduler: MainScheduler.instance)) { ($0, $1) }
            .bindNext({ (ls, rs) in
                self.client.updateSpeed(ls, speedRight: rs)
            })
    }
    
    public func setEnginesSpeed(leftSpeed: Int, rightSpeed: Int) {
        self.leftSpeed.onNext(leftSpeed)
        self.rightSpeed.onNext(rightSpeed)
    }
}
