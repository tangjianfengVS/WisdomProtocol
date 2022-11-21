//
//  ViewController.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/11.
//

import UIKit


// 1. 数据/页面 路由器
class WisdomProtocolCell: UITableViewCell {

    let itemView = WisdomProtocolItem(frame: .zero)

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

class WisdomProtocolItem: UIView {
    
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
