//
//  WisdomProtocolRightVC.swift
//  WisdomProtocolRight
//
//  Created by jianfeng tang on 2023/1/8.
//

import UIKit
import WisdomProtocol
import SnapKit

@objc protocol WisdomProtocolRightProtocol {}

class WisdomProtocolRightVC: UIViewController, WisdomRegisterable, WisdomProtocolRightProtocol  {
    
    let imageView: UIImageView=UIImageView()
    
    let btn = UIButton()
    
    static func registerable() -> WisdomClassable {
        return WisdomClassable(register: WisdomProtocolRightProtocol.self, conform: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "WisdomProtocolRightVC"
        
        view.addSubview(imageView)
        view.addSubview(btn)
        
        imageView.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        
        btn.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-30)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(45)
        }
        
        btn.backgroundColor = .black
        btn.setTitle("Router Image", for: .normal)
        btn.addTarget(self, action: #selector(clickRouterImage), for: .touchUpInside)
    }
    
    @objc private func clickRouterImage(){
        // MARK: WisdomRouterImageable 路由 -> 控制器
        let imageClass = WisdomProtocol.getRouterImageable(from: RightImageProtocol.self)
        let image = imageClass?.routerImageable?(param: "img_updata")
        imageView.image = image
    }
}

extension WisdomProtocolRightVC: WisdomRouterControlable {

    @discardableResult
    static func routerControlable(rootVC: UIViewController?, param: Any?) -> Self {
        let vc = Self.init()
        vc.modalPresentationStyle = .fullScreen
        rootVC?.navigationController?.pushViewController(vc, animated: true)
        return vc
    }
}
