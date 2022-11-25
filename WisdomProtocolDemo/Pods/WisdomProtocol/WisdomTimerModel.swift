//
//  WisdomTimerModel.swift
//  Pods
//
//  Created by 汤建锋 on 2022/11/24.
//

import UIKit


class WisdomTimerBaseModel {
    
    fileprivate let isDown: Bool

    fileprivate var currentTime: NSInteger=0
    
    fileprivate let destroyClosure: ()->()

    fileprivate var timer: DispatchSourceTimer?
    
    fileprivate var historyTime: CFAbsoluteTime?
    
    init(currentTime: NSInteger, isDown: Bool, destroyClosure: @escaping ()->()){
        self.currentTime = currentTime
        self.isDown = isDown
        self.destroyClosure = destroyClosure
        
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer?.schedule(deadline: .now(), repeating: 1.0)
        timer?.setEventHandler { [weak self] in
            if self?.isDown == false {
                self?.startAddTimer()
            }else if self?.isDown == true {
                self?.startDownTimer()
            }
        }
        timer?.resume()

        NotificationCenter.default.addObserver(self, selector:#selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(becomeDeath), name: UIApplication.willResignActiveNotification, object: nil)
    }
}

extension WisdomTimerBaseModel {
    
    @objc fileprivate func startAddTimer() {}
    
    @objc fileprivate func startDownTimer() {}
    
    @objc private func becomeDeath(noti:Notification){
        if let sourceTimer = timer {
            sourceTimer.suspend()
            historyTime = CFAbsoluteTimeGetCurrent()
        }else {
            destroy()
            destroyClosure()
        }
    }

    @objc fileprivate func becomeActive(noti:Notification){}
    
    @objc func suspend() {
        
    }
    
    @objc func resume() {
        
    }
    
    @objc func destroy() {
        timer?.cancel()
        timer = nil
        historyTime = nil
        NotificationCenter.default.removeObserver(self)
    }
}


final class WisdomTimerModel: WisdomTimerBaseModel {
    
    private weak var able: WisdomTimerable?
    
    init(able: WisdomTimerable, currentTime: NSInteger, isDown: Bool, destroyClosure: @escaping ()->()){
        self.able = able
        super.init(currentTime: currentTime, isDown: isDown, destroyClosure: destroyClosure)
    }
    
    deinit {
        print("")
    }
}

extension WisdomTimerModel {
    
    fileprivate override func startAddTimer() {
        if let timerable = able {
            timerable.timerable(timerDid: currentTime, timerable: timerable)
            currentTime += 1
        }else {
            destroy()
            destroyClosure()
        }
    }
    
    fileprivate override func startDownTimer() {
        if let timerable = able {
            if currentTime>0 {
                timerable.timerable(timerDid: currentTime, timerable: timerable)
                
                currentTime -= 1
            }else {
                timerable.timerable(timerDid: 0, timerable: timerable)
                timerable.timerable(timeEnd: timerable)
                destroy()
                destroyClosure()
            }
        }else {
            destroy()
            destroyClosure()
        }
    }

    fileprivate override func becomeActive(noti:Notification){
        if let timerable = able, let sourceTimer = timer, let curTime = historyTime {
            let poor = CFAbsoluteTimeGetCurrent()-curTime
            if poor>=1 {
                if isDown {
                    currentTime = currentTime-NSInteger(poor)
                    if currentTime<=0 {
                        timerable.timerable(timerDid: 0, timerable: timerable)
                        timerable.timerable(timeEnd: timerable)
                        destroy()
                        destroyClosure()
                    }else {
                        timerable.timerable(timerDid: currentTime, timerable: timerable)
                    }
                }else {
                    currentTime = currentTime+NSInteger(poor)
                }
            }
            historyTime = nil
            sourceTimer.resume()
        }else {
            destroy()
            destroyClosure()
        }
    }
    
    @objc override func suspend() {
        
    }
    
    @objc override func resume() {
        
    }
    
    @objc override func destroy() {
        super.destroy()
        able = nil
    }
}


final class WisdomSwiftTimerModel: WisdomTimerBaseModel {
    
    private let didClosure: (NSInteger)->(Bool)
    
    private let endClosure: ()->()
    
    init(currentTime: NSInteger,
         isDown: Bool,
         didClosure: @escaping (NSInteger)->(Bool),
         endClosure: @escaping ()->(),
         destroyClosure: @escaping ()->()){
        self.didClosure = didClosure
        self.endClosure = endClosure
        super.init(currentTime: currentTime, isDown: isDown, destroyClosure: destroyClosure)
    }
    
    deinit {
        print("")
    }
}

extension WisdomSwiftTimerModel {
    
    fileprivate override func startAddTimer() {
        if didClosure(currentTime){
            currentTime += 1
        }else {
            destroy()
            destroyClosure()
        }
    }
    
    fileprivate override func startDownTimer() {
        if currentTime>0 {
            if didClosure(currentTime){
                currentTime -= 1
            }else {
                destroy()
                destroyClosure()
            }
        }else {
            _=didClosure(0)
            endClosure()
            destroy()
            destroyClosure()
        }
    }

    fileprivate override func becomeActive(noti:Notification){
//        if let timerable = able, let sourceTimer = timer, let curTime = historyTime {
//            let poor = CFAbsoluteTimeGetCurrent()-curTime
//            if poor>=1 {
//                if isDown {
//                    currentTime = currentTime-NSInteger(poor)
//                    if currentTime<=0 {
//                        timerable.timerable(swiftTimerDid: 0, timerable: timerable)
//                        timerable.timerable(swiftTimerDid: timerable)
//                        destroy()
//                        destroyClosure()
//                    }else {
//                        timerable.timerable(swiftTimerDid: currentTime, timerable: timerable)
//                    }
//                }else {
//                    currentTime = currentTime+NSInteger(poor)
//                }
//            }
//            historyTime = nil
//            sourceTimer.resume()
//        }else {
//            destroy()
//            destroyClosure()
//        }
    }
    
    @objc override func suspend() {
        
    }
    
    @objc override func resume() {
        
    }
    
    @objc override func destroy() {
        super.destroy()
    }
}
