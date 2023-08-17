//
//  TimerModel.swift
//  WisdomProtocol
//
//  Created by tangjianfeng on 2022/11/24.
//

import UIKit


class WisdomTimerBaseModel {
    
    fileprivate let isDown: Bool

    fileprivate var currentTime: UInt=0
    
    fileprivate let destroyClosure: ()->()
    
    //fileprivate var isSusspended = false

    fileprivate var timer: DispatchSourceTimer?
    
    fileprivate var historyTime: CFAbsoluteTime?
    
    init(currentTime: UInt, isDown: Bool, destroyClosure: @escaping ()->()){
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

    @objc fileprivate func becomeActive(noti:Notification){
        //if let curTime = historyTime {
        //    let poor = CFAbsoluteTimeGetCurrent()-curTime
        //    if isDown {
        //        currentTime = currentTime-NSInteger(poor)
        //    }else {
        //        currentTime = currentTime+NSInteger(poor)
        //    }
        //    historyTime = nil
        //}
    }
    
    //@objc func suspend() {
    //    if let sourceTimer = timer {
    //        if !isSusspended {
    //            sourceTimer.suspend()
    //        }
    //        isSusspended = true
    //    }else {
    //        destroy()
    //        destroyClosure()
    //    }
    //}
    
    //@objc func resume() {
    //    if let sourceTimer = timer {
    //        if isSusspended {
    //            sourceTimer.resume()
    //            isSusspended = false
    //        }
    //    }else {
    //        destroy()
    //        destroyClosure()
    //    }
    //}
    
    @objc func destroy() {
        timer?.cancel()
        timer = nil
        historyTime = nil
        NotificationCenter.default.removeObserver(self)
    }
}


final class WisdomTimerModel: WisdomTimerBaseModel {
    
    private weak var able: WisdomTimerable?
    
    init(able: WisdomTimerable, currentTime: UInt, isDown: Bool, destroyClosure: @escaping ()->()){
        self.able = able
        super.init(currentTime: currentTime, isDown: isDown, destroyClosure: destroyClosure)
    }
    
    deinit {
        destroy()
        print("[WisdomProtocol] \(self) deinit")
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
                timerable.timerable(timerEnd: timerable)
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
                    currentTime = currentTime-UInt(poor)
                    if currentTime<=0 {
                        timerable.timerable(timerDid: 0, timerable: timerable)
                        timerable.timerable(timerEnd: timerable)
                        destroy()
                        destroyClosure()
                    }else {
                        timerable.timerable(timerDid: currentTime, timerable: timerable)
                    }
                }else {
                    currentTime = currentTime+UInt(poor)
                    timerable.timerable(timerDid: currentTime, timerable: timerable)
                }
            }
            historyTime = nil
            sourceTimer.resume()
        }else {
            destroy()
            destroyClosure()
        }
    }
    
    @objc override func destroy() {
        super.destroy()
        able = nil
    }
}
