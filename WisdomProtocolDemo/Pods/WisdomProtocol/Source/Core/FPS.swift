//
//  FPS.swift
//  Pods
//
//  Created by jianfeng tang on 2023/10/13.
//

import UIKit


class WisdomFPS {
    
    private var link: CADisplayLink?
    
    private let fpsProxy = WisdomFPSProxy()
    
    init() {
        link = CADisplayLink(target: fpsProxy, selector: #selector(fpsProxy.fpsInfoCaculate(sender:)))
        link?.add(to: .main, forMode: .common)
    }

    deinit {
        link?.invalidate()
        link = nil
    }
}

class WisdomFPSProxy {
    
    private var frameCount: NSInteger=0
    private var lastTime: TimeInterval=0

    @objc fileprivate func fpsInfoCaculate(sender: CADisplayLink){
        if lastTime==0 {
            lastTime = sender.timestamp
            return
        }
        frameCount = frameCount+1
        let duration = sender.timestamp-lastTime
        if duration>=1 {
            let fps = Double(frameCount)/duration
            (UIApplication.shared.delegate as? WisdomFPSCatchingable)?.fpsCatching(currentMain: ceil(fps), description: "Debug valid, Release invalid")
            frameCount = 0
            lastTime = sender.timestamp
        }
    }
}
