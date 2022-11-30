//
//  WisdomCatchingable.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/29.
//

import UIKit


@objc public protocol WisdomCrashable where Self: UIApplicationDelegate {
    
    // MARK: Catch Crash Param - String
    // Swift object type, this parameter is valid in the relase environment but invalid in the debug environment
    // objective-c object type, both debug and relase environments are supported
    @objc func catchCrashable(crash: String)
}




