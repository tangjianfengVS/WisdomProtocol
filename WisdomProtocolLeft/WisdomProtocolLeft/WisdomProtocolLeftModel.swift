//
//  WisdomProtocolLeftModel.swift
//  WisdomProtocolLeft
//
//  Created by 汤建锋 on 2022/11/23.
//

import UIKit
import WisdomProtocol

class WisdomProtocolLeftModel: Codable, WisdomCodingable {
    
    var bgColor: String?
    
    var textColor: String?
    
    var codeColor: String?
}

extension WisdomProtocolLeftModel: WisdomTimerable {

    func timerable(timerDid currentTime: UInt, timerable: WisdomTimerable){
        print("WisdomProtocolLeftModel timerDid: \(currentTime)")
    }

    func timerable(timerEnd timerable: WisdomTimerable){

    }
}


struct WisdomProtocolLeftRawModel: Codable, WisdomCodingable {
    
    var bgColor: String?
    
    var textColor: String?
    
    var codeColor: String?
}

//extension WisdomProtocolLeftRawModel: WisdomSwiftTimerable {
//
//    func timerable(swiftTimerDid currentTime: NSInteger, timerable: WisdomSwiftTimerable) {
//        print("\(self.self) swiftTimerDid: \(currentTime)")
//    }
//
//    func timerable(swiftTimerDid timerable: WisdomSwiftTimerable) {
//
//    }
//}



extension String {
    /// 十六进制字符串颜色转为UIColor
    /// - Parameter alpha: 透明度
    func uicolor(alpha: CGFloat = 1.0) -> UIColor {
        // 存储转换后的数值
        var red: UInt64 = 0, green: UInt64 = 0, blue: UInt64 = 0
        var hex = self
        // 如果传入的十六进制颜色有前缀，去掉前缀
        if hex.hasPrefix("0x") || hex.hasPrefix("0X") {
            hex = String(hex[hex.index(hex.startIndex, offsetBy: 2)...])
        } else if hex.hasPrefix("#") {
            hex = String(hex[hex.index(hex.startIndex, offsetBy: 1)...])
        }
        // 如果传入的字符数量不足6位按照后边都为0处理，当然你也可以进行其它操作
        if hex.count < 6 {
            for _ in 0..<6-hex.count {
                hex += "0"
            }
        }

        // 分别进行转换
        // 红
        Scanner(string: String(hex[..<hex.index(hex.startIndex, offsetBy: 2)])).scanHexInt64(&red)
        // 绿
        Scanner(string: String(hex[hex.index(hex.startIndex, offsetBy: 2)..<hex.index(hex.startIndex, offsetBy: 4)])).scanHexInt64(&green)
        // 蓝
        Scanner(string: String(hex[hex.index(startIndex, offsetBy: 4)...])).scanHexInt64(&blue)

        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
}
