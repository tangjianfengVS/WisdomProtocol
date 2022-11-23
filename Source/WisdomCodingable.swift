//
//  WisdomCodingable.swift
//  Pods
//
//  Created by 汤建锋 on 2022/11/23.
//

import UIKit

// https://www.jianshu.com/p/a73c3874c48a?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes
public protocol WisdomCodingable {

}

extension WisdomCodingable where Self: Decodable {
    
    // MARK: Param - [String: Any], return - Self?
    // Swift 字典转模型, Decodable协议
    public static func decodable(value: Any)->Self?{
        guard let data = try? JSONSerialization.data(withJSONObject: value) else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
        return try? decoder.decode(Self.self, from: data)
    }
    
    // MARK: Param - String, return - Self?
    // Swift Json字符串转模型, Decodable协议
    public static func jsonable(json: String)->Self?{
        let decoder = JSONDecoder()
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
        guard let able = try? decoder.decode(Self.self, from: json.data(using: .utf8)!) else {
            return nil
        }
        return able
    }
}

extension WisdomCodingable where Self: Encodable {
    
    // MARK: return - String?
    // Swift 模型转Json字符串, Encodable协议
    public func ableJson()->String?{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    // MARK: return - [String:Any]?
    // Swift 模型转字典, Encodable协议
    public func ableEncod()->[String:Any]? {
        if let jsonString = ableJson() {
            guard let jsonData = jsonString.data(using: .utf8) else {
                return nil
            }
            guard let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers), let result = dict as? [String:Any] else {
                return nil
            }
            return result
        }
        return nil
    }
}
