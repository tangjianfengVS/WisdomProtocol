//
//  WisdomProtocolConfig.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2022/11/22.
//

import UIKit
import WisdomProtocolLeft

// 路由协议 -> Root 控制器
let RootProtocol = WisdomProtocol.create(projectName: "WisdomProtocol", protocolName: "WisdomProtocolRootProtocol")!

// 路由协议 -> Left 控制器
let LeftProtocol = WisdomProtocol.create(projectName: "WisdomProtocolLeft", protocolName: "WisdomProtocolLeftProtocol")!