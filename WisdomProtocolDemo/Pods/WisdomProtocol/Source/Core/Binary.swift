//
//  Binary.swift
//  Pods
//
//  Created by tangjianfeng on 2022/12/22.
//

import UIKit

// ------------------------- Binary Bit ------------------------- //
// (1). Binary data processing                                    //
// (2). Binary data specifies whether the value of the bit is 1   //
// (3). ‘NSInteger’ 如果是十进制数，内部会先转成二进制                   //
// -------------------------------------------------------------- //

// MARK: Swift 'enum' to binary 'Bit' Protocol
public protocol WisdomBinaryBitable where Self: CaseIterable {
    
    var bitRawValue: NSInteger { get }
}

extension WisdomBinaryBitable {
    
    // MARK: return - [CaseIterable&WisdomBinaryBitable]
    // get Binarierable all bit values when value==1 width: NSInteger
    public static func getBinaryable(value: NSInteger)->[Self]{
        return WisdomProtocolCore.getBinaryable(value: value, type: self)
    }
    
    // MARK: return - Bool
    // get Binarierable a bit value when value==1 width: NSInteger
    public static func isBinaryable(value: NSInteger, state: Self)->Bool{
        return WisdomProtocolCore.isBinaryable(value: value, state: state)
    }
    
    // MARK: return - Bool
    // get Binarierable self value when value==1 width: NSInteger
    public func isBinaryable(value: NSInteger)->Bool{
        return WisdomProtocolCore.isBinaryable(value: value, state: self)
    }
}

