//
//  WisdomProtocol.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/21.
//

import UIKit

@objc public final class WisdomProtocol: NSObject {

    @available(*, unavailable)
    override init() {}
}

extension WisdomProtocol: WisdomProtocolRegisterable{
    
    @objc static func registerable(){
        WisdomProtocolCore.registerable()
    }
    
    // MARK: Register Protocol: WisdomClassable
    // * Need to ensure the timing of registration, the level must be the highest *
    //   用于 手动注册 或 静态库链接引用类。解决 WisdomProtocol 静态库链接注册类问题
    @discardableResult
    @objc public static func registerable(classable: WisdomClassable)->Protocol{
        return WisdomProtocolCore.registerable(classable: classable)
    }
}

// * Create Protocol *
extension WisdomProtocol: WisdomProtocolCreateable{
    
    // MARK: Create Protocol From Protocol Name: String
    @objc public static func create(protocolName: String)->Protocol? {
        return WisdomProtocolCore.create(protocolName: protocolName)
    }
    
    // MARK: Create Protocol From Project Name: String, Protocol Name: String
    @objc public static func create(projectName: String, protocolName: String)->Protocol? {
        return WisdomProtocolCore.create(projectName: projectName, protocolName: protocolName)
    }
}

extension WisdomProtocol: WisdomProtocolable {
    
    // MARK: Get AnyClass From Protocol
    @objc public static func getClassable(from Protocol: Protocol)->AnyClass?{
        return WisdomProtocolCore.getClassable(from: Protocol)
    }

    // MARK: Get UIView.Type From Protocol
    @objc public static func getViewable(from Protocol: Protocol)->UIView.Type?{
        return WisdomProtocolCore.getViewable(from: Protocol)
    }

    // MARK: Get UIViewController.Type From Protocol
    @objc public static func getControlable(from Protocol: Protocol)->UIViewController.Type?{
        return WisdomProtocolCore.getControlable(from: Protocol)
    }
}

// * Router Protocol *
extension WisdomProtocol: WisdomProtocolRouterable {

    // MARK: Get Router AnyClass From Protocol
    @objc public static func getRouterClassable(from Protocol: Protocol)->WisdomRouterClassable.Type?{
        return WisdomProtocolCore.getRouterClassable(from: Protocol)
    }

    // MARK: Get Router UIView.Type From Protocol
    @objc public static func getRouterViewable(from Protocol: Protocol)->WisdomRouterViewable.Type?{
        return WisdomProtocolCore.getRouterViewable(from: Protocol)
    }

    // MARK: Get Router UIViewController.Type From Protocol
    @objc public static func getRouterControlable(from Protocol: Protocol)->WisdomRouterControlable.Type?{
        return WisdomProtocolCore.getRouterControlable(from: Protocol)
    }
}

extension WisdomProtocol: WisdomTimerValueable {
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion '00:00:00'
    static func getDotFormat(seconds: UInt)->String{
        return WisdomProtocolCore.getDotFormat(seconds: seconds)
    }
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion '00-00-00'
    static func getLineFormat(seconds: UInt)->String{
        return WisdomProtocolCore.getLineFormat(seconds: seconds)
    }
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion format 'String'
    static func getTimeFormat(seconds: UInt, format: String)->String{
        return WisdomProtocolCore.getTimeFormat(seconds: seconds, format: format)
    }
}


