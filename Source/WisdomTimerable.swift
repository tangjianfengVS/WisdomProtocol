//
//  WisdomTimerable.swift
//  Pods
//
//  Created by 汤建锋 on 2022/11/24.
//

import UIKit


@objc public protocol WisdomTimerable {

    func timerDid(currentTime: NSInteger)
    
    func timerEnd()
}

extension WisdomTimerable {
    
    // 计时器
    public func startAddTimer(startTime: NSInteger){
        WisdomProtocolCore.startAddTimer(able: self, startTime: startTime)
    }
    
    // 倒计时
    public func startDownTimer(totalTime: NSInteger){
        WisdomProtocolCore.startDownTimer(able: self, totalTime: totalTime)
    }
    
    // 暂停
    public func suspendTimer(){
        WisdomProtocolCore.suspendTimer(able: self)
    }
    
    // 继续
    public func resumeTimer(){
        WisdomProtocolCore.resumeTimer(able: self)
    }
    
    // 摧毁
    public func destroyTimer(){
        WisdomProtocolCore.destroyTimer(able: self)
    }
}
