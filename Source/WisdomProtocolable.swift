//
//  WisdomProtocolable.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/14.
//

import UIKit

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
