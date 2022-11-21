//
//  WisdomRegisterable.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/21.
//

import Foundation

// MARK: - Regist Protocol
@objc public protocol WisdomRegisterable {

    @objc static func registerable()->WisdomClassable
}


@objc public final class WisdomClassable: NSObject {
    
    let registProtocol: Protocol

    let conformClass: AnyClass
    
//    public static func build(registProtocol: Protocol, conformClass: AnyClass) throws -> SwiftableClass{
//        let key = NSStringFromProtocol(registProtocol)
//        let value: AnyClass = conformClass
//
//        if !class_conformsToProtocol(conformClass, registProtocol) {
//            print("[SwiftProtocolKit] register nonConforming: ❌"+key+" -> "+NSStringFromClass(value)+"❌")
//            throw SwiftableError.nonConforming
//        }
//
//        if SwiftProtocolConfig[key] != nil {
//            print("[SwiftProtocolKit] register redoConforming: ❌"+key+" -> "+NSStringFromClass(value)+"❌")
//            throw SwiftableError.redoConforming
//        }
//        return SwiftableClass(registProtocol: registProtocol, conformClass: conformClass)
//    }
    
//    @available(*, unavailable)
//    override init() {}

    @objc public init(registerProtocol: Protocol, conformClass: AnyClass) {
        self.registProtocol = registerProtocol
        self.conformClass = conformClass
        super.init()
    }
}
