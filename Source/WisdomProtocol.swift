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

extension WisdomProtocol: WisdomProtocolable {
    
    // MARK: Get AnyClass From Protocol
    @objc public static func getClassable(fromProtocol: Protocol)->AnyClass?{
        return WisdomProtocolCore.getClassable(fromProtocol: fromProtocol)
    }

    // MARK: Get UIView.Type From Protocol
    @objc public static func getViewable(fromProtocol: Protocol)->UIView.Type?{
        return WisdomProtocolCore.getViewable(fromProtocol: fromProtocol)
    }

    // MARK: Get UIViewController.Type From Protocol
    @objc public static func getControlable(fromProtocol: Protocol)->UIViewController.Type?{
        return WisdomProtocolCore.getControlable(fromProtocol: fromProtocol)
    }
}

extension WisdomProtocol: WisdomProtocolRouterable {

    // MARK: Get Router AnyClass From Protocol
    @objc public static func getRouterClassable(fromProtocol: Protocol)->WisdomRouterClassable.Type?{
        return WisdomProtocolCore.getRouterClassable(fromProtocol: fromProtocol)
    }

    // MARK: Get Router UIView.Type From Protocol
    @objc public static func getRouterViewable(fromProtocol: Protocol)->WisdomRouterViewable.Type?{
        return WisdomProtocolCore.getRouterViewable(fromProtocol: fromProtocol)
    }

    // MARK: Get Router UIViewController.Type From Protocol
    @objc public static func getRouterControlable(fromProtocol: Protocol)->WisdomRouterControlable.Type?{
        return WisdomProtocolCore.getRouterControlable(fromProtocol: fromProtocol)
    }
}
