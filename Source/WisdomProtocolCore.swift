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
                            registerableConfig(registProtocol: ableClass.registProtocol, conformClass: ableClass.conformClass)
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
    
    // MARK: regist protocol class
    private static func registerableConfig(registProtocol: Protocol, conformClass: AnyClass) {
        let key = NSStringFromProtocol(registProtocol)
        if !class_conformsToProtocol(conformClass, registProtocol) {
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

extension WisdomProtocolCore: WisdomProtocolable {
    
    static func getClassable(fromProtocol: Protocol)->AnyClass? {
        let protocolKey = NSStringFromProtocol(fromProtocol)
        print("WisdomProtocol.getClassable: "+protocolKey)

        if let conformClass: AnyClass = WisdomProtocolConfig[protocolKey], conformClass.conforms(to: fromProtocol) {
            return conformClass
        }
        return nil
    }
    
    static func getViewable(fromProtocol: Protocol)->UIView.Type? {
        if let conformClass = getClassable(fromProtocol: fromProtocol), let conformView = conformClass as? UIView.Type {
            return conformView
        }
        return nil
    }
    
    static func getControlable(fromProtocol: Protocol)->UIViewController.Type? {
        if let conformClass = getClassable(fromProtocol: fromProtocol), let conformController = conformClass as? UIViewController.Type {
            return conformController
        }
        return nil
    }
}

extension WisdomProtocolCore: WisdomProtocolRouterable{
    
    static func getRouterClassable(fromProtocol: Protocol)->WisdomRouterClassable.Type?{
        if let classable = Self.getClassable(fromProtocol: fromProtocol), classable.conforms(to: WisdomRouterClassable.self),
           let paramable = classable as? WisdomRouterClassable.Type {
            return paramable
        }
        return nil
    }

    static func getRouterViewable(fromProtocol: Protocol)->WisdomRouterViewable.Type?{
        if let classable = Self.getViewable(fromProtocol: fromProtocol), classable.conforms(to: WisdomRouterViewable.self),
           let viewable = classable as? WisdomRouterViewable.Type {
            return viewable
        }
        return nil
    }

    static func getRouterControlable(fromProtocol: Protocol)->WisdomRouterControlable.Type?{
        if let classable = Self.getControlable(fromProtocol: fromProtocol), classable.conforms(to: WisdomRouterControlable.self),
           let controlable = classable as? WisdomRouterControlable.Type {
            return controlable
        }
        return nil
    }
}
