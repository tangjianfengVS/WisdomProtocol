//
//  WisdomCatchable.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/29.
//

import UIKit


@objc public protocol WisdomCrashable where Self: UIApplicationDelegate {
    
    // MARK: Catch Crash Param - String
    @objc func catchCrashable(crash: String)
}




