//
//  Weak.swift
//  WisdomProtocol
//
//  Created by tangjianfeng on 2023/3/2.
//

import Foundation


public struct WisdomWeakable<T: AnyObject> {
    
    public private(set) weak var able : T?
    
    public init (able: T) {
        self.able = able
    }
    
    mutating func resetable(){
        able = nil
    }
}

extension WisdomWeakable: Equatable {
    
    public static func == (lhs: WisdomWeakable<T>, rhs: WisdomWeakable<T>) -> Bool {
        if let lhsable = lhs.able, let rhsable = rhs.able  {
            let lhs_str = Unmanaged<AnyObject>.passUnretained(lhsable).toOpaque()
            let rhs_str = Unmanaged<AnyObject>.passUnretained(rhsable).toOpaque()
            if lhs_str == rhs_str {
                return true
            }
        }
        return false
    }
}
