//
//  WisdomRouterable.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/11.
//

import UIKit

// MARK: - Regist Protocol
@objc public protocol WisdomRegisterable {

    //static func registSwiftable()->SwiftableClass?
}


// MARK: - Router Param Protocol
@objc public protocol WisdomRouterParamable {

    // MARK: Param - Any?
    func routerParamable(param: Any?)

    // MARK: Param - Any?, ((Any)->Void)?
    func routerParamable(param: Any?, closure: ((Any)->Void)?)->Self

    // MARK: Param - Any?, ((Any)->(Any))?
    func routerParamable(param: Any?, returnClosure: ((Any)->(Any))?)->Self
}


//// MARK: - Class Param Protocol
//@objc public protocol SwiftClassParamable {
//
//    // MARK: Param - Any?
//    static func setParamable(param: Any?)
//
//    // MARK: Param - Any?, SwiftProtocolClosure
//    static func setParamable(param: Any?, closure: SwiftProtocolClosure?)
//
//    // MARK: Param - Any?, SwiftProtocolReturnClosure
//    static func setParamable(param: Any?, returnClosure: SwiftProtocolReturnClosure?)
//}
//


// MARK: - Router UIViewController Protocol
@objc public protocol WisdomRouterContrable where Self: UIViewController {

    // MARK: Param - UIViewController?, Any?
    @discardableResult
    static func routerContrable(rootVC: UIViewController?, param: Any?)->Self

    // MARK: Param - UIViewController?, Any?, ((Any)->Void)?
    @discardableResult
    static func routerContrable(rootVC: UIViewController?, param: Any?, closure: ((Any)->Void)?)->Self

    // MARK: Param - UIViewController?, Any?, ((Any)->(Any))?
    @discardableResult
    static func routerContrable(rootVC: UIViewController?, param: Any?, returnClosure: ((Any)->(Any))?)->Self
}


// MARK: - Router UIView Protocol
@objc public protocol WisdomRouterViewable where Self: UIView  {

    // MARK: Param - UIView?, Any?
    @discardableResult
    static func routerViewable(superview: UIView?, param: Any?)->Self

    // MARK: Param - UIView?, Any?, ((Any)->Void)?
    @discardableResult
    static func routerViewable(superview: UIView?, param: Any?, closure: ((Any)->Void)?)->Self

    // MARK: Param - UIView?, Any?, ((Any)->(Any))?
    @discardableResult
    static func routerViewable(superview: UIView?, param: Any?, returnClosure: ((Any)->(Any))?)->Self
}


//protocol SwiftConformable {
//
//    static func getConformableClass(fromProtocol: Protocol?) -> (fromProtocol: Protocol, conformClass: AnyClass)?
//
//    static func getConformableView(fromProtocol: Protocol?) -> (fromProtocol: Protocol, conformClass: UIView.Type)?
//
//    static func getConformableController(fromProtocol: Protocol?) -> (fromProtocol: Protocol, conformClass: UIViewController.Type)?
//}
