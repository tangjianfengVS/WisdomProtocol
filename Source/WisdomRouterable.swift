//
//  WisdomRouterable.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/11.
//

import UIKit

// MARK: - Regist Protocol
@objc public protocol WisdomRegisterable {

    @objc static func registerable()->SwiftableClass?
}


// MARK: - Router Param Protocol
@objc public protocol WisdomRouterParamable {

    // MARK: Param - Any?
    @discardableResult
    @objc func routerParamable(param: Any?)->Self

    // MARK: Param - Any?, ((Any)->Void)?
    @discardableResult
    @objc func routerParamable(param: Any?, closure: ((Any)->Void)?)->Self

    // MARK: Param - Any?, ((Any)->(Any))?
    @discardableResult
    @objc func routerParamable(param: Any?, returnClosure: ((Any)->(Any))?)->Self
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
    @objc static func routerContrable(rootVC: UIViewController?, param: Any?)->Self

    // MARK: Param - UIViewController?, Any?, ((Any)->Void)?
    @discardableResult
    @objc static func routerContrable(rootVC: UIViewController?, param: Any?, closure: ((Any)->Void)?)->Self

    // MARK: Param - UIViewController?, Any?, ((Any)->(Any))?
    @discardableResult
    @objc static func routerContrable(rootVC: UIViewController?, param: Any?, returnClosure: ((Any)->(Any))?)->Self
}


// MARK: - Router UIView Protocol
@objc public protocol WisdomRouterViewable where Self: UIView  {

    // MARK: Param - UIView?, Any?
    @discardableResult
    @objc static func routerViewable(superview: UIView?, param: Any?)->Self

    // MARK: Param - UIView?, Any?, ((Any)->Void)?
    @discardableResult
    @objc static func routerViewable(superview: UIView?, param: Any?, closure: ((Any)->Void)?)->Self

    // MARK: Param - UIView?, Any?, ((Any)->(Any))?
    @discardableResult
    @objc static func routerViewable(superview: UIView?, param: Any?, returnClosure: ((Any)->(Any))?)->Self
}


//protocol SwiftConformable {
//
//    static func getConformableClass(fromProtocol: Protocol?) -> (fromProtocol: Protocol, conformClass: AnyClass)?
//
//    static func getConformableView(fromProtocol: Protocol?) -> (fromProtocol: Protocol, conformClass: UIView.Type)?
//
//    static func getConformableController(fromProtocol: Protocol?) -> (fromProtocol: Protocol, conformClass: UIViewController.Type)?
//}


@objc public final class SwiftableClass: NSObject {
    
//    let registProtocol: Protocol
//
//    let conformClass: AnyClass
    
//    public static func build(registProtocol: Protocol, conformClass: AnyClass) throws -> SwiftableClass{
//        let key = NSStringFromProtocol(registProtocol)
//        let value: AnyClass = conformClass
//
//        if !class_conformsToProtocol(conformClass, registProtocol) {
//            print("[SwiftProtocolKit] register nonConforming: ❌"+key+" -> "+NSStringFromClass(value)+"❌")
//            throw SwiftableError.nonConforming
//        }
//
//        if SwiftProtocolConfig[key] != nil {
//            print("[SwiftProtocolKit] register redoConforming: ❌"+key+" -> "+NSStringFromClass(value)+"❌")
//            throw SwiftableError.redoConforming
//        }
//        return SwiftableClass(registProtocol: registProtocol, conformClass: conformClass)
//    }
    
//    private init(registProtocol: Protocol, conformClass: AnyClass) {
//        self.registProtocol = registProtocol
//        self.conformClass = conformClass
//        super.init()
//    }
}
