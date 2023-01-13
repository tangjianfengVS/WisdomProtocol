//
//  Able.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/14.
//

import UIKit

// MARK: - Register Class Protocol
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
    
    static func getImageable(from Protocol: Protocol)->UIImage.Type?
    
    static func getBundleable(from Protocol: Protocol)->Bundle.Type?
}

protocol WisdomProtocolRouterable {

    static func getRouterClassable(from Protocol: Protocol)->WisdomRouterClassable.Type?

    static func getRouterViewable(from Protocol: Protocol)->WisdomRouterViewable.Type?

    static func getRouterControlable(from Protocol: Protocol)->WisdomRouterControlable.Type?
    
    static func getRouterImageable(from Protocol: Protocol)->WisdomRouterImageable.Type?
    
    static func getRouterBundleable(from Protocol: Protocol)->WisdomRouterBundleable.Type?
    
    static func getRouterNibable(from Protocol: Protocol)->WisdomRouterNibable.Type?
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

    static func startForwardTimer(able: WisdomTimerable&AnyObject, startTime: UInt)
    
    static func startDownTimer(able: WisdomTimerable&AnyObject, totalTime: UInt)
    
    static func suspendTimer(able: WisdomTimerable&AnyObject)
    
    static func resumeTimer(able: WisdomTimerable&AnyObject)
    
    static func destroyTimer(able: WisdomTimerable&AnyObject)
}

protocol WisdomTimerFormatable {
    
    static func dotFormat(seconds: UInt)->String
    
    static func lineFormat(seconds: UInt)->String
    
    static func timeFormat(seconds: UInt, format: String)->String
}

protocol WisdomBinaryBitValueable {
    
    static func getBinaryable(value: NSInteger, caseBitables: [NSInteger])->[NSInteger]

    static func isBinaryable(value: NSInteger, caseBitable: NSInteger)->Bool
}

protocol WisdomLanguageCoreable {
    
    static func getLocalizable(localizable: String)->String

    static func getCurrentLanguage()->WisdomLanguageStatus?
    
    static func getSystemLanguage()->String
    
    static func updateLanguage(language: WisdomLanguageStatus)->Bool
    
    static func resetLanguage()
}
