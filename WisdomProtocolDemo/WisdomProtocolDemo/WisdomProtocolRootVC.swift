//
//  WisdomProtocolRootVC.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/21.
//

import UIKit
import SnapKit
import WisdomProtocol

@objc protocol WisdomProtocolRootProtocol {}

class WisdomProtocolRootVC: UIViewController, WisdomRegisterable, WisdomProtocolRootProtocol {
    
    static func registerable() -> WisdomClassable {
        return WisdomClassable(register: WisdomProtocolRootProtocol.self, conform: Self.self)
    }

    let list = [["WisdomRouterControlable 路由协议->控制器"],
                ["WisdomRouterViewable 路由协议->视图"],
                ["WisdomRouterClassable 路由协议->Class"],
                ["WisdomRouterParamable 路由协议->参数"]]
    
    lazy var tableView : UITableView = {
        let tableVi = UITableView(frame: CGRect.zero, style: .grouped)
        tableVi.register(WisdomProtocolCell.self, forCellReuseIdentifier: "\(WisdomProtocolCell.self)")
        
        tableVi.delegate = self
        tableVi.dataSource = self
        tableVi.backgroundColor = .clear
        tableVi.separatorStyle = .none
        return tableVi
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "WisdomProtocol"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
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

extension WisdomProtocolRootVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                // MARK: WisdomRouterControlable 路由 -> 控制器 - 无参数
                let vcClass = WisdomProtocol.getRouterControlable(from: LeftProtocol.self)
                _=vcClass?.routerControlable?(rootVC: self, param: nil)
            default: break
            }
//        case 1:
//            switch indexPath.row {
//            case 0:
//                let viClass = WisdomProtocol.getRouterViewable(fromProtocol: WisdomRouterViewProtocol.self)
//                _=viClass?.routerViewable?(superview: self.view, param: nil)
//            default: break
//            }
//        case 2:
//            switch indexPath.row {
//            case 0:
//                let paramClass = WisdomProtocol.getRouterClassable(fromProtocol: WisdomRouterClassProtocol.self)
//                let param = paramClass?.routerClassable?(param: [])
//                (param as? WisdomRouterParamable)?.routerParamable?(param: [])
//
//                let ss = WisdomProtocol.getClassable(fromProtocol: WisdomRouterClassProtocol.self)
//                print("")
//            default: break
//            }
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
