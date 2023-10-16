//
//  Fluecy.swift
//  Pods
//
//  Created by jianfeng tang on 2023/10/13.
//

import UIKit
import RCBacktrace

class WisdomFluecy {
    
    private let lxd_time_out_interval: TimeInterval
    private let fluecyQueue = DispatchQueue(label: "WisdomProtocolCore.FluecyQueue", attributes: DispatchQueue.Attributes.concurrent)
    
    private var isMonitoring = false
    private var observer: CFRunLoopObserver?
    private var currentActivity: CFRunLoopActivity?
    private var semphore: DispatchSemaphore?
    
    init(timeout: TimeInterval) {
        self.lxd_time_out_interval = timeout
        startMonitoring()
    }
    
    func startMonitoring(){
        if isMonitoring { return }
        isMonitoring = true
        semphore = DispatchSemaphore(value: 0)
        
        observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0, { [weak self] (observer: CFRunLoopObserver?, activity: CFRunLoopActivity) in
            self?.currentActivity = activity
        })
        
        CFRunLoopAddObserver(CFRunLoopGetMain(), observer, .commonModes)
        
        let timeout = lxd_time_out_interval
        fluecyQueue.async { [weak self] in
            while self?.isMonitoring==true {
                if self?.currentActivity == .beforeWaiting{
                    var timeOut = true

                    DispatchQueue.main.async {
                        timeOut = false
                        self?.semphore?.signal()
                    }
                    Thread.sleep(forTimeInterval: timeout)
                    if timeOut {
                        var info="[Fluecy Info]"
                        let symbols = RCBacktrace.callstack(.main)
                        for symbol in symbols {
                            info=info+"\n"+symbol.description
                        }
                        DispatchQueue.main.async {
                            (UIApplication.shared.delegate as? WisdomFluecyCatchingable)?.fluecyCatching(currentMain: info, description: "Debug valid, Release invalid")
                        }
                    }
                    self?.semphore?.wait()
                }
            }
        }
    }
    
    func stopMonitoring(){
        isMonitoring = false
    }
}


