//
//  WisdomRouterable.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/11.
//

import UIKit


// MARK: - Router Class Protocol
@objc public protocol WisdomRouterClassable {

    // MARK: Param - Any?
    @discardableResult
    @objc optional static func routerClassable(param: Any?)->Self

    // MARK: Param - Any?, ((Any)->Void)?
    @discardableResult
    @objc optional static func routerClassable(param: Any?, closure: ((Any)->Void)?)->Self

    // MARK: Param - Any?, ((Any)->(Any))?
    @discardableResult
    @objc optional static func routerClassable(param: Any?, returnClosure: ((Any)->(Any))?)->Self
}


// MARK: - Router Param Protocol
@objc public protocol WisdomRouterParamable {

    // MARK: Param - Any?
    @objc optional func routerParamable(param: Any?)

    // MARK: Param - Any?, ((Any)->Void)?
    @objc optional func routerParamable(param: Any?, closure: ((Any)->Void)?)

    // MARK: Param - Any?, ((Any)->(Any))?
    @objc optional func routerParamable(param: Any?, returnClosure: ((Any)->(Any))?)
}


// MARK: - Router UIViewController Protocol
@objc public protocol WisdomRouterControlable where Self: UIViewController {

    // MARK: Param - UIViewController?, Any?
    @discardableResult
    @objc optional static func routerControlable(rootVC: UIViewController?, param: Any?)->Self

    // MARK: Param - UIViewController?, Any?, ((Any)->Void)?
    @discardableResult
    @objc optional static func routerControlable(rootVC: UIViewController?, param: Any?, closure: ((Any)->Void)?)->Self

    // MARK: Param - UIViewController?, Any?, ((Any)->(Any))?
    @discardableResult
    @objc optional static func routerControlable(rootVC: UIViewController?, param: Any?, returnClosure: ((Any)->(Any))?)->Self
}


// MARK: - Router UIView Protocol
@objc public protocol WisdomRouterViewable where Self: UIView  {

    // MARK: Param - UIView?, Any?
    @discardableResult
    @objc optional static func routerViewable(superview: UIView?, param: Any?)->Self

    // MARK: Param - UIView?, Any?, ((Any)->Void)?
    @discardableResult
    @objc optional static func routerViewable(superview: UIView?, param: Any?, closure: ((Any)->Void)?)->Self

    // MARK: Param - UIView?, Any?, ((Any)->(Any))?
    @discardableResult
    @objc optional static func routerViewable(superview: UIView?, param: Any?, returnClosure: ((Any)->(Any))?)->Self
}


// MARK: - Router UIImage Protocol
@objc public protocol WisdomRouterImageable where Self: UIImage {

    // MARK: Param - String
    @discardableResult
    @objc optional static func routerImageable(param: String)->UIImage?

    // MARK: Param - String, ((Any)->Void)?
    @discardableResult
    @objc optional static func routerImageable(param: String, closure: ((Any)->Void)?)->UIImage?

    // MARK: Param - String, ((Any)->(Any))?
    @discardableResult
    @objc optional static func routerImageable(param: String, returnClosure: ((Any)->(Any))?)->UIImage?
}
