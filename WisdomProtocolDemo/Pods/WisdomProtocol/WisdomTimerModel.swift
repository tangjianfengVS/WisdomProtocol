//
//  WisdomTimerModel.swift
//  Pods
//
//  Created by 汤建锋 on 2022/11/24.
//

import UIKit


final class WisdomTimerModel {
    
    private let isDown: Bool
    
    private weak var able: WisdomTimerable?

    private var currentTime: NSInteger=0
    
    private let destroyClosure: ()->()

    private var timer: DispatchSourceTimer?
    
    private var historyTime: CFAbsoluteTime?
    
    init(able: WisdomTimerable, currentTime: NSInteger, isDown: Bool, destroyClosure: @escaping ()->()){
        self.able = able
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
    
    deinit {
        print("")
    }
}

extension WisdomTimerModel {
    
    private func startAddTimer() {
        if let timerable = able {
            timerable.timerable(timerable, timerDid: currentTime)
            currentTime += 1
        }else {
            destroy()
            destroyClosure()
        }
    }
    
    private func startDownTimer() {
        if let timerable = able {
            if currentTime>0 {
                timerable.timerable(timerable, timerDid: currentTime)
                
                currentTime -= 1
            }else {
                timerable.timerable(timerable, timerDid: 0)
                timerable.timerable(timeEnd: timerable)
                destroy()
                destroyClosure()
            }
        }else {
            destroy()
            destroyClosure()
        }
    }
    
    @objc private func becomeDeath(noti:Notification){
        if let sourceTimer = timer {
            sourceTimer.suspend()
            historyTime = CFAbsoluteTimeGetCurrent()
        }else {
            destroy()
            destroyClosure()
        }
    }

    @objc private func becomeActive(noti:Notification){
        if let timerable = able, let sourceTimer = timer, let curTime = historyTime {
            let poor = CFAbsoluteTimeGetCurrent()-curTime
            if poor>=1 {
                if isDown {
                    currentTime = currentTime-NSInteger(poor)
                    if currentTime<=0 {
                        timerable.timerable(timerable, timerDid: 0)
                        timerable.timerable(timeEnd: timerable)
                        destroy()
                        destroyClosure()
                    }else {
                        timerable.timerable(timerable, timerDid: currentTime)
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
    
    func suspend() {
        
    }
    
    func resume() {
        
    }
    
    func destroy() {
        timer?.cancel()
        timer = nil
        historyTime = nil
        able = nil
        NotificationCenter.default.removeObserver(self)
    }
}
