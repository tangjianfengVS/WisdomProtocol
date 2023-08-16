//
//  Protocol.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2023/8/16.
//

import UIKit


extension WisdomProtocol {
    
    // MARK: Register Protocol: WisdomClassable
    // * Need to ensure the timing of registration, the level must be the highest *
    //   用于 手动注册 或 静态库链接引用类。解决 WisdomProtocol 静态库链接注册类问题
    @discardableResult
    @objc public static func registerable(classable: WisdomClassable)->Protocol{
        return WisdomProtocolCore.registerable(classable: classable)
    }
}


// * Gets AnyClass / UIView.Type / UIViewController.Type / UIImage.Type / Bundle.Type *
// Gets the type of the registered binding protocol
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
    
    // MARK: Get UIImage.Type From Protocol
    @objc public static func getImageable(from Protocol: Protocol)->UIImage.Type?{
        return WisdomProtocolCore.getImageable(from: Protocol)
    }

    // MARK: Get Bundle.Type From Protocol
    @objc public static func getBundleable(from Protocol: Protocol)->Bundle.Type?{
        return WisdomProtocolCore.getBundleable(from: Protocol)
    }
}


// * Router Protocol *
// Gets Router WisdomRouterClassable.Type / WisdomRouterViewable.Type / WisdomRouterControlable.Type
// Gets Router WisdomRouterImageable.Type / WisdomRouterBundleable.Type / WisdomRouterNibable.Type
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
    
    // MARK: Get Router UIImage.Type From Protocol
    @objc public static func getRouterImageable(from Protocol: Protocol)->WisdomRouterImageable.Type?{
        return WisdomProtocolCore.getRouterImageable(from: Protocol)
    }
    
    // MARK: Get Router Bundle.Type From Protocol
    @objc public static func getRouterBundleable(from Protocol: Protocol)->WisdomRouterBundleable.Type?{
        return WisdomProtocolCore.getRouterBundleable(from: Protocol)
    }
    
    // MARK: Get Router UINib.Type From Protocol
    @objc public static func getRouterNibable(from Protocol: Protocol)->WisdomRouterNibable.Type?{
        return WisdomProtocolCore.getRouterNibable(from: Protocol)
    }
}
