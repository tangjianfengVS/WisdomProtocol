//
//  WisdomProtocolable.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/14.
//

import UIKit

// MARK: - register Class Protocol
@objc public final class WisdomClassable: NSObject {
    
    let registerProtocol: Protocol

    let conformClass: AnyClass
    
    @objc public init(register Protocol: Protocol, conform Class: AnyClass) {
        self.registerProtocol = Protocol
        self.conformClass = Class
        super.init()
    }
}


// MARK: - Regist Protocol
@objc public protocol WisdomRegisterable {

    @objc static func registerable()->WisdomClassable
}

protocol WisdomProtocolable {

    static func getClassable(from Protocol: Protocol)->AnyClass?

    static func getViewable(from Protocol: Protocol)->UIView.Type?

    static func getControlable(from Protocol: Protocol)->UIViewController.Type?
}

protocol WisdomProtocolRouterable {

    static func getRouterClassable(from Protocol: Protocol)->WisdomRouterClassable.Type?

    static func getRouterViewable(from Protocol: Protocol)->WisdomRouterViewable.Type?

    static func getRouterControlable(from Protocol: Protocol)->WisdomRouterControlable.Type?
}

protocol WisdomProtocolCreateable {

    static func create(protocolName: String)->Protocol?
    
    static func create(projectName: String, protocolName: String)->Protocol?
}
