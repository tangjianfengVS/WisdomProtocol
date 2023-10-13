//
//  Crashing.swift
//  WisdomProtocol
//
//  Created by tangjianfeng on 2022/11/29.
//

import UIKit


// MARK: 'WisdomCrashingable' program crashing protocol, restriction ‘UIApplicationDelegate’
@objc public protocol WisdomCrashingable where Self: UIApplicationDelegate {
    
    // MARK: Catch Crashing Param - String
    // Swift object type, this parameter is valid in the relase environment but invalid in the debug environment
    // objective-c object type, both debug and relase environments are supported
    @objc func catchCrashing(crash: String)
}


// MARK: 'WisdomTrackingable' program tracking protocol, restriction ‘UIApplicationDelegate’
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
@objc public protocol WisdomFPSTrackingable where Self: UIApplicationDelegate {
    
    // MARK: Catch FPS Tracking Param - Double, String
    // Main thread Tracking kartun FPS
    // - currentValue fps: Double
    // - description: String
    @objc func catchFPSTracking(currentValue fps: Double, description: String)
}
