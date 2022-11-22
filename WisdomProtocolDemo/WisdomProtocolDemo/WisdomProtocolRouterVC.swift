//
//  WisdomRouterVC.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/21.
//

import UIKit
import WisdomProtocol

@objc protocol WisdomProtocolRouterVCable {}

class WisdomProtocolRouterVC: UIViewController, WisdomRegisterable, WisdomProtocolRouterVCable {
    
    static func registerable() -> WisdomClassable {
        return WisdomClassable(register: WisdomProtocolRouterVCable.self, conform: Self.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.cyan
        // Do any additional setup after loading the view.
    }
}

extension WisdomProtocolRouterVC: WisdomRouterControlable {
    
    @discardableResult
    static func routerControlable(rootVC: UIViewController?, param: Any?) -> Self {
        let vc = Self.init()
        vc.modalPresentationStyle = .fullScreen
        rootVC?.present(vc, animated: true)
        
        return vc
    }
}


@objc protocol WisdomRouterViewProtocol {}

class WisdomRouterView: UIView, WisdomRegisterable, WisdomRouterViewProtocol {
    
    static func registerable() -> WisdomClassable {
        return WisdomClassable(register: WisdomRouterViewProtocol.self, conform: Self.self)
    }
    
}

extension WisdomRouterView: WisdomRouterViewable {

    static func routerViewable(superview: UIView?, param: Any?) -> Self {
        let vi = Self.init()
        return vi
    }
}
