//
//  WisdomProtocolable.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/14.
//

import UIKit

// MARK: - Regist Class Protocol
@objc public final class WisdomClassable: NSObject {
    
    let registProtocol: Protocol

    let conformClass: AnyClass
    
    @objc public init(registerProtocol: Protocol, conformClass: AnyClass) {
        self.registProtocol = registerProtocol
        self.conformClass = conformClass
        super.init()
    }
}


// MARK: - Regist Protocol
@objc public protocol WisdomRegisterable {

    @objc static func registerable()->WisdomClassable
}

protocol WisdomProtocolable {

    static func getClassable(fromProtocol: Protocol)->AnyClass?

    static func getViewable(fromProtocol: Protocol)->UIView.Type?

    static func getControlable(fromProtocol: Protocol)->UIViewController.Type?
}

protocol WisdomProtocolRouterable {

    static func getRouterClassable(fromProtocol: Protocol)->WisdomRouterClassable.Type?

    static func getRouterViewable(fromProtocol: Protocol)->WisdomRouterViewable.Type?

    static func getRouterControlable(fromProtocol: Protocol)->WisdomRouterControlable.Type?
}
