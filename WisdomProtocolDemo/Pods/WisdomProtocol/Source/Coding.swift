//
//  Coding.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/23.
//

import UIKit

// ---------------------- Decod Code ---------------------- //
// (1). '[String: Any]'   decod to       'Model'
// (2). '[[String: Any]]' list decod to  '[Model]' list
// (3). 'String'          json decod to  'Model'
// (4). 'String'          jsons decod to '[Model]' list
// -------------------------------------------------------- //

// MARK: Swift Class/NSObject/Value to coding/decoding Protocol
public protocol WisdomCodingable {}

extension WisdomCodingable where Self: Decodable {
    
    // MARK: Param - [String: Any], return - Self?
    // swift dictionary to dictionary model, use 'Decodable' protocol
    public static func decodable(value: [String: Any])->Self?{
        return WisdomProtocolCore.decodable(Self.self, value: value)
    }
    
    // MARK: Param - [String: Any], return - [Self]
    // swift dictionary list to dictionary model list, use 'Decodable' protocol
    public static func decodable(list: [[String: Any]])->[Self]{
        return WisdomProtocolCore.decodable(Self.self, list: list)
    }
    
    // MARK: Param - String, return - Self?
    // swift json string to model, use 'Decodable' protocol
    public static func jsonable(json: String)->Self?{
        return WisdomProtocolCore.jsonable(Self.self, json: json)
    }
    
    // MARK: Param - String, return - [Self]
    // swift jsons string to model list, use 'Decodable' protocol
    public static func jsonable(jsons: String)->[Self]{
        return WisdomProtocolCore.jsonable(Self.self, jsons: jsons)
    }
}


// ---------------------- Encod Code ---------------------- //
// (1). 'Model'   encod to  'String'
// (2). 'Model'   encod to  '[String:Any]'
// (3). '[Model]' encod to  '[[String:Any]]'
// (4). '[Model]' encod to  'String' jsons
// -------------------------------------------------------- //

extension WisdomCodingable where Self: Encodable {
    
    // MARK: return - String?
    // swift model to json string, use 'Encodable' protocol
    public func ableJson()->String?{
        return WisdomProtocolCore.ableJson(self)
    }
    
    // MARK: return - [String:Any]?
    // swift model to dictionary, use 'Encodable' protocol
    public func ableEncod()->[String:Any]?{
        return WisdomProtocolCore.ableEncod(self)
    }
}

public extension Array where Element: WisdomCodingable&Encodable {
    
    // MARK: return - [[String:Any]]
    // swift model list to dictionary list, use 'Encodable' protocol
    func ableEncod()->[[String:Any]]{
        return WisdomProtocolCore.ableEncod(ables: self)
    }
    
    // MARK: return - String?
    // swift model list to jsons string, use 'Encodable' protocol
    func ableJsons()->String?{
        return WisdomProtocolCore.ableJsons(ables: self)
    }
}
