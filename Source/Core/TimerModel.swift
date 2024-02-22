//
//  TimerModel.swift
//  WisdomProtocol
//
//  Created by tangjianfeng on 2022/11/24.
//

import UIKit

class WisdomTimerTask {
    
    let isDown: Bool
    
    var currentTime: UInt
    
    private(set) weak var able: WisdomTimerable?
    
    init(isDown: Bool, able: WisdomTimerable, startTime: UInt) {
        self.isDown = isDown
        self.able = able
        self.currentTime = startTime
    }
}


class WisdomTimerModel {
    
    private(set) var timer: DispatchSourceTimer?
    
    private var tasks: [String:WisdomTimerTask] = [:]
    
    private var historyTime: CFAbsoluteTime?
    
    init(task: WisdomTimerTask, key: String) {
        tasks[key] = task
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer?.schedule(deadline: .now(), repeating: 1.0)
        timer?.setEventHandler { [weak self] in
            self?.timerDid()
        }
        timer?.resume()
        NotificationCenter.default.addObserver(self, selector:#selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(becomeDeath), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    func appendTask(task: WisdomTimerTask, key: String) {
        tasks[key] = task
    }
    
    func destroyTask(key: String) {
        tasks.removeValue(forKey: key)
        
        if tasks.values.count==0 {
            destroy()
        }
    }
    
    private func timerDid() {
        for task in tasks {
            if task.value.isDown {
                downTimer(task: task.value, key: task.key)
            }else {
                addTimer(task: task.value, key: task.key)
            }
        }
        if tasks.values.count==0 {
            destroy()
        }
    }
    
    private func addTimer(task: WisdomTimerTask, key: String) {
        if let timerable = task.able {
            timerable.timerable(timerDid: task.currentTime, timerable: timerable)
            task.currentTime += 1
        }else {
            tasks.removeValue(forKey: key)
        }
    }
    
    private func downTimer(task: WisdomTimerTask, key: String) {
        if let timerable = task.able {
            if task.currentTime>0 {
                timerable.timerable(timerDid: task.currentTime, timerable: timerable)
                task.currentTime -= 1
            }else {
                timerable.timerable(timerDid: 0, timerable: timerable)
                timerable.timerable(timerEnd: timerable)
                tasks.removeValue(forKey: key)
            }
        }else {
            tasks.removeValue(forKey: key)
        }
    }
    
    deinit {
        print("[WisdomProtocol] \(self) deinit")
    }
}

extension WisdomTimerModel {
    
    @objc private func becomeDeath(noti:Notification) {
        if timer != nil {
            timer?.suspend()
            historyTime = CFAbsoluteTimeGetCurrent()
        }else {
            tasks.removeAll()
            
            destroy()
        }
    }

    @objc private func becomeActive(noti:Notification) {
        if historyTime != nil {   // check historyTime
            if timer != nil { // check timer: no destroy
                let poor = CFAbsoluteTimeGetCurrent()-historyTime!
                if poor>=1 {
                    for task in tasks {
                        if let timerable = task.value.able { // check timerable: no remove
                            if task.value.isDown {           // isDown
                                if task.value.currentTime<=UInt(poor) { // isDown: end
                                    timerable.timerable(timerDid: 0, timerable: timerable)
                                    timerable.timerable(timerEnd: timerable)
                                    tasks.removeValue(forKey: task.key)
                                }else { // isDown: next
                                    let currentTime = task.value.currentTime-UInt(poor)
                                    task.value.currentTime = currentTime
                                    timerable.timerable(timerDid: task.value.currentTime, timerable: timerable)
                                    task.value.currentTime -= 1
                                }
                            }else { // addTimer
                                task.value.currentTime = task.value.currentTime+UInt(poor)
                                timerable.timerable(timerDid: task.value.currentTime, timerable: timerable)
                                task.value.currentTime += 1
                            }
                        }else {
                            tasks.removeValue(forKey: task.key)
                        }
                    }
                }
                timer?.resume()
                historyTime = nil
            }else {
                tasks.removeAll()
            }
        }
        if tasks.values.count==0 {
            destroy()
        }
    }
    
    fileprivate func destroy() {
        timer?.cancel()
        if historyTime != nil {
            timer?.resume()
        }
        timer = nil
        historyTime = nil
        NotificationCenter.default.removeObserver(self)
    }
}
