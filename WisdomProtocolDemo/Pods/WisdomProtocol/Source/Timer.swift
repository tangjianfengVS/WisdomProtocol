//
//  Timer.swift
//  WisdomProtocol
//
//  Created by tangjianfeng on 2022/11/24.
//

import UIKit

// ----------------------------------------- Timer ------------------------------------------ //
// * Add a timer/countdown function to the object                                             //
// (1). 'timerable(timerDid currentTime: UInt, timerable: WisdomTimerable)': timer did change //
// (2). 'timerable(timerEnd timerable: WisdomTimerable)'                   : timer end        //
// (3). 'startForwardTimer(startTime: UInt)'                               : start timing     //
// (4). 'startDownTimer(totalTime: UInt)'                                  : start countdown  //
// (5). 'destroyTimer()'                                                   : destroy timer    //
// ------------------------------------------------------------------------------------------ //

// MARK: Class Timerable Protocol
// * Support for objective-c/Swift Class
@objc public protocol WisdomTimerable {
    
    // MARK: Class Param - UInt, WisdomTimerable
    // * Timer task in progress, current time
    @objc func timerable(timerDid currentTime: UInt, timerable: WisdomTimerable)
    
    // MARK: Class Param - WisdomTimerable
    // * Example End a scheduled task
    @objc func timerable(timerEnd timerable: WisdomTimerable)
}

extension WisdomTimerable {
    
    // MARK: Class Param - NSInteger. < No need to implement >
    // * Start a forward timer task, start the forward time point
    public func startForwardTimer(startTime: UInt){
        WisdomProtocolCore.startForwardTimer(able: self, startTime: startTime)
    }
    
    // MARK: Class Param - NSInteger. < No need to implement >
    // * Start a countdown timer task, start the total time countdown
    public func startDownTimer(totalTime: UInt){
        WisdomProtocolCore.startDownTimer(able: self, totalTime: totalTime)
    }
    
    // MARK: Class Timer - suspend. < No need to implement >
    //public func suspendTimer(){
    //    WisdomProtocolCore.suspendTimer(able: self)
    //}
    
    // MARK: Class Timer - resume. < No need to implement >
    //public func resumeTimer(){
    //    WisdomProtocolCore.resumeTimer(able: self)
    //}
    
    // MARK: Class Timer - destroy. < No need to implement >
    // Destruction/Release timer task
    public func destroyTimer(){
        WisdomProtocolCore.destroyTimer(able: self)
    }
}
