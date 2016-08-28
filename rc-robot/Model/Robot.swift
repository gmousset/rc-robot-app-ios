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
    //private let speedsObservable: Observable<Int>
    
    init() {
        let _ = Observable.combineLatest(
            self.leftSpeed.distinctUntilChanged().debounce(0.5, scheduler: MainScheduler.instance),
            self.leftSpeed.distinctUntilChanged().debounce(0.5, scheduler: MainScheduler.instance)) { (ls, rs) -> Void in
                print("left:\(ls) right:\(rs)")
        }
    }
    
    public func setEnginesSpeed(leftSpeed: Int, rightSpeed: Int) {
        self.leftSpeed.onNext(leftSpeed)
        self.rightSpeed.onNext(rightSpeed)
    }
}
