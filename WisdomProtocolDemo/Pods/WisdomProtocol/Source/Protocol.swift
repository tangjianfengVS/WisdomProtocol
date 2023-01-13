//
//  Protocol.swift
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
    
    // MARK: Get UIImage.Type From Protocol
    @objc public static func getImageable(from Protocol: Protocol)->UIImage.Type?{
        return WisdomProtocolCore.getImageable(from: Protocol)
    }

    // MARK: Get Bundle.Type From Protocol
    @objc public static func getBundleable(from Protocol: Protocol)->Bundle.Type?{
        return WisdomProtocolCore.getBundleable(from: Protocol)
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
    
    // MARK: Get Router UIImage.Type From Protocol
    @objc public static func getRouterImageable(from Protocol: Protocol)->WisdomRouterImageable.Type?{
        return WisdomProtocolCore.getRouterImageable(from: Protocol)
    }
    
    // MARK: Get Router Bundle.Type From Protocol
    @objc public static func getRouterBundleable(from Protocol: Protocol)->WisdomRouterBundleable.Type?{
        return WisdomProtocolCore.getRouterBundleable(from: Protocol)
    }
    
    // MARK: Get Router UINib.Type From Protocol
    @objc public static func getRouterNibable(from Protocol: Protocol)->WisdomRouterNibable.Type?{
        return WisdomProtocolCore.getRouterNibable(from: Protocol)
    }
}

// * Binary Bit Value(value==1) Protocol *
extension WisdomProtocol: WisdomBinaryBitValueable {
    
    // MARK: return - [NSInteger]
    // get Binarierable list bit values when value==1 width: NSInteger, [NSInteger]
    // example: 'let res = WisdomProtocol.getBinaryable(value: 31, caseBitables: [0,1,2,3,4,5])'
    //          'res = [0,1,2,3,4]'
    @objc public static func getBinaryable(value: NSInteger, caseBitables: [NSInteger])->[NSInteger]{
        return WisdomProtocolCore.getBinaryable(value: value, caseBitables: caseBitables)
    }

    // MARK: return - Bool
    // get Binarierable a bit value when value==1 width: NSInteger, NSInteger
    // example: 'let res = WisdomProtocol.isBinaryable(value: 31, caseBitable: 3])'
    //          'res = ture'
    // example: 'let res = WisdomProtocol.isBinaryable(value: 31, caseBitable: 5])'
    //          'res = false'
    @objc public static func isBinaryable(value: NSInteger, caseBitable: NSInteger)->Bool{
        return WisdomProtocolCore.isBinaryable(value: value, caseBitable: caseBitable)
    }
}

// * NSString Timer Value *
extension NSString: WisdomTimerFormatable {
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion '00:00:00'
    @objc public static func dotFormat(seconds: UInt)->String{
        return String.dotFormat(seconds: seconds)
    }
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion '00-00-00'
    @objc public static func lineFormat(seconds: UInt)->String{
        return String.lineFormat(seconds: seconds)
    }
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion format 'String'
    @objc public static func timeFormat(seconds: UInt, format: String)->String{
        return String.timeFormat(seconds: seconds, format: format)
    }
}

// * String Timer Value *
extension String: WisdomTimerFormatable {
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion '00:00:00'
    public static func dotFormat(seconds: UInt)->String{
        return WisdomProtocolCore.dotFormat(seconds: seconds)
    }
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion '00-00-00'
    public static func lineFormat(seconds: UInt)->String{
        return WisdomProtocolCore.lineFormat(seconds: seconds)
    }
    
    // MARK: Get Time Param - UInt
    // Time 'UInt' conversion format 'String'
    public static func timeFormat(seconds: UInt, format: String)->String{
        return WisdomProtocolCore.timeFormat(seconds: seconds, format: format)
    }
}

