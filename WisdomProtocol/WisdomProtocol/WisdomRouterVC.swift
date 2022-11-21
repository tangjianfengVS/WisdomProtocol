//
//  WisdomRouterVC.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/21.
//

import UIKit


@objc protocol WisdomRouterProtocol {}

class WisdomRouterVC: UIViewController, WisdomRegisterable, WisdomRouterProtocol {
    
    static func registerable() -> WisdomClassable {
        return WisdomClassable(registerProtocol: WisdomRouterProtocol.self, conformClass: Self.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.cyan
        // Do any additional setup after loading the view.
    }
    
}

extension WisdomRouterVC: WisdomRouterControlable {
    
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
        return WisdomClassable(registerProtocol: WisdomRouterViewProtocol.self, conformClass: Self.self)
    }
    
}

extension WisdomRouterView: WisdomRouterViewable {

    static func routerViewable(superview: UIView?, param: Any?) -> Self {
        let vi = Self.init()
        return vi
    }
}
