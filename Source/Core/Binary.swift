//
//  Binary.swift
//  Pods
//
//  Created by tangjianfeng on 2022/12/22.
//

import UIKit


// ------------------------- Binary Bit ------------------------------------------------ //
// (1). Binary data processing(二进制数据处理)                                              //
// (2). Binary data specifies whether the value of the bit is 1(二进制数据表示该位的值是否为1) //
// (3). ‘NSInteger’ 如果是十进制数，内部会先转成二进制                                         //
// ------------------------------------------------------------------------------------- //

// MARK: Swift 'enum' to binary 'Bit' Protocol
public protocol WisdomBinaryBitable where Self: CaseIterable {
    
    var bitRawValue: NSInteger { get }
}

extension WisdomBinaryBitable {
    
    // MARK: return - [CaseIterable&WisdomBinaryBitable]
    // The rightmost binary value is 1
    // 1. Convert a decimal value to a binary value
    // 2. Combine with your own enumeration class to get an array of values included in the enumeration type
    // 二进制数值 最右边 为 1
    // 1.先将 十进制数值 转成 二进制数值
    // 2.再结合 自己的枚举类，获取 枚举类型 包括的 值数组
    public static func getBinaryable(value: NSInteger)->[Self]{
        return WisdomProtocolCore.getBinaryable(value: value, type: self)
    }
    
    // MARK: return - Bool
    // The rightmost binary value is 1
    // 1. Convert a decimal value to a binary value
    // 2. Combine the enumeration type to determine whether the specified bit of the binary value is 1 or 0, and return it as a Bool value
    // 二进制数值 最右边 为 1
    // 1.先将 十进制数值 转成 二进制数值
    // 2.再结合 枚举类型，判断 二进制数值 指定位， 是否是 1 或者 0，以 Bool 值返回
    public static func isBinaryable(value: NSInteger, state: Self)->Bool{
        return WisdomProtocolCore.isBinaryable(value: value, state: state)
    }
    
    // MARK: return - Bool
    // The rightmost binary value is 1
    // 1. Convert a decimal value to a binary value
    // 2. Combined with its own enumeration type, determine whether the specified bit of the binary value is 1 or 0, and return it as a Bool value
    // 二进制数值 最右边 为 1
    // 1.先将 十进制数值 转成 二进制数值
    // 2.再结合 自己的枚举类型，判断 二进制数值 指定位， 是否是 1 或者 0，以 Bool 值返回
    public func isBinaryable(value: NSInteger)->Bool{
        return WisdomProtocolCore.isBinaryable(value: value, state: self)
    }
}

