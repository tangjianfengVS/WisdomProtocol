//
//  RCore.swift
//  WisdomProtocol
//
//  Created by 汤建锋 on 2023/8/16.
//

import UIKit


extension WisdomProtocolCore {
    
    @objc class func registerRouterable() {
        let start = CFAbsoluteTimeGetCurrent()
        let c = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: c)
        let autoTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoTypes, Int32(c))

        var list: [Int:Int] = [0: c/2, c/2+1: c]//23320-0.019
        if c>30000 {
            list = [0:c/6, c/6+1:c/6*2, c/6*2+1:c/6*3, c/6*3+1:c/6*4, c/6*4+1:c/6*5, c/6*5+1:c]//30616-0.065
        }else if c>28000 {
            list = [0:c/5, c/5+1:c/5*2, c/5*2+1:c/5*3, c/5*3+1:c/5*4, c/5*4+1:c]
        }else if c>26000 {
            list = [0:c/4, c/4+1:c/2, c/2+1:c/4*3, c/4*3+1:c]
        }else if c>24000 {
            list = [0:c/3, c/3+1:c/3*2, c/3*2+1:c]
        }
        let protocolQueue = DispatchQueue(label: "WisdomProtocolCoreQueue", attributes: DispatchQueue.Attributes.concurrent)
        for index in list { register(types: types, begin: index.key, end: index.value) }

        func register(types: UnsafeMutablePointer<AnyClass>, begin: Int, end: Int) {
            protocolQueue.async {
                for index in begin ..< end {
                    if class_conformsToProtocol(types[index], WisdomRouterRegisterable.self) {
                        if let classable: AnyClass = types[index] as? AnyClass, let aProtocol = (classable as? WisdomRouterRegisterable.Type)?.registerable() {
                            _=registerableConfig(register: aProtocol, conform: classable)
                        }
                    }
                }
            }
        }
        protocolQueue.sync(flags: .barrier) {
            types.deinitialize(count: c)
            types.deallocate()
            print("[WisdomProtocol] Queue Took "+"\(CFAbsoluteTimeGetCurrent()-start) \(c) \(list.count)")
        }
    }
}
