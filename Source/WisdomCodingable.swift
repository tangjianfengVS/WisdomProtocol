//
//  WisdomCodingable.swift
//  Pods
//
//  Created by 汤建锋 on 2022/11/23.
//

import UIKit

public protocol WisdomCodingable {
    
}

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
}
