//
//  RAble.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2023/8/16.
//

import UIKit

protocol WisdomProtocolable {

    static func getClassable(from Protocol: Protocol)->AnyClass?

    static func getViewable(from Protocol: Protocol)->UIView.Type?

    static func getControlable(from Protocol: Protocol)->UIViewController.Type?
    
    static func getImageable(from Protocol: Protocol)->UIImage.Type?
    
    static func getBundleable(from Protocol: Protocol)->Bundle.Type?
}

protocol WisdomProtocolRouterable {

    static func getRouterClassable(from Protocol: Protocol)->WisdomRouterClassable.Type?

    static func getRouterViewable(from Protocol: Protocol)->WisdomRouterViewable.Type?

    static func getRouterControlable(from Protocol: Protocol)->WisdomRouterControlable.Type?
    
    static func getRouterImageable(from Protocol: Protocol)->WisdomRouterImageable.Type?
    
    static func getRouterBundleable(from Protocol: Protocol)->WisdomRouterBundleable.Type?
    
    static func getRouterNibable(from Protocol: Protocol)->WisdomRouterNibable.Type?
}
