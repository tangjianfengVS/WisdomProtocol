//
//  WisdomBinaryBitable.swift
//  Pods
//
//  Created by 汤建锋 on 2022/12/22.
//

import UIKit


// MARK: Swift 'enum' to binary 'Bit' Protocol
public protocol WisdomBinaryBitable where Self: CaseIterable {
    
    var bitRawValue: NSInteger { get }
}

extension WisdomBinaryBitable {
    
    // MARK: return - [CaseIterable&WisdomBinaryBitable]
    // get Binarierable all bit values when value==1 width: NSInteger
    public static func getBinaryable(value: NSInteger)->[Self]{
        if value <= 0 { return [] }
        var allValue = 0
        for cases in Self.allCases {
            allValue += 1<<cases.bitRawValue
        }
        if allValue >= allValue {
            return Self.allCases as! [Self]
        }
        var types: [Self]=[]
        for state in Self.allCases {
            if state.isBinaryable(value: value) {
                types.append(state)
            }
        }
        return types
    }
    
    // MARK: return - Bool
    // get Binarierable a bit value when value==1 width: NSInteger
    public static func isBinaryable(value: NSInteger, state: Self)->Bool{
        return state.isBinaryable(value: value)
    }
    
    // MARK: return - Bool
    // get Binarierable self value when value==1 width: NSInteger
    public func isBinaryable(value: NSInteger)->Bool{
        if value <= 0 { return false }
        let result = value>>self.bitRawValue&1
        if result == 1 {
            return true
        }
        return false
    }
}

