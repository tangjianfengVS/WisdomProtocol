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

var Key = "nsh_DescriptiveName"

extension WisdomSwiftTimerable {

    // MARK: Param - NSInteger
    // * Start a timer task, start the timer time point
    public func startAddTimer(swiftStartTime startTime: NSInteger){
        if let objable = self as? (WisdomSwiftTimerable&AnyObject) {
            WisdomProtocolCore.startAddTimer(objable: objable, startTime: startTime)
        }
    }
    
    // MARK: Param - NSInteger
    // * Start a countdown task, start the total time countdown
    public func startDownTimer(swiftTotalTime totalTime: NSInteger){
        if let objable = self as? (WisdomSwiftTimerable&AnyObject) {
            WisdomProtocolCore.startDownTimer(objable: objable, totalTime: totalTime)
        }else {
            if let historyable = objc_getAssociatedObject(self, &Key) as? WisdomValueTimerModel{
                historyable.destroy()
                objc_setAssociatedObject(self, &Key, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            
            let timer = WisdomValueTimerModel(currentTime: totalTime,
                                              isDown: true,
                                              didClosure: didClosure(currentTime:),
                                              endClosure: endClosure,
                                              destroyClosure: destroyClosure)
            objc_setAssociatedObject(self, &Key, timer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // MARK: Timer - suspend
    public func suspendSwiftTimer(){
        if let objable = self as? (WisdomSwiftTimerable&AnyObject) {
            WisdomProtocolCore.suspendTimer(objable: objable)
        }
    }

    // MARK: Timer - resume
    public func resumeSwiftTimer(){
        if let objable = self as? (WisdomSwiftTimerable&AnyObject) {
            WisdomProtocolCore.resumeTimer(objable: objable)
        }
    }

    // MARK: Timer - destroy
    public func destroySwiftTimer(){
        if let objable = self as? (WisdomSwiftTimerable&AnyObject) {
            WisdomProtocolCore.destroyTimer(objable: objable)
        }
    }
    
    func didClosure(currentTime: NSInteger)->Bool {
        timerable(swiftTimerDid: currentTime, timerable: self)
        return false
    }
    
    func endClosure(){
        timerable(swiftTimerDid: 0, timerable: self)
    }
    
    func destroyClosure() {
        objc_setAssociatedObject(self, &Key, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}




//https://www.jianshu.com/p/4303f1fa8352
//            var ptr = withUnsafePointer(to: &self) { UnsafeRawPointer($0) }
//            let key = "\(ptr)"
//            print(ptr)
//            assert(key.count>0, "unsafeBitCast failure: \(ptr)")
//            if key.count > 0 {
//                if let historyable = WisdomProtocolCore.getValueTimer(key: key) {
//                    historyable.destroy()
//                    WisdomProtocolCore.remValueTimer(key: key)
//                }
//
//                let timer = WisdomValueTimerModel(currentTime: totalTime, isDown: false) { currentTime in
//                    return setTimerDid(currentTime: currentTime)
//                } endClosure: {
//    //                setTimerEnd()
//                } destroyClosure: {
//                    WisdomProtocolCore.remValueTimer(key: key)
//                }
//                WisdomProtocolCore.setValueTimer(timer: timer, key: key)
//
//                objc_setAssociatedObject(self, &Key, timer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            }

//            func setTimerDid(currentTime: NSInteger)->Bool{
//                if let ad = ptr as? WisdomSwiftTimerable {
//                    ad.timerable(swiftTimerDid: currentTime, timerable: ad)
//                    return true
//                }
//                let ad = ptr as! WisdomSwiftTimerable
//                ad.timerable(swiftTimerDid: currentTime, timerable: ad)
//                return true
//            }
