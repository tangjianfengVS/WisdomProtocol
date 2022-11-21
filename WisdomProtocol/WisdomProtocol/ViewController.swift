//
//  ViewController.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/11.
//

import UIKit

class ViewController: UIViewController {
    
    let list = [["路由 WisdomRouterControlable -> 控制器"],
                ["路由 WisdomRouterViewable -> 视图"],
                ["类型 WisdomRouterClassable -> 参数"]]
    
    lazy var tableView : UITableView = {
        let tableVi = UITableView(frame: CGRect.zero, style: .grouped)
        tableVi.register(ViewControllerCell.self, forCellReuseIdentifier: "\(ViewControllerCell.self)")
        
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

extension ViewController : UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ViewControllerCell.self)", for: indexPath) as! ViewControllerCell
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


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let vcClass = WisdomProtocol.getRouterControlable(fromProtocol: WisdomRouterProtocol.self)
                _=vcClass?.routerControlable?(rootVC: self, param: nil)
            default: break
            }
        case 1:
            switch indexPath.row {
            case 0:
                let viClass = WisdomProtocol.getRouterViewable(fromProtocol: WisdomRouterViewProtocol.self)
                _=viClass?.routerViewable?(superview: self.view, param: nil)
            default: break
            }
        case 2:
            switch indexPath.row {
            case 0:
                let paramClass = WisdomProtocol.getRouterClassable(fromProtocol: WisdomRouterClassProtocol.self)
                let param = paramClass?.routerClassable?(param: [])
                (param as? WisdomRouterParamable)?.routerParamable?(param: [])
                
                let ss = WisdomProtocol.getClassable(fromProtocol: WisdomRouterClassProtocol.self)
                print("")
            default: break
            }
        default: break
        }
    }
}


// 1. 数据/页面 路由器
class ViewControllerCell: UITableViewCell {

    let itemView = ViewControllerItem(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear

        contentView.addSubview(itemView)

        itemView.snp.makeConstraints { make in
            make.bottom.top.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-1)
            make.left.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-15)
        }
        itemView.backgroundColor = UIColor.black
        itemView.layer.masksToBounds = true
        itemView.layer.cornerRadius = 10
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {

    }
}

class ViewControllerItem: UIView {
    
    let imageView = UIImageView(image: UIImage(named: "G_Next_Gray"))

    let infoLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(imageView)
        addSubview(infoLabel)
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-12)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
