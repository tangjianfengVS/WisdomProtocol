//
//  Crashing.swift
//  WisdomProtocol
//
//  Created by tangjianfeng on 2022/11/29.
//

import UIKit

// ------------------------------- Crashing ------------------------------- //
// (1). 'WisdomCrashingable' program crash protocol, restriction ‘UIApplicationDelegate’
//
// (2). 'WisdomTrackingable' program tracking protocol, restriction ‘UIApplicationDelegate’
//      - 1> '@objc func catchTracking(viewDidAppear controller: UIViewController.Type, title: String)'
//           * Controller will display
//      - 2> '@objc optional func catchTracking(viewDidDisappear controller: UIViewController.Type, appearTime: NSInteger, title: String)'
//           * Controller is going to disappear
// ------------------------------------------------------------------------ //

@objc public protocol WisdomCrashingable where Self: UIApplicationDelegate {
    
    // MARK: Catch Crashing Param - String
    // Swift object type, this parameter is valid in the relase environment but invalid in the debug environment
    // objective-c object type, both debug and relase environments are supported
    @objc func catchCrashing(crash: String)
}

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


