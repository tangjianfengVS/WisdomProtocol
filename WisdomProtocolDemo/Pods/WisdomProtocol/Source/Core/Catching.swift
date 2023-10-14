//
//  Crashing.swift
//  WisdomProtocol
//
//  Created by tangjianfeng on 2022/11/29.
//

import UIKit


// MARK: 'WisdomCrashingable' program crashing protocol, restriction ‘UIApplicationDelegate’
// 崩溃日志捕捉
@objc public protocol WisdomCrashingable where Self: UIApplicationDelegate {
    
    // MARK: Catch Crashing Param - String
    // Swift object type, this parameter is valid in the relase environment but invalid in the debug environment
    // objective-c object type, both debug and relase environments are supported
    @objc func catchCrashing(crash: String)
}


// MARK: 'WisdomTrackingable' program tracking protocol, restriction ‘UIApplicationDelegate’
// UIViewController 展示统计日志捕捉
@objc public protocol WisdomTrackingable where Self: UIApplicationDelegate {
    
    // MARK: Catch Controller Tracking Param - String, String
    // UIViewController Catch Tracking 'viewDidAppear'
    // - controller: UIViewController.Type
    // - title: String
    @objc func catchTracking(viewDidAppear controller: UIViewController.Type, title: String)
    
    // MARK: Catch Controller Tracking Param - String, String
    // UIViewController Catch Tracking 'viewDidDisappear'
    // - controller: UIViewController.Type
    // - appearTime: NSInteger
    // - title: String
    @objc optional func catchTracking(viewDidDisappear controller: UIViewController.Type, appearTime: NSInteger, title: String)
}


// MARK: 'WisdomFPSTrackingable' program FPS tracking protocol, restriction ‘UIApplicationDelegate’
// 主线程界面 FPS 刷新帧率日志捕捉
@objc public protocol WisdomFPSTrackingable where Self: UIApplicationDelegate {
    
    // MARK: Catch FPS Tracking Param - Double, String
    // Main thread Tracking FPS
    // - currentMain fps: Double
    // - description: String
    @objc func catchFPSTracking(currentMain fps: Double, description: String)
}


// MARK: 'WisdomFluecyTrackingable' program Fluecy tracking protocol, restriction ‘UIApplicationDelegate’
// 主线程卡顿具体信息日志捕捉
@objc public protocol WisdomFluecyTrackingable where Self: UIApplicationDelegate {
    
    // MARK: Catch Fluecy Tracking Param - Double, String
    // - description: String
    @objc func getCatchFluecyTime(description: String)->TimeInterval
    
    // MARK: Catch Fluecy Tracking Param - Double, String
    // Main thread Tracking Fluecy
    // - currentMain info: String
    @objc func catchFluecyTracking(currentMain info: String)
}
