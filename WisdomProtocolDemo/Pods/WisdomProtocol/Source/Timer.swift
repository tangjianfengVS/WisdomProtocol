//
//  Timer.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/24.
//

import UIKit


// MARK: Class Timerable Protocol
// * Support for objective-c/Swift Class
@objc public protocol WisdomTimerable {
    
    // MARK: Class Param - UInt, WisdomTimerable
    // * Timer task in progress, current time
    @objc func timerable(timerDid currentTime: UInt, timerable: WisdomTimerable)
    
    // MARK: Class Param - WisdomTimerable
    // * Example End a scheduled task
    @objc func timerable(timerEnd timerable: WisdomTimerable)
    
    // MARK: Class Param - NSInteger. < No need to implement >
    // * Start a forward timer task, start the forward time point
    @objc optional func startForwardTimer(startTime: UInt)
    
    // MARK: Class Param - NSInteger. < No need to implement >
    // * Start a countdown timer task, start the total time countdown
    @objc optional func startDownTimer(totalTime: UInt)
    
    // MARK: Class Timer - suspend. < No need to implement >
    //@objc optional func suspendTimer()
    
    // MARK: Class Timer - resume. < No need to implement >
    //@objc optional func resumeTimer()
    
    // MARK: Class Timer - destroy. < No need to implement >
    // Destruction/Release timer task
    @objc optional func destroyTimer()
}

extension WisdomTimerable {
    
    public func startForwardTimer(startTime: UInt){
        WisdomProtocolCore.startForwardTimer(able: self, startTime: startTime)
    }
    
    public func startDownTimer(totalTime: UInt){
        WisdomProtocolCore.startDownTimer(able: self, totalTime: totalTime)
    }
    
    //public func suspendTimer(){
    //    WisdomProtocolCore.suspendTimer(able: self)
    //}
    
    //public func resumeTimer(){
    //    WisdomProtocolCore.resumeTimer(able: self)
    //}
    
    public func destroyTimer(){
        WisdomProtocolCore.destroyTimer(able: self)
    }
}
