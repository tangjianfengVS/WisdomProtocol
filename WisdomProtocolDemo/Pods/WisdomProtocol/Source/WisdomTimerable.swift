//
//  WisdomTimerable.swift
//  Pods
//
//  Created by 汤建锋 on 2022/11/24.
//

import UIKit


// MARK: Class Timerable Protocol
// * Support for objective-c/Swift Class
@objc public protocol WisdomTimerable {
    
    // MARK: Class Param - NSInteger, WisdomTimerable
    // * Timer task in progress, current time
    func timerable(timerDid currentTime: NSInteger, timerable: WisdomTimerable)
    
    // MARK: Class Param - WisdomTimerable
    // * Example End a scheduled task
    func timerable(timeEnd timerable: WisdomTimerable)
}

extension WisdomTimerable {
    
    // MARK: Class Param - NSInteger
    // * Start a timer task, start the timer time point
    public func startAddTimer(startTime: NSInteger){
        WisdomProtocolCore.startAddTimer(able: self, startTime: startTime)
    }
    
    // MARK: Class Param - NSInteger
    // * Start a countdown task, start the total time countdown 
    public func startDownTimer(totalTime: NSInteger){
        WisdomProtocolCore.startDownTimer(able: self, totalTime: totalTime)
    }
    
    // MARK: Class Timer - suspend
    public func suspendTimer(){
        WisdomProtocolCore.suspendTimer(able: self)
    }
    
    // MARK: Class Timer - resume
    public func resumeTimer(){
        WisdomProtocolCore.resumeTimer(able: self)
    }
    
    // MARK: Class Timer - destroy
    public func destroyTimer(){
        WisdomProtocolCore.destroyTimer(able: self)
    }
}


// MARK: Swift Type Timerable Protocol
// * Support for Swift Type: Class/enum/struct
public protocol WisdomSwiftTimerable {

    // MARK: Param - NSInteger, WisdomSwiftTimerable
    // * Timer task in progress, current time
    func timerable(swiftTimerDid currentTime: NSInteger, timerable: WisdomSwiftTimerable)
    
    // MARK: Param - WisdomSwiftTimerable
    // * Example End a scheduled task
    func timerable(swiftTimerDid timerable: WisdomSwiftTimerable)
}

extension WisdomSwiftTimerable {

    // MARK: Param - NSInteger
    // * Start a timer task, start the timer time point
    public func startAddTimer(startTime: NSInteger){
        let key = "\(unsafeBitCast(self, to: Int64.self))"
        assert(key.count>0, "unsafeBitCast failure: \(self)")
        if key.count > 0 {
            if let historyable = WisdomProtocolCore.getSwiftTimer(key: key) {
                historyable.destroy()
                WisdomProtocolCore.remSwiftTimer(key: key)
            }
            
            let sss = &self
            let timer = WisdomSwiftTimerModel(currentTime: startTime, isDown: false) { [weak self] currentTime in
//                if let timerable = self {
//                    timerable.timerable(swiftTimerDid: currentTime, timerable: timerable)
//                    return true
//                }
                return false
            } endClosure: {
                
            } destroyClosure: {
                WisdomProtocolCore.remSwiftTimer(key: key)
            }
            
            WisdomProtocolCore.setSwiftTimer(timer: timer, key: key)
        }
    }
    
    // MARK: Param - NSInteger
    // * Start a countdown task, start the total time countdown
    public func startDownTimer(totalTime: NSInteger){
        let key = "\(unsafeBitCast(self, to: Int64.self))"
        assert(key.count>0, "unsafeBitCast failure: \(self)")
        if key.count > 0 {
            if let historyable = WisdomProtocolCore.getSwiftTimer(key: key) {
                historyable.destroy()
                WisdomProtocolCore.remSwiftTimer(key: key)
            }
            
            let timer = WisdomSwiftTimerModel(currentTime: totalTime, isDown: false) { [weak self] currentTime in
//                if let timerable = self {
//                    timerable.timerable(swiftTimerDid: currentTime, timerable: timerable)
//                    return true
//                }
                return false
            } endClosure: {
                
            } destroyClosure: {
                WisdomProtocolCore.remSwiftTimer(key: key)
            }
            
            WisdomProtocolCore.setSwiftTimer(timer: timer, key: key)
        }
    }

    // MARK: Timer - suspend
    public func suspendTimer(){
//        WisdomProtocolCore.suspendTimer(swiftable: self)
    }

    // MARK: Timer - resume
    public func resumeTimer(){
//        WisdomProtocolCore.resumeTimer(swiftable: self)
    }

    // MARK: Timer - destroy
    public func destroyTimer(){
//        WisdomProtocolCore.destroyTimer(swiftable: self)
    }
}
