//
//  WisdomProtocolRight.swift
//  WisdomProtocolRight
//
//  Created by 汤建锋 on 2022/11/22.
//

import WisdomProtocol


public let RightVCProtocol: Protocol = {
    return WisdomProtocol.registerable(from: WisdomProtocolRightProtocol.self, classable: WisdomProtocolRightVC.self)
}()

public let RightImageProtocol: Protocol = RightImageable.self

// Image Protocol
@objc protocol RightImageable {}
