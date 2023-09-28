//
//  Router.swift
//  WisdomProtocol
//
//  Created by tangjianfeng on 2022/11/11.
//

import UIKit


// ----------------------- Register able --------------------------- //
// (1). Router 'Protocol' 'AnyClass' binding                         //
// (2). If there is compliance, will be actively called              //
// ----------------------------------------------------------------- //

// MARK: - Register Protocol
@objc public protocol WisdomRouterRegisterable {

    @objc static func registerable()->Protocol
}


// MARK: - Router Class Protocol. < No need to implement >
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


// MARK: - Router Param Protocol. < No need to implement >
@objc public protocol WisdomRouterParamable {

    // MARK: Param - Any?
    @objc optional func routerParamable(param: Any?)

    // MARK: Param - Any?, ((Any)->Void)?
    @objc optional func routerParamable(param: Any?, closure: ((Any)->Void)?)

    // MARK: Param - Any?, ((Any)->(Any))?
    @objc optional func routerParamable(param: Any?, returnClosure: ((Any)->(Any))?)
}


// MARK: - Router UIViewController Protocol. < No need to implement >
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


// MARK: - Router UIView Protocol. < No need to implement >
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


// MARK: - Router UIImage Protocol. < No need to implement >
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


// MARK: - Router Bundle Protocol. < No need to implement >
@objc public protocol WisdomRouterBundleable where Self: Bundle {
    
    // MARK: Bundle.main
    @discardableResult
    @objc optional static func routerBundleable()->Bundle

    // MARK: Param - String, String
    @discardableResult
    @objc optional static func routerBundleable(resource: String, ofType: String)->Bundle?

    // MARK: Param - String, String, ((Any)->Void)?
    @discardableResult
    @objc optional static func routerBundleable(resource: String, ofType: String, closure: ((Any)->Void)?)->Bundle?

    // MARK: Param - String, String, ((Any)->(Any))?
    @discardableResult
    @objc optional static func routerBundleable(resource: String, ofType: String, returnClosure: ((Any)->(Any))?)->Bundle?
}


// MARK: - Router UINib Protocol. < No need to implement >
@objc public protocol WisdomRouterNibable where Self: Bundle  {

    // MARK: Param - String, Any?, [UINib.OptionsKey: Any]?
    @discardableResult
    @objc optional static func routerNibable(name: String, owner: Any?, options: [UINib.OptionsKey: Any]?)->[Any]?

    // MARK: Param - String, Any?, [UINib.OptionsKey: Any]?, ((Any)->Void)?
    @discardableResult
    @objc optional static func routerNibable(name: String, owner: Any?, options: [UINib.OptionsKey: Any]?, closure: ((Any)->Void)?)->[Any]?

    // MARK: Param - String, Any?, [UINib.OptionsKey: Any]?, ((Any)->(Any))?
    @discardableResult
    @objc optional static func routerNibable(name: String, owner: Any?, options: [UINib.OptionsKey: Any]?, returnClosure: ((Any)->(Any))?)->[Any]?
}
