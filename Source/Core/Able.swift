//
//  Able.swift
//  WisdomProtocol
//
//  Created by tangjianfeng on 2022/11/14.
//

import UIKit

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

protocol WisdomBundleCoreable {
    
    static func able(projectClass: AnyClass?, resource: String, ofType: String, fileName: String, inDirectory: String?)->Bundle?
}

protocol WisdomNetworkReachabilityCoreable {
    
    static func startReachabilityListening(able: WisdomNetworkReachabilityable)
    
    static func stopReachabilityListening(able: WisdomNetworkReachabilityable)
}
