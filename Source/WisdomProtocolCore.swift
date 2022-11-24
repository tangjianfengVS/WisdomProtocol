//
//  WisdomProtocolCore.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/14.
//

import UIKit

struct WisdomProtocolCore {
    
    private static var WisdomProtocolConfig: [String:AnyClass] = [:]

    private static var WisdomRegisterState: Int = 0
    
    private static var WisdomTimerConfig: [String:WisdomTimerModel] = [:]
    
    // MARK: registerProtocol protocol class
    private static func registerableConfig(register aProtocol: Protocol, conform aClass: AnyClass)->Protocol {
        let key = NSStringFromProtocol(aProtocol)
        if !class_conformsToProtocol(aClass, aProtocol) {
            print("❌[WisdomProtocol] register no conforming: "+key+"->"+NSStringFromClass(aClass)+"❌")
            return aProtocol
        }
        if WisdomProtocolConfig[key] != nil {
            print("❌[WisdomProtocol] register redo conforming: "+key+"->"+NSStringFromClass(aClass)+"❌")
            return aProtocol
        }
        //print("🐬[WisdomProtocol] register successful: "+key+"->"+NSStringFromClass(Class)+"🐬")
        WisdomProtocolConfig.updateValue(aClass, forKey: key)
        return aProtocol
    }
}

extension WisdomProtocolCore: WisdomProtocolRegisterable{
    
    static func registerable() {
        if WisdomProtocolCore.WisdomRegisterState == 1 {
            return
        }
        WisdomProtocolCore.WisdomRegisterState = 1
    
        let start = CFAbsoluteTimeGetCurrent()
        let c = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: c)
        let autoTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoTypes, Int32(c))
        
        var list: [Int:Int] = [0: c/2, c/2+1: c]//23320-0.019
        if c>30000 {
            list = [0:c/6, c/6+1:c/6*2, c/6*2+1:c/6*3, c/6*3+1:c/6*4, c/6*4+1:c/6*5, c/6*5+1:c]//30616-0.065
        }else if c>28000 {
            list = [0:c/5, c/5+1:c/5*2, c/5*2+1:c/5*3, c/5*3+1:c/5*4, c/5*4+1:c]
        }else if c>26000 {
            list = [0:c/4, c/4+1:c/2, c/2+1:c/4*3, c/4*3+1:c]
        }else if c>24000 {
            list = [0:c/3, c/3+1:c/3*2, c/3*2+1:c]
        }
        
        let protocolQueue = DispatchQueue(label: "WisdomProtocolCoreQueue", attributes: DispatchQueue.Attributes.concurrent)
        for index in list { regist(types: types, begin: index.key, end: index.value) }

        func regist(types: UnsafeMutablePointer<AnyClass>, begin: Int, end: Int) {
            protocolQueue.async {
                for index in begin ..< end {
                    if class_conformsToProtocol(types[index], WisdomRegisterable.self) {
                        if let ableClass = (types[index] as? WisdomRegisterable.Type)?.registerable() {
                            _=registerableConfig(register: ableClass.registerProtocol, conform: ableClass.conformClass)
                        }
                    }
                }
            }
        }
        
        protocolQueue.sync(flags: .barrier) {
            types.deallocate()
            print("WisdomProtocol Queue Took "+"\(CFAbsoluteTimeGetCurrent() - start)")
        }
    }
    
    static func registerable(classable: WisdomClassable)->Protocol{
        return registerableConfig(register: classable.registerProtocol, conform: classable.conformClass)
    }
    
    //static func registerable(classables: [WisdomClassable])->[Protocol]{
    //    let protocols = classables.compactMap { classable in
    //        registerableConfig(register: classable.registerProtocol, conform: classable.conformClass)
    //    }
    //    return protocols
    //}
}

extension WisdomProtocolCore: WisdomProtocolCreateable{
    
    static func create(protocolName: String) -> Protocol? {
        return NSProtocolFromString(protocolName)
    }
    
    static func create(projectName: String, protocolName: String) -> Protocol? {
        let name = projectName+"."+protocolName
        return NSProtocolFromString(name)
    }
}

extension WisdomProtocolCore: WisdomProtocolable {
    
    static func getClassable(from Protocol: Protocol)->AnyClass? {
        let protocolKey = NSStringFromProtocol(Protocol)
        print("WisdomProtocol.getClassable: "+protocolKey)

        if let conformClass: AnyClass = WisdomProtocolConfig[protocolKey], conformClass.conforms(to: Protocol) {
            return conformClass
        }
        return nil
    }
    
    static func getViewable(from Protocol: Protocol)->UIView.Type? {
        if let conformClass = getClassable(from: Protocol), let conformView = conformClass as? UIView.Type {
            return conformView
        }
        return nil
    }
    
    static func getControlable(from Protocol: Protocol)->UIViewController.Type? {
        if let conformClass = getClassable(from: Protocol), let conformController = conformClass as? UIViewController.Type {
            return conformController
        }
        return nil
    }
}

extension WisdomProtocolCore: WisdomProtocolRouterable{
    
    static func getRouterClassable(from Protocol: Protocol)->WisdomRouterClassable.Type?{
        if let classable = Self.getClassable(from: Protocol), classable.conforms(to: WisdomRouterClassable.self),
           let paramable = classable as? WisdomRouterClassable.Type {
            return paramable
        }
        return nil
    }

    static func getRouterViewable(from Protocol: Protocol)->WisdomRouterViewable.Type?{
        if let classable = Self.getViewable(from: Protocol), classable.conforms(to: WisdomRouterViewable.self),
           let viewable = classable as? WisdomRouterViewable.Type {
            return viewable
        }
        return nil
    }

    static func getRouterControlable(from Protocol: Protocol)->WisdomRouterControlable.Type?{
        if let classable = Self.getControlable(from: Protocol), classable.conforms(to: WisdomRouterControlable.self),
           let controlable = classable as? WisdomRouterControlable.Type {
            return controlable
        }
        return nil
    }
}

extension WisdomProtocolCore: WisdomCodingCoreable {
    
    static func decodable<T>(_ type: T.Type, value: Any)->T? where T: Decodable{
        guard let data = try? JSONSerialization.data(withJSONObject: value) else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
        return try? decoder.decode(type, from: data)
    }
    
    static func decodable<T>(_ type: T.Type, list: [[String:Any]])->[T] where T: Decodable{
        let result: [T] = list.compactMap { value in
            let able = Self.decodable(type, value: value)
            assert(able==nil, "decodable failure: \(value)")
            return able
        }
        return result
    }
    
    static func jsonable<T>(_ type: T.Type, json: String)->T? where T: Decodable{
        let decoder = JSONDecoder()
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
        guard let able = try? decoder.decode(type, from: json.data(using: .utf8)!) else {
            return nil
        }
        return able
    }
    
    static func jsonable<T>(_ type: T.Type, jsons: String)->[T] where T: Decodable{
        guard let jsonsData = jsons.data(using: .utf8) else {
            return []
        }
        guard let array = try? JSONSerialization.jsonObject(with: jsonsData, options: .mutableContainers), let result = array as? [[String:Any]] else {
            return []
        }
        return decodable(type, list: result)
    }
    
    static func ableJson<T>(_ able: T)->String? where T: Encodable{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(able) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    static func ableEncod<T>(_ able: T)->[String:Any]? where T: Encodable{
        if let jsonString = ableJson(able){
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

extension WisdomProtocolCore: WisdomTimerCoreable {
    
    static func startAddTimer(able: WisdomTimerable, startTime: NSInteger){
        let key = "\(able)".replacingOccurrences(of: " ", with: "")
        if let historyable = WisdomTimerConfig[key] {
            historyable.destroy()
            WisdomTimerConfig.removeValue(forKey: key)
        }
        
        let timer = WisdomTimerModel(able: able, currentTime: startTime, isDown: false) {
            WisdomTimerConfig.removeValue(forKey: key)
        }
        WisdomTimerConfig[key]=timer
    }
    
    static func startDownTimer(able: WisdomTimerable, totalTime: NSInteger){
        let key = "\(able)".replacingOccurrences(of: " ", with: "")
        if let historyable = WisdomTimerConfig[key] {
            historyable.destroy()
            WisdomTimerConfig.removeValue(forKey: key)
        }
        
        let timer = WisdomTimerModel(able: able, currentTime: totalTime, isDown: true) {
            WisdomTimerConfig.removeValue(forKey: key)
        }
        print(key)
        WisdomTimerConfig[key]=timer
    }
    
    static func suspendTimer(able: WisdomTimerable){
        
    }
    
    static func resumeTimer(able: WisdomTimerable){
        
    }
    
    static func destroyTimer(able: WisdomTimerable){
        
    }
}
