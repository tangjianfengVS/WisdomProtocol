//
//  WisdomProtocolable.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/14.
//

import UIKit

// MARK: - register Class Protocol
@objc public final class WisdomClassable: NSObject {
    
    @objc public let registerProtocol: Protocol

    @objc public let conformClass: AnyClass
    
    @objc public init(register Protocol: Protocol, conform Class: AnyClass) {
        self.registerProtocol = Protocol
        self.conformClass = Class
        super.init()
    }
}

// MARK: - Register Protocol
@objc public protocol WisdomRegisterable {

    @objc static func registerable()->WisdomClassable
}

protocol WisdomProtocolRegisterable {

    static func registerable()
    
    static func registerable(classable: WisdomClassable)->Protocol
}

protocol WisdomProtocolable {

    static func getClassable(from Protocol: Protocol)->AnyClass?

    static func getViewable(from Protocol: Protocol)->UIView.Type?

    static func getControlable(from Protocol: Protocol)->UIViewController.Type?
}

protocol WisdomProtocolRouterable {

    static func getRouterClassable(from Protocol: Protocol)->WisdomRouterClassable.Type?

    static func getRouterViewable(from Protocol: Protocol)->WisdomRouterViewable.Type?

    static func getRouterControlable(from Protocol: Protocol)->WisdomRouterControlable.Type?
}

protocol WisdomProtocolCreateable {

    static func create(protocolName: String)->Protocol?
    
    static func create(projectName: String, protocolName: String)->Protocol?
}

protocol WisdomCodingCoreable {
    
    static func decodable<T>(_ type: T.Type, value: Any)->T? where T: Decodable
    
    static func decodable<T>(_ type: T.Type, list: [[String: Any]])->[T] where T: Decodable
    
    static func jsonable<T>(_ type: T.Type, json: String)->T? where T: Decodable
    
    static func jsonable<T>(_ type: T.Type, jsons: String)->[T] where T: Decodable
    
    static func ableJson<T>(_ able: T)->String? where T: Encodable
    
    static func ableEncod<T>(_ able: T)->[String:Any]? where T: Encodable
}

protocol WisdomTimerCoreable {

    static func startAddTimer(able: WisdomTimerable, startTime: NSInteger)
    
    static func startDownTimer(able: WisdomTimerable, totalTime: NSInteger)
    
    static func suspendTimer(able: WisdomTimerable)
    
    static func resumeTimer(able: WisdomTimerable)
    
    static func destroyTimer(able: WisdomTimerable)
}

protocol WisdomSwiftTimerCoreable {

    static func startAddTimer(objable: WisdomSwiftTimerable&AnyObject, startTime: NSInteger)

    static func startDownTimer(objable: WisdomSwiftTimerable&AnyObject, totalTime: NSInteger)

    static func suspendTimer(objable: WisdomSwiftTimerable&AnyObject)

    static func resumeTimer(objable: WisdomSwiftTimerable&AnyObject)

    static func destroyTimer(objable: WisdomSwiftTimerable&AnyObject)
    
    static func getValueTimer(key: String)->WisdomValueTimerModel?
    
    static func setValueTimer(timer: WisdomValueTimerModel, key: String)
    
    static func remValueTimer(key: String)
}
