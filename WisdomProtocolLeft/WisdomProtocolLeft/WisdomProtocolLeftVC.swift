//
//  WisdomProtocolLeftVC.swift
//  WisdomProtocolLeft
//
//  Created by 汤建锋 on 2022/11/22.
//

import UIKit
import WisdomProtocol
import SnapKit

@objc protocol WisdomProtocolLeftVCProtocol {}

class WisdomProtocolLeftVC: UIViewController, WisdomRegisterable, WisdomProtocolLeftVCProtocol {

    static func registerable() -> WisdomClassable {
        return WisdomClassable(register: WisdomProtocolLeftVCProtocol.self, conform: Self.self)
    }
    
    let sdkLabel = UILabel()
    let vcLabel = UILabel()
    let ableLabel = UILabel()
    let codeLabel = UILabel()
    let descLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.edgesForExtendedLayout = UIRectEdge.bottom
        title = "WisdomProtocolLeftVC"
        
        view.addSubview(sdkLabel)
        view.addSubview(vcLabel)
        view.addSubview(ableLabel)
        view.addSubview(descLabel)
        view.addSubview(codeLabel)
        sdkLabel.snp.makeConstraints { make in
            make.left.equalTo(view).offset(20)
            make.top.equalTo(view).offset(20)
        }
        vcLabel.snp.makeConstraints { make in
            make.left.equalTo(sdkLabel)
            make.top.equalTo(sdkLabel.snp.bottom).offset(20)
        }
        ableLabel.snp.makeConstraints { make in
            make.left.equalTo(sdkLabel)
            make.top.equalTo(vcLabel.snp.bottom).offset(20)
        }
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(sdkLabel)
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(ableLabel.snp.bottom).offset(20)
        }
        codeLabel.snp.makeConstraints { make in
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(descLabel.snp.bottom).offset(20)
        }
        sdkLabel.font = UIFont.systemFont(ofSize: 14)
        sdkLabel.numberOfLines = 0
        vcLabel.font = UIFont.systemFont(ofSize: 14)
        descLabel.font = UIFont.systemFont(ofSize: 14)
        descLabel.numberOfLines = 0
        ableLabel.font = UIFont.systemFont(ofSize: 14)
        codeLabel.font = UIFont.systemFont(ofSize: 14)
        codeLabel.numberOfLines = 0
        codeLabel.textColor = UIColor(red: 100/256, green: 187/256, blue: 170/256, alpha: 1)
        codeLabel.backgroundColor = .black
        
        sdkLabel.text = "控制器信息：\n\n1. 静态库名：WisdomProtocolLeft"
        vcLabel.text = "2. 控制器名：WisdomProtocolLeftVC"
        ableLabel.text = "3. 绑定协议：WisdomProtocolLeftVCProtocol"
        descLabel.text = "4. WisdomProtocolLeftVC 需实现协议: \n\n (1) WisdomRegisterable 注册协议\n\n (2) WisdomRouterControlable 路由协议"
        codeLabel.text = " 5. 路由代码示例：\n\n // MARK: 获取 WisdomRegisterable 协议绑定的控制器\n let vcClass = WisdomProtocol.getRouterControlable(from: WisdomProtocolLeftVCProtocol.self)\n\n // MARK: 调用 WisdomRouterControlable 路由控制器方法(无参数)\n _=vcClass?.routerControlable?(rootVC: self, param: nil)\n"
        
        startDownTimer(totalTime: 10)
    }
}

extension WisdomProtocolLeftVC: WisdomRouterControlable {

    @discardableResult
    static func routerControlable(rootVC: UIViewController?, param: Any?) -> Self {
        let vc = Self.init()
        vc.modalPresentationStyle = .fullScreen
        rootVC?.navigationController?.pushViewController(vc, animated: true)
        return vc
    }
}

extension WisdomProtocolLeftVC: WisdomTimerable {
    
    func timerDid(currentTime: NSInteger) {
        print("WisdomProtocolLeftVC timerDid: \(currentTime)")
    }
    
    func timerEnd() {
        
    }
}


@objc protocol WisdomProtocolLeftVIProtocol {}

class WisdomProtocolLeftVI: UIView, WisdomRegisterable, WisdomProtocolLeftVIProtocol {
    
    static func registerable() -> WisdomClassable {
        return WisdomClassable(register: WisdomProtocolLeftVIProtocol.self, conform: Self.self)
    }
    
    let titleLabel = UILabel()
    let sdkLabel = UILabel()
    let vcLabel = UILabel()
    let ableLabel = UILabel()
    let codeLabel = UILabel()
    let descLabel = UILabel()
    let paramLabel = UILabel()
    
    private(set) lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("❌", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(clickCancelBtn), for: .touchUpInside)
        return button
    }()
    
    @objc private func clickCancelBtn(){
        removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.8, alpha: 1)
        addSubview(titleLabel)
        addSubview(sdkLabel)
        addSubview(vcLabel)
        addSubview(ableLabel)
        addSubview(descLabel)
        addSubview(codeLabel)
        addSubview(cancelButton)
        addSubview(paramLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(10)
        }
        sdkLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        vcLabel.snp.makeConstraints { make in
            make.left.equalTo(sdkLabel)
            make.top.equalTo(sdkLabel.snp.bottom).offset(10)
        }
        ableLabel.snp.makeConstraints { make in
            make.left.equalTo(sdkLabel)
            make.top.equalTo(vcLabel.snp.bottom).offset(10)
        }
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(sdkLabel)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(ableLabel.snp.bottom).offset(10)
        }
        codeLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(descLabel.snp.bottom).offset(10)
        }
        paramLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(codeLabel.snp.bottom).offset(10)
        }
        cancelButton.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(self).offset(10)
            make.width.height.equalTo(30)
        }
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        sdkLabel.font = UIFont.systemFont(ofSize: 14)
        sdkLabel.numberOfLines = 0
        vcLabel.font = UIFont.systemFont(ofSize: 14)
        descLabel.font = UIFont.systemFont(ofSize: 14)
        descLabel.numberOfLines = 0
        ableLabel.font = UIFont.systemFont(ofSize: 14)
        codeLabel.font = UIFont.systemFont(ofSize: 14)
        codeLabel.numberOfLines = 0
        codeLabel.textColor = UIColor(red: 100/256, green: 187/256, blue: 170/256, alpha: 1)
        paramLabel.textColor = codeLabel.textColor
        codeLabel.backgroundColor = .black
        titleLabel.textColor = UIColor.black
        paramLabel.font = UIFont.systemFont(ofSize: 14)
        paramLabel.numberOfLines = 0
        paramLabel.backgroundColor = .black
        
        titleLabel.text = "WisdomProtocolLeftVI"
        sdkLabel.text = "UIView信息：\n\n1. 静态库名：WisdomProtocolLeft"
        vcLabel.text = "2. UIView名：WisdomProtocolLeftVI"
        ableLabel.text = "3. 绑定协议：WisdomProtocolLeftVIProtocol"
        descLabel.text = "4. WisdomProtocolLeftVI 需实现协议: \n\n (1) WisdomRegisterable 注册协议\n\n (2) WisdomRouterViewable 路由协议"
        codeLabel.text = " 5. 路由代码示例：\n\n // MARK: 获取 WisdomRegisterable 协议绑定的UIView\n let viClass = WisdomProtocol.getRouterViewable(from: WisdomProtocolLeftVIProtocol.self)\n\n // MARK: 调用 WisdomRouterViewable 路由UIView方法(无参数)\n _=viClass?.routerViewable?(superview: self.view, param: nil)\n"
        
        startDownTimer(totalTime: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(WisdomProtocolLeftVI.self) deinit")
    }
}

extension WisdomProtocolLeftVI: WisdomRouterViewable {

    static func routerViewable(superview: UIView?, param: Any?) -> Self {
        let vi = Self.init()
        
        if let supervi = superview {
            supervi.addSubview(vi)
            vi.snp.makeConstraints { make in
                make.top.equalTo(supervi).offset(10)
                make.bottom.equalTo(supervi).offset(-20)
                make.left.equalTo(supervi).offset(30)
                make.right.equalTo(supervi).offset(-30)
            }
        }
        return vi
    }
}

extension WisdomProtocolLeftVI: WisdomRouterParamable{
    
    func routerParamable(param: Any?) {
        if let colorDic = param as? [String:Any] {
            
            let model = WisdomProtocolLeftModel.decodable(value: colorDic)
            
//            let dict = model?.ableEncod()
//
//            let json = model?.ableJson() ?? "{\n  \"bgColor\" : \"708069\",\n  \"codeColor\" : \"33A1C9\",\n  \"textColor\" : \"FFFFFF\"\n}"
//            
//            let json_model = WisdomProtocolLeftModel.jsonable(json: json)
            
            if let bgColor = model?.bgColor {
                backgroundColor = bgColor.uicolor()
            }
            if let textColor = model?.textColor {
                titleLabel.textColor = textColor.uicolor()
                sdkLabel.textColor = textColor.uicolor()
                vcLabel.textColor = textColor.uicolor()
                ableLabel.textColor = textColor.uicolor()
                descLabel.textColor = textColor.uicolor()
            }
            if let codeColor = model?.codeColor {
                codeLabel.textColor = codeColor.uicolor()
                paramLabel.textColor = codeColor.uicolor()
                codeLabel.backgroundColor = .white
                paramLabel.backgroundColor = .white
            }
            
            paramLabel.text = " 6. 参数路由代码示例：\n\n (1). WisdomProtocolLeftVI 需实现协议: \n -- WisdomRouterParamable 参数路由协议\n\n // MARK: 调用 路由参数方法\nlet param = ['bgColor':bgColor,'textColor':textColor,'codeColor':codeColor]\n (self?.viewable as? WisdomRouterParamable)?.routerParamable?(param: param)\n"
        }
        
        startAddTimer(startTime: 99)
    }
}


extension WisdomProtocolLeftVI: WisdomTimerable {
    
    func timerDid(currentTime: NSInteger) {
        print("WisdomProtocolLeftVC timerDid: \(currentTime)")
    }
    
    func timerEnd() {
        
    }
}
