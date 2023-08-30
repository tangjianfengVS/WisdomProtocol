//
//  WisdomProtocolLeft.swift
//  WisdomProtocolLeft
//
//  Created by 汤建锋 on 2022/11/22.
//

import Foundation
import WisdomProtocol

class WisdomProtocolLeft {

}

public let LeftVCProtocol: Protocol = {
    return WisdomProtocol.registerable(classable: WisdomClassable(register: WisdomProtocolLeftVCProtocol.self, conform: WisdomProtocolLeftVC.self))
}()

