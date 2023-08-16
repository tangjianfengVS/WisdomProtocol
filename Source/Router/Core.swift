//
//  Core.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2023/8/16.
//

import UIKit


extension WisdomProtocolCore {
    
    private static var WisdomProtocolConfig: [String:AnyClass] = [:]
    
    // MARK: registerProtocol protocol class
    private static func registerableConfig(register aProtocol: Protocol, conform aClass: AnyClass)->Protocol {
        let key = NSStringFromProtocol(aProtocol)
        if WisdomProtocolConfig[key] != nil {
            print("❌[WisdomProtocol] register redo conforming: "+key+"->"+NSStringFromClass(aClass)+"❌")
            return aProtocol
        }
        //print("🐬[WisdomProtocol] register successful: "+key+"->"+NSStringFromClass(aClass)+"🐬")
        WisdomProtocolConfig.updateValue(aClass, forKey: key)
        return aProtocol
    }
}

extension WisdomProtocolCore {
    
    @objc class func registerRouterable() {
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
        for index in list { register(types: types, begin: index.key, end: index.value) }

        func register(types: UnsafeMutablePointer<AnyClass>, begin: Int, end: Int) {
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
            types.deinitialize(count: c)
            types.deallocate()
            print("[WisdomProtocol] Queue Took "+"\(CFAbsoluteTimeGetCurrent()-start) \(c) \(list.count)")
        }
    }
    
    static func registerable(classable: WisdomClassable)->Protocol{
        return registerableConfig(register: classable.registerProtocol, conform: classable.conformClass)
    }
}

extension WisdomProtocolCore: WisdomProtocolable {
    
    static func getClassable(from Protocol: Protocol)->AnyClass? {
        let protocolKey = NSStringFromProtocol(Protocol)
        print("[WisdomProtocol] getClassable: "+protocolKey)

        if let conformClass: AnyClass = WisdomProtocolConfig[protocolKey] {
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
    
    static func getImageable(from Protocol: Protocol)->UIImage.Type?{
        if let conformClass = getClassable(from: Protocol), let conformImage = conformClass as? UIImage.Type {
            return conformImage
        }
        return nil
    }
    
    static func getBundleable(from Protocol: Protocol)->Bundle.Type?{
        if let conformClass = getClassable(from: Protocol), let conformImage = conformClass as? Bundle.Type {
            return conformImage
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

    static func getRouterImageable(from Protocol: Protocol)->WisdomRouterImageable.Type?{
        if let classable = Self.getImageable(from: Protocol), classable.conforms(to: WisdomRouterImageable.self),
           let imageable = classable as? WisdomRouterImageable.Type {
            return imageable
        }
        return nil
    }

    static func getRouterBundleable(from Protocol: Protocol)->WisdomRouterBundleable.Type?{
        if let classable = Self.getBundleable(from: Protocol), classable.conforms(to: WisdomRouterBundleable.self),
           let bundleable = classable as? WisdomRouterBundleable.Type {
            return bundleable
        }
        return nil
    }

    static func getRouterNibable(from Protocol: Protocol)->WisdomRouterNibable.Type?{
        if let classable = Self.getBundleable(from: Protocol), classable.conforms(to: WisdomRouterNibable.self),
           let nibable = classable as? WisdomRouterNibable.Type {
            return nibable
        }
        return nil
    }
}
