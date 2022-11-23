//
//  WisdomProtocolConfig.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/22.
//

import UIKit
import WisdomProtocol
import WisdomProtocolLeft

// 路由协议 -> Root 控制器
let RootProtocol = WisdomProtocol.create(projectName: "WisdomProtocolDemo", protocolName: "WisdomProtocolRootProtocol")!

// 路由协议 -> Left 控制器
let LeftVCProtocol = WisdomProtocolLeft.LeftVCProtocol

// 路由协议 -> Left UIView
let LeftVIProtocol = WisdomProtocol.create(projectName: "WisdomProtocolLeft", protocolName: "WisdomProtocolLeftVIProtocol")!
