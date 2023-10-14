//
//  Fluecy.swift
//  Pods
//
//  Created by jianfeng tang on 2023/10/13.
//

import UIKit

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
            //print("Thread.current\(Thread.current)")
            while self?.isMonitoring==true {
                if self?.currentActivity == .beforeWaiting{
                    var timeOut = true
                    //print("-0")

                    DispatchQueue.main.async {
                        timeOut = false
                        self?.semphore?.signal()
                        //print("-1")
                    }

                    //print("-2")
                    Thread.sleep(forTimeInterval: timeout)
                    //print("-3")
                    if timeOut {
                        print("-4 --- timeOut")
                    }
                    //print("-5")
                    self?.semphore?.wait()
                    //print("-6")
                }
            }
        }
    }
    
    func stopMonitoring(){
        isMonitoring = false
    }
}


