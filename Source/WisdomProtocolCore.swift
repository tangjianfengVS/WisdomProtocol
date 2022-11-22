//
//  WisdomProtocolCore.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/14.
//

import UIKit

extension AppDelegate {
    
    override var next: UIResponder? {
        get {
            if WisdomProtocolCore.WisdomRegisterState == 0 {
                WisdomProtocolCore.WisdomRegisterState = 1
                WisdomProtocolCore.registerable()
            }
            return super.next
        }
    }
}


struct WisdomProtocolCore {
    
    private static var WisdomProtocolConfig: [String:AnyClass] = [:]

    fileprivate static var WisdomRegisterState: Int = 0
    
    fileprivate static func registerable() {
        let start = CFAbsoluteTimeGetCurrent()
        let protocolQueue = DispatchQueue(label: "WisdomProtocolCoreQueue", attributes: DispatchQueue.Attributes.concurrent)

        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        
        //let list: [Int:Int] = [0: typeCount/3, typeCount/3+1: typeCount/3*2, typeCount/3*2+1: typeCount]
        let list: [Int:Int] = [0: typeCount/2, typeCount/2+1: typeCount]
        for index in list { regist(types: types, begin: index.key, end: index.value) }
        
        func regist(types: UnsafeMutablePointer<AnyClass>, begin: Int, end: Int) {
            protocolQueue.async {
                for index in begin ..< end {
                    if class_conformsToProtocol(types[index], WisdomRegisterable.self) {
                        if let ableClass = (types[index] as? WisdomRegisterable.Type)?.registerable() {
                            registerableConfig(registerProtocol: ableClass.registerProtocol, conformClass: ableClass.conformClass)
                        }
                    }
                }
            }
        }
        
        protocolQueue.sync(flags: .barrier) {
            types.deallocate()
            let diff = CFAbsoluteTimeGetCurrent() - start
            print("WisdomProtocolCore Queue Took " + "\(diff)")
        }
    }
    
    // MARK: registerProtocol protocol class
    private static func registerableConfig(registerProtocol: Protocol, conformClass: AnyClass) {
        let key = NSStringFromProtocol(registerProtocol)
        if !class_conformsToProtocol(conformClass, registerProtocol) {
            print("❌[WisdomProtocol] register no conforming: "+key+" -> "+NSStringFromClass(conformClass)+"❌")
            return
        }
        if WisdomProtocolConfig[key] != nil {
            print("❌[WisdomProtocol] register redo conforming: "+key+" -> "+NSStringFromClass(conformClass)+"❌")
            return
        }
        WisdomProtocolConfig.updateValue(conformClass, forKey: key)
    }
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
