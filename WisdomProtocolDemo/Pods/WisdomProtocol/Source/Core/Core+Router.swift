//
//  Core+Router.swift
//  Pods
//
//  Created by jianfeng tang on 2023/10/14.
//

import UIKit

extension WisdomProtocolCore {
    
    // MARK: registerProtocol protocol class
    static func registerableConfig(register aProtocol: Protocol, conform aClass: AnyClass)->Protocol {
        let key = NSStringFromProtocol(aProtocol)
        if WisdomProtocolConfig[key] != nil {
            print("❌[WisdomProtocol] register redo conforming: "+key+"->"+NSStringFromClass(aClass)+"❌")
            return aProtocol
        }
        //print("🐬[WisdomProtocol] register successful: "+key+"->"+NSStringFromClass(aClass)+"🐬")
        WisdomProtocolConfig.updateValue(aClass, forKey: key)
        return aProtocol
    }
    
    static func registerable(from Protocol: Protocol, classable: AnyClass)->Protocol{
        return registerableConfig(register: Protocol, conform: classable)
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
