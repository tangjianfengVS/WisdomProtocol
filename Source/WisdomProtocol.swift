//
//  WisdomProtocol.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/21.
//

import UIKit

@objc public final class WisdomProtocol: NSObject {

    @available(*, unavailable)
    override init() {}
}

extension WisdomProtocol: WisdomProtocolCreateable{
    
    // MARK: Create Protocol From Protocol Name: String
    static func create(protocolName: String) -> Protocol? {
        return WisdomProtocolCore.create(protocolName: protocolName)
    }
    
    // MARK: Create Protocol From Project Name: String, Protocol Name: String
    static func create(projectName: String, protocolName: String) -> Protocol? {
        return WisdomProtocolCore.create(projectName: projectName, protocolName: protocolName)
    }
}

extension WisdomProtocol: WisdomProtocolable {
    
    // MARK: Get AnyClass From Protocol
    @objc public static func getClassable(from Protocol: Protocol)->AnyClass?{
        return WisdomProtocolCore.getClassable(from: Protocol)
    }

    // MARK: Get UIView.Type From Protocol
    @objc public static func getViewable(from Protocol: Protocol)->UIView.Type?{
        return WisdomProtocolCore.getViewable(from: Protocol)
    }

    // MARK: Get UIViewController.Type From Protocol
    @objc public static func getControlable(from Protocol: Protocol)->UIViewController.Type?{
        return WisdomProtocolCore.getControlable(from: Protocol)
    }
}

extension WisdomProtocol: WisdomProtocolRouterable {

    // MARK: Get Router AnyClass From Protocol
    @objc public static func getRouterClassable(from Protocol: Protocol)->WisdomRouterClassable.Type?{
        return WisdomProtocolCore.getRouterClassable(from: Protocol)
    }

    // MARK: Get Router UIView.Type From Protocol
    @objc public static func getRouterViewable(from Protocol: Protocol)->WisdomRouterViewable.Type?{
        return WisdomProtocolCore.getRouterViewable(from: Protocol)
    }

    // MARK: Get Router UIViewController.Type From Protocol
    @objc public static func getRouterControlable(from Protocol: Protocol)->WisdomRouterControlable.Type?{
        return WisdomProtocolCore.getRouterControlable(from: Protocol)
    }
}
