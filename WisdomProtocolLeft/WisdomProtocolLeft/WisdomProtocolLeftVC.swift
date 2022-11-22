//
//  WisdomProtocolLeftVC.swift
//  WisdomProtocolLeft
//
//  Created by 汤建锋 on 2022/11/22.
//

import UIKit
import WisdomProtocol


@objc protocol WisdomProtocolLeftVCProtocol {}

class WisdomProtocolLeftVC: UIViewController, WisdomRegisterable, WisdomProtocolLeftVCProtocol {

    static func registerable() -> WisdomClassable {
        return WisdomClassable(register: WisdomProtocolLeftVCProtocol.self, conform: Self.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .black
    }

}

extension WisdomProtocolLeftVC: WisdomRouterControlable {

    @discardableResult
    static func routerControlable(rootVC: UIViewController?, param: Any?) -> Self {
        let vc = Self.init()
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)

        return vc
    }
}


@objc protocol WisdomProtocolLeftVIProtocol {}

class WisdomProtocolLeftVI: UIView, WisdomRegisterable, WisdomProtocolLeftVIProtocol {
    
    static func registerable() -> WisdomClassable {
        return WisdomClassable(register: WisdomProtocolLeftVIProtocol.self, conform: Self.self)
    }
    
}

extension WisdomProtocolLeftVI: WisdomRouterViewable {

    static func routerViewable(superview: UIView?, param: Any?) -> Self {
        let vi = Self.init()
        return vi
    }
}


@objc protocol WisdomProtocolLeftPamProtocol {}

class WisdomProtocolLeftCls: WisdomRegisterable, WisdomProtocolLeftPamProtocol {

    static func registerable() -> WisdomClassable {
        return WisdomClassable(register: WisdomProtocolLeftPamProtocol.self, conform: Self.self)
    }

    required init() {

    }
}

extension WisdomProtocolLeftCls: WisdomRouterClassable {

    static func routerClassable(param: Any?) -> Self {
        let cls = Self.init()
        return cls
    }
}

extension WisdomProtocolLeftCls: WisdomRouterParamable {

    func routerParamable(param: Any?) {
        print("")
    }
}
