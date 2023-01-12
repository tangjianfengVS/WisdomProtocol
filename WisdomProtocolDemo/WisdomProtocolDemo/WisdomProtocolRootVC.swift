//
//  WisdomProtocolRootVC.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/21.
//

import UIKit
import SnapKit
import WisdomProtocol
import WisdomProtocolRight


@objc protocol WisdomProtocolRootProtocol {}

class WisdomProtocolRootVC: UIViewController, WisdomRegisterable, WisdomProtocolRootProtocol {
    
    static func registerable() -> WisdomClassable {
        return WisdomClassable(register: WisdomProtocolRootProtocol.self, conform: Self.self)
    }

    let list = [["WisdomRouterControlable 控制器"+"路由".localizable+"协议"],
                ["WisdomRouterViewable UIView"+"路由".localizable+"协议"],
                //["WisdomRouterClassable Class路由协议"],
                ["WisdomRouterParamable 参数"+"路由".localizable+"协议"],
                ["WisdomRouterImageable UIImage"+"路由".localizable+"协议"],
                ["WisdomLanguageable Language"+"路由".localizable+"协议",
                 "WisdomLanguageable Language"+"路由".localizable+"重置协议"]]
    
    lazy var tableView : UITableView = {
        let tableVi = UITableView(frame: CGRect.zero, style: .grouped)
        tableVi.register(WisdomProtocolCell.self, forCellReuseIdentifier: "\(WisdomProtocolCell.self)")
        
        tableVi.delegate = self
        tableVi.dataSource = self
        tableVi.backgroundColor = .clear
        tableVi.separatorStyle = .none
        return tableVi
    }()
    
    private weak var viewable: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = UIRectEdge.bottom
        title = "WisdomProtocol".localizable
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        startDownTimer(totalTime: 30)
    }
}

extension WisdomProtocolRootVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(WisdomProtocolCell.self)", for: indexPath) as! WisdomProtocolCell
        cell.itemView.infoLabel.text = list[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

extension WisdomProtocolRootVC: UITableViewDelegate, WisdomLanguageable {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                // MARK: WisdomRouterControlable 路由控制器-无参数
                let vcClass = WisdomProtocol.getRouterControlable(from: LeftVCProtocol.self)
                _=vcClass?.routerControlable?(rootVC: self, param: nil)
            default: break
            }
        case 1:
            switch indexPath.row {
            case 0:
                // MARK: WisdomRouterViewable 路由UIView-无参数
                let viClass = WisdomProtocol.getRouterViewable(from: LeftVIProtocol.self)
                viewable=viClass?.routerViewable?(superview: self.view, param: nil)
            default: break
            }
        case 2:
            switch indexPath.row {
            case 0:
                // MARK: WisdomRouterViewable 路由UIView-无参数
                let viClass = WisdomProtocol.getRouterViewable(from: LeftVIProtocol.self)
                viewable=viClass?.routerViewable?(superview: self.view, param: nil)
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {[weak self] in
                    
                    // MARK: WisdomRouterParamable 参数路由协议
                    let param = ["bgColor":"708069","textColor":"FFFFFF","codeColor":"33A1C9"]
                    (self?.viewable as? WisdomRouterParamable)?.routerParamable?(param: param)
                }
            default: break
            }
        case 3:
            switch indexPath.row {
            case 0:
                // MARK: WisdomRouterControlable 路由控制器-无参数
                let vcClass = WisdomProtocol.getRouterControlable(from: RightVCProtocol.self)
                _=vcClass?.routerControlable?(rootVC: self, param: nil)
            default: break
            }
        case 4:
            switch indexPath.row {
            case 0:
                let lan = Self.getCurrentLanguage()
                print(lan)
                let res = Self.updateLanguage(language: lan == .en ? .zh_Hans : .en)
                print(res)
                let res_lan = Self.getCurrentLanguage()
                print(res_lan)
            case 1:
                Self.resetLanguage()
            default: break
            }
        default: break
        }
    }
}


extension WisdomProtocolRootVC: WisdomRouterControlable {
    
    @discardableResult
    static func routerControlable(rootVC: UIViewController?, param: Any?) -> Self {
        let vc = Self.init()
        return vc
    }
}


extension WisdomProtocolRootVC: WisdomTimerable {
    
    func timerable(timerDid currentTime: UInt, timerable: WisdomTimerable){
        print("WisdomProtocolRootVC timerDid: \(currentTime)")
    }

    func timerable(timerEnd timerable: WisdomTimerable){

    }
}


class WisdomProtocolRootUIImage: UIImage, WisdomRegisterable {
    
    static func registerable() -> WisdomClassable {
        return WisdomClassable(register: RightImageProtocol.self, conform: Self.self)
    }
}

extension WisdomProtocolRootUIImage: WisdomRouterImageable {
    
    public static func routerImageable(param: String) -> UIImage? {
        return UIImage(named: param)
    }
}
