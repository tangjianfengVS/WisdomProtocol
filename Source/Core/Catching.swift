//
//  Crashing.swift
//  WisdomProtocol
//
//  Created by tangjianfeng on 2022/11/29.
//

import UIKit


// MARK: 'WisdomCrashCatchingable' program crash catching protocol, restriction ‘UIApplicationDelegate’
// 崩溃日志捕捉
@objc public protocol WisdomCrashCatchingable where Self: UIApplicationDelegate {
    
    // MARK: Crash Catching Param - String
    // Swift object type, this parameter is valid in the relase environment but invalid in the debug environment
    // objective-c object type, both debug and relase environments are supported
    @objc func crashCatching(crash: String)
}


// MARK: 'WisdomTrackCatchingable' program track catching protocol, restriction ‘UIApplicationDelegate’
// UIViewController 展示统计日志捕捉
@objc public protocol WisdomTrackCatchingable where Self: UIApplicationDelegate {
    
    // MARK: Track Catching Controller Param - String, String
    // UIViewController Catch Controller 'viewDidAppear'
    // - controller: UIViewController.Type
    // - title: String
    @objc func trackCatching(viewDidAppear controller: UIViewController.Type, title: String)
    
    // MARK: Track Catching Controller Param - String, String
    // UIViewController Catch Controller 'viewDidDisappear'
    // - controller: UIViewController.Type
    // - appearTime: NSInteger
    // - title: String
    @objc optional func trackCatching(viewDidDisappear controller: UIViewController.Type, appearTime: NSInteger, title: String)
}


// MARK: 'WisdomFPSCatchingable' program fps catching protocol, restriction ‘UIApplicationDelegate’
// 主线程界面 FPS 刷新帧率日志捕捉
@objc public protocol WisdomFPSCatchingable where Self: UIApplicationDelegate {
    
    // MARK: FPS Catching Param - Double, String
    // Main thread Catching FPS
    // - currentMain fps: Double
    // - description: String
    @objc func fpsCatching(currentMain fps: Double, description: String)
}


// MARK: 'WisdomFluecyCatchingable' program fluecy catching protocol, restriction ‘UIApplicationDelegate’
// 主线程卡顿具体信息日志捕捉
@objc public protocol WisdomFluecyCatchingable where Self: UIApplicationDelegate {
    
    // MARK: Fluecy Catching Param - Double, String
    // - description: String
    @objc func getFluecyCatchTime(description: String)->TimeInterval
    
    // MARK: Fluecy Catching Param - Double, String
    // Main thread Catching Fluecy
    // - currentMain info: String
    @objc func fluecyCatching(currentMain info: String)
}
